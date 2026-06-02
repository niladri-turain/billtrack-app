import 'dart:io';

import 'package:billtrack/features/product/widget/product_category_widget.dart';
import 'package:billtrack/features/product/widget/product_information_widget.dart';
import 'package:billtrack/features/product/widget/price_product_varient_section.dart';
import 'package:billtrack/features/product/widget/add_new_section_widget.dart';
import 'package:billtrack/widgets/image_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  String? imageError;

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
  final _formKey = GlobalKey<FormBuilderState>();
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
          ),
        ],
      );

      if (!mounted) return;

      setState(() {
        _variantControllers[index].imageError = null;
        if (croppedFile != null) {
          _variantControllers[index].selectedImage = XFile(croppedFile.path);
        } else {
          _variantControllers[index].selectedImage = image;
        }
      });
    } catch (e) {
      debugPrint("Error picking image: $e");
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
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _hsnController.dispose();
    _gstController.dispose();
    for (var v in _variantControllers) {
      v.dispose();
    }
    super.dispose();
  }

  void _saveProduct() {
    bool isImageValid = true;
    setState(() {
      for (var v in _variantControllers) {
        if (v.selectedImage == null) {
          v.imageError = 'Image is required';
          isImageValid = false;
        } else {
          v.imageError = null;
        }
      }
    });

    if ((_formKey.currentState?.saveAndValidate() ?? false) && isImageValid) {
      final formData = _formKey.currentState?.value;
      debugPrint('Saving Product Data: $formData');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product details saved successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        isInvoiceDetails: true,
        title: 'Add New Product',
        onBackPress: () => Navigator.pop(context),
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                      }
                    },
                    onSubSubCategoryChanged: (val) => setState(() => _selectedSubSubCategory = val),
                  );
                },
              ),
              const SizedBox(height: 20),
              BasicInformationSection(
                titleController: _titleController,
                hsnController: _hsnController,
                gstController: _gstController,
              ),
              const SizedBox(height: 20),
              ..._variantControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final v = entry.value;
                return PricingVariantSection(
                  index: index + 1,
                  isPrimary: _primarySectionIndex == index,
                  showDelete: _variantControllers.length > 1,
                  onDelete: () => _deleteVariant(index),
                  onPrimaryChanged: (val) {
                    if (val == true) setState(() => _primarySectionIndex = index);
                  },
                  mrpController: v.mrpController,
                  costController: v.costController,
                  sellingController: v.sellingController,
                  skuController: v.skuController,
                  barCodeController: v.barCodeController,
                  discountController: v.discountController,
                  stockController: v.stockController,
                  manufactureDateController: v.manufactureDateController,
                  expiryDateController: v.expiryDateController,
                  selectedMaterial: v.selectedMaterial,
                  selectedColor: v.selectedColor,
                  selectedSize: v.selectedSize,
                  selectedStatus: v.selectedStatus,
                  onMaterialChanged: (val) => setState(() => v.selectedMaterial = val),
                  onColorChanged: (val) => setState(() => v.selectedColor = val),
                  onSizeChanged: (val) => setState(() => v.selectedSize = val),
                  onStatusChanged: (val) => setState(() => v.selectedStatus = val),
                  metaTitleController: v.metaTitleController,
                  metaKeywordsController: v.metaKeywordsController,
                  metaDescriptionController: v.metaDescriptionController,
                  shortDescriptionController: v.shortDescriptionController,
                  fullDescriptionController: v.fullDescriptionController,
                  selectedImage: v.selectedImage != null ? File(v.selectedImage!.path) : null,
                  onPickImage: () => _pickImage(index),
                  imageError: v.imageError,
                );
              }),
              AddNewSectionWidget(onTap: _addVariant),
              const SizedBox(height: 30),
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
                      child: const Text('Save Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
