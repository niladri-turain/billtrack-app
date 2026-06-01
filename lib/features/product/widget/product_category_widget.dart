import 'package:flutter/material.dart';
import 'add_product_wudget.dart';

class ProductCategorySection extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedSubCategory;
  final String? selectedSubSubCategory;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onSubCategoryChanged;
  final ValueChanged<String?> onSubSubCategoryChanged;
  final List<String> categories;
  final List<String> subCategories;
  final List<String> subSubCategories;
  final bool isCategoryLoading;
  final bool isSubCategoryLoading;
  final bool isSubSubCategoryLoading;

  const ProductCategorySection({
    super.key,
    this.selectedCategory,
    this.selectedSubCategory,
    this.selectedSubSubCategory,
    required this.onCategoryChanged,
    required this.onSubCategoryChanged,
    required this.onSubSubCategoryChanged,
    this.categories = const [],
    this.subCategories = const [],
    this.subSubCategories = const [],
    this.isCategoryLoading = false,
    this.isSubCategoryLoading = false,
    this.isSubSubCategoryLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdownField(
            label: 'Product Category',
            hintText: isCategoryLoading ? 'Loading...' : 'Select Category',
            isMandatory: true,
            items: categories,
            value: selectedCategory,
            onChanged: onCategoryChanged,
            isLoading: isCategoryLoading,
          ),
          const SizedBox(height: 20),
          CustomDropdownField(
            label: 'Product Sub Category',
            hintText: isSubCategoryLoading 
                ? 'Loading...' 
                : (selectedCategory == null ? 'Select Category first' : 'Select Sub Category'),
            items: subCategories,
            value: selectedSubCategory,
            onChanged: onSubCategoryChanged,
            isLoading: isSubCategoryLoading || selectedCategory == null,
          ),
          const SizedBox(height: 20),
          CustomDropdownField(
            label: 'Product Sub Sub Category',
            hintText: isSubSubCategoryLoading 
                ? 'Loading...' 
                : (selectedSubCategory == null ? 'Select Sub Category first' : 'Select Sub Sub Category'),
            items: subSubCategories,
            value: selectedSubSubCategory,
            onChanged: onSubSubCategoryChanged,
            isLoading: isSubSubCategoryLoading || selectedSubCategory == null,
          ),
        ],
      ),
    );
  }
}
