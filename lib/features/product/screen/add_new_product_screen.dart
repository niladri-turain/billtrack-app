import 'dart:io';

import 'package:billtrack/features/product/widget/product_category_widget.dart';
import 'package:billtrack/features/product/widget/product_information_widget.dart';
import 'package:billtrack/features/product/widget/price_product_varient_section.dart';
import 'package:billtrack/features/product/widget/add_new_section_widget.dart';
import 'package:billtrack/widgets/image_picker_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_app_bar.dart';
import 'package:billtrack/features/product/provider/business_category_provider.dart';
import 'package:billtrack/features/product/provider/sub_category_provider.dart';
import 'package:billtrack/features/product/provider/sub_sub_category_provider.dart';
import 'package:billtrack/features/product/provider/hsn_provider.dart';


class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class VariantControllerGroup {
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController sellingController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController barCodeController = TextEditingController();

  final TextEditingController stockController = TextEditingController();
  final TextEditingController manufactureDateController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  // SEO & Description Controllers
  final TextEditingController metaTitleController = TextEditingController();
  final TextEditingController metaKeywordsController = TextEditingController();
  final TextEditingController metaDescriptionController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController fullDescriptionController = TextEditingController();

  String? selectedMaterial;
  String? selectedColor;
  String? selectedSize;
  String? selectedStatus = 'Active';
  XFile? selectedImage;

  void dispose() {
    mrpController.dispose();
    costController.dispose();
    sellingController.dispose();
    discountController.dispose();
    stockController.dispose();
    manufactureDateController.dispose();
    expiryDateController.dispose();
    metaTitleController.dispose();
    metaKeywordsController.dispose();
    metaDescriptionController.dispose();
    shortDescriptionController.dispose();
    fullDescriptionController.dispose();
  }
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _hsnController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();

  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedSubSubCategory;

  final List<VariantControllerGroup> _variantControllers = [VariantControllerGroup()];
  int _primarySectionIndex = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BusinessCategoryProvider>().fetchBusinessCategories();
      context.read<HSNProvider>().fetchHSNCodes();
    });
  }

  Future<void> _pickImage(int index) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ImagePickerBottomSheet(
        onCameraTap: () => _getImage(index, ImageSource.camera),
        onGalleryTap: () => _getImage(index, ImageSource.gallery),
      ),
    );
  }

  Future<void> _getImage(int index, ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (image == null) return;

      // Small delay ensures the camera UI has fully dismissed and the file is ready
      await Future.delayed(const Duration(milliseconds: 600));

      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: const Color(0xFF4338CA),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      if (!mounted) return;

      setState(() {
        if (croppedFile != null) {
          _variantControllers[index].selectedImage = XFile(croppedFile.path);
        } else {
          // If crop is cancelled/skipped, use the original picked image
          _variantControllers[index].selectedImage = image;
        }
      });
    } catch (e) {
      debugPrint("Error picking/cropping image: $e");
    }
  }

  void _addVariant() {
    setState(() {
      _variantControllers.add(VariantControllerGroup());
    });
  }

  void _deleteVariant(int index) {
    if (_variantControllers.length > 1) {
      setState(() {
        _variantControllers[index].dispose();
        _variantControllers.removeAt(index);
        if (_primarySectionIndex >= _variantControllers.length) {
          _primarySectionIndex = 0;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one variant is required')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _hsnController.dispose();
    _gstController.dispose();
    for (var controller in _variantControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveProduct() {
    // Collect and log data for verification
    final productData = {
      'title': _titleController.text,
      'hsn': _hsnController.text,
      'gst': _gstController.text,
      'category': _selectedCategory,
      'subCategory': _selectedSubCategory,
      'subSubCategory': _selectedSubSubCategory,
      'variants': _variantControllers.asMap().entries.map((entry) {
        final idx = entry.key;
        final v = entry.value;
        return {
          'isPrimary': _primarySectionIndex == idx,
          'mrp': v.mrpController.text,
          'cost': v.costController.text,
          'selling': v.sellingController.text,
          'discount': v.discountController.text,
          'stock': v.stockController.text,
          'material': v.selectedMaterial,
          'color': v.selectedColor,
          'size': v.selectedSize,
          'status': v.selectedStatus,
          'seo': {
            'metaTitle': v.metaTitleController.text,
            'metaKeywords': v.metaKeywordsController.text,
            'metaDescription': v.metaDescriptionController.text,
            'shortDescription': v.shortDescriptionController.text,
            'fullDescription': v.fullDescriptionController.text,
          }
        };
      }).toList(),
    };

    debugPrint('Saving Product Data: $productData');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product details saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        isInvoiceDetails: true,
        title: 'Add New Product',
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Image Upload Section

            const SizedBox(height: 20),
            // Product Category Section
            Consumer3<BusinessCategoryProvider, SubCategoryProvider, SubSubCategoryProvider>(
              builder: (context, businessProvider, subProvider, subSubProvider, child) {
                return ProductCategorySection(
                  isCategoryLoading: businessProvider.isLoading,
                  isSubCategoryLoading: subProvider.isLoading,
                  isSubSubCategoryLoading: subSubProvider.isLoading,
                  categories: businessProvider.categories.map((e) => e.name).toList(),
                  subCategories: subProvider.subCategories.map((e) => e.value).toList(),
                  subSubCategories: subSubProvider.subSubCategories.map((e) => e.name).toList(),
                  selectedCategory: _selectedCategory,
                  selectedSubCategory: _selectedSubCategory,
                  selectedSubSubCategory: _selectedSubSubCategory,
                  onCategoryChanged: (val) {
                    setState(() {
                      _selectedCategory = val;
                      _selectedSubCategory = null;
                      _selectedSubSubCategory = null;
                    });
                    if (val != null) {
                      final category = businessProvider.categories.firstWhere((e) => e.name == val);
                      context.read<SubCategoryProvider>().fetchSubCategories(category.id);
                    } else {
                      context.read<SubCategoryProvider>().clearSubCategories();
                      context.read<SubSubCategoryProvider>().clearSubSubCategories();
                    }
                  },
                  onSubCategoryChanged: (val) {
                    setState(() {
                      _selectedSubCategory = val;
                      _selectedSubSubCategory = null;
                    });
                    if (val != null && _selectedCategory != null) {
                      final category = businessProvider.categories.firstWhere((e) => e.name == _selectedCategory);
                      final subCategory = subProvider.subCategories.firstWhere((e) => e.value == val);
                      context.read<SubSubCategoryProvider>().fetchSubSubCategories(category.id, subCategory.id);
                    } else {
                      context.read<SubSubCategoryProvider>().clearSubSubCategories();
                    }
                  },
                  onSubSubCategoryChanged: (val) => setState(() => _selectedSubSubCategory = val),
                );
              },
            ),
            const SizedBox(height: 20),
            // Basic Information Section
            BasicInformationSection(
              titleController: _titleController,
              hsnController: _hsnController,
              gstController: _gstController,
            ),
            const SizedBox(height: 20),



            // Dynamic Pricing & Product Variants Sections
            ..._variantControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controllerGroup = entry.value;
              return PricingVariantSection(
                index: index + 1,
                isPrimary: _primarySectionIndex == index,
                showDelete: _variantControllers.length > 1,
                onDelete: () => _deleteVariant(index),
                onPrimaryChanged: (val) {
                  if (val == true) {
                    setState(() {
                      _primarySectionIndex = index;
                    });
                  }
                },
                mrpController: controllerGroup.mrpController,
                costController: controllerGroup.costController,
                sellingController: controllerGroup.sellingController,
                skuController: controllerGroup.skuController,
                barCodeController: controllerGroup.barCodeController,
                discountController: controllerGroup.discountController,
                stockController: controllerGroup.stockController,
                manufactureDateController: controllerGroup.manufactureDateController,
                expiryDateController: controllerGroup.expiryDateController,
                selectedMaterial: controllerGroup.selectedMaterial,
                selectedColor: controllerGroup.selectedColor,
                selectedSize: controllerGroup.selectedSize,
                selectedStatus: controllerGroup.selectedStatus,
                onMaterialChanged: (val) => setState(() => controllerGroup.selectedMaterial = val),
                onColorChanged: (val) => setState(() => controllerGroup.selectedColor = val),
                onSizeChanged: (val) => setState(() => controllerGroup.selectedSize = val),
                onStatusChanged: (val) => setState(() => controllerGroup.selectedStatus = val),
                metaTitleController: controllerGroup.metaTitleController,
                metaKeywordsController: controllerGroup.metaKeywordsController,
                metaDescriptionController: controllerGroup.metaDescriptionController,
                shortDescriptionController: controllerGroup.shortDescriptionController,
                fullDescriptionController: controllerGroup.fullDescriptionController,
                selectedImage: controllerGroup.selectedImage != null ? File(controllerGroup.selectedImage!.path) : null,
                onPickImage: () => _pickImage(index),
              );
            }),

            // Add Variant Button
            AddNewSectionWidget(onTap: _addVariant),
            const SizedBox(height: 30),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27C840),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save Product Details',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
