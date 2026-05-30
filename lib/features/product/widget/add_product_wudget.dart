import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isMandatory;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefix;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isMandatory = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            children: isMandatory
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefix,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDateField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isMandatory;
  final TextEditingController? controller;

  const CustomDateField({
    super.key,
    required this.label,
    required this.hintText,
    this.isMandatory = false,
    this.controller,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller?.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            children: isMandatory
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: IgnorePointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20, color: Color(0xFF64748B)),
                hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isMandatory;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.isMandatory = false,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            children: isMandatory
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(hintText, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF334155))),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class BasicInformationSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController hsnController;
  final TextEditingController gstController;

  const BasicInformationSection({
    super.key,
    required this.titleController,
    required this.hsnController,
    required this.gstController,
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
          const Text(
            'Basic Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Product Title',
            hintText: 'Enter product title',
            isMandatory: true,
            controller: titleController,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'HSN Code',
                  hintText: 'Search HSN Code...',
                  isMandatory: true,
                  controller: hsnController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  label: 'GST Rate (%)',
                  hintText: '',
                  isMandatory: true,
                  keyboardType: TextInputType.number,
                  controller: gstController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

  const ProductCategorySection({
    super.key,
    this.selectedCategory,
    this.selectedSubCategory,
    this.selectedSubSubCategory,
    required this.onCategoryChanged,
    required this.onSubCategoryChanged,
    required this.onSubSubCategoryChanged,
    this.categories = const ['Electronics', 'Grocery', 'Fashion', 'Others'],
    this.subCategories = const [],
    this.subSubCategories = const [],
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
            hintText: 'Select Type...',
            isMandatory: true,
            items: categories,
            value: selectedCategory,
            onChanged: onCategoryChanged,
          ),
          const SizedBox(height: 20),
          CustomDropdownField(
            label: 'Product Sub Category',
            hintText: 'Select Type first',
            items: subCategories,
            value: selectedSubCategory,
            onChanged: onSubCategoryChanged,
          ),
          const SizedBox(height: 20),
          CustomDropdownField(
            label: 'Product Sub Sub Category',
            hintText: 'Select Product Category first',
            items: subSubCategories,
            value: selectedSubSubCategory,
            onChanged: onSubSubCategoryChanged,
          ),
        ],
      ),
    );
  }
}

class PricingVariantSection extends StatelessWidget {
  final int index;
  final bool isPrimary;
  final VoidCallback onDelete;
  final bool showDelete;
  final ValueChanged<bool?>? onPrimaryChanged;
  final TextEditingController mrpController;
  final TextEditingController costController;
  final TextEditingController sellingController;
  final TextEditingController discountController;
  final TextEditingController stockController;
  final TextEditingController manufactureDateController;
  final TextEditingController expiryDateController;
  final String? selectedMaterial;
  final String? selectedColor;
  final String? selectedSize;
  final String? selectedStatus;
  final ValueChanged<String?> onMaterialChanged;
  final ValueChanged<String?> onColorChanged;
  final ValueChanged<String?> onSizeChanged;
  final ValueChanged<String?> onStatusChanged;

  final TextEditingController metaTitleController;
  final TextEditingController metaKeywordsController;
  final TextEditingController metaDescriptionController;
  final TextEditingController shortDescriptionController;
  final TextEditingController fullDescriptionController;

  const PricingVariantSection({
    super.key,
    required this.index,
    this.isPrimary = false,
    required this.onDelete,
    this.showDelete = false,
    this.onPrimaryChanged,
    required this.mrpController,
    required this.costController,
    required this.sellingController,
    required this.discountController,
    required this.stockController,
    required this.manufactureDateController,
    required this.expiryDateController,
    this.selectedMaterial,
    this.selectedColor,
    this.selectedSize,
    this.selectedStatus,
    required this.onMaterialChanged,
    required this.onColorChanged,
    required this.onSizeChanged,
    required this.onStatusChanged,
    required this.metaTitleController,
    required this.metaKeywordsController,
    required this.metaDescriptionController,
    required this.shortDescriptionController,
    required this.fullDescriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.2)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pricing & Product Variants - Section $index',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4338CA),
                    ),
                  ),
                  if (isPrimary)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E7FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'PRIMARY',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4338CA),
                        ),
                      ),
                    ),
                ],
              ),
              if (showDelete)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFFEF2F2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E8F0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: isPrimary,
                  onChanged: onPrimaryChanged,
                  activeColor: const Color(0xFF4338CA),
                ),
                const Text(
                  'Mark as Primary Product',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFF1F5F9)),
          const SizedBox(height: 15),
          const Text(
            'Variant Image',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              // Media Upload Logic
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image_outlined, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Media',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Add media for this product',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF94A3B8)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'MRP Price',
                  hintText: '0.00',
                  controller: mrpController,
                  isMandatory: true,
                  prefix: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('₹', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomTextField(
                  label: 'Cost Price',
                  hintText: '0.00',
                  controller: costController,
                  isMandatory: true,
                  prefix: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('₹', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'Selling Price',
                  hintText: '0.00',
                  controller: sellingController,
                  isMandatory: true,
                  prefix: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('₹', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomTextField(
                  label: 'Discount (%)',
                  hintText: '0',
                  controller: discountController,
                  isMandatory: false,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 180,
            child: CustomTextField(
              label: 'Total Stock',
              hintText: '0',
              controller: stockController,
              isMandatory: true,
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FINAL CALCULATED PRICE',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4338CA),
                  ),
                ),
                Text(
                  '₹ 0',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4338CA),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Product Variants',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFFF1F5F9)),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomDropdownField(
                  label: 'Material',
                  hintText: 'Select',
                  value: selectedMaterial,
                  items: const ['Cotton', 'Silk', 'Polyester'],
                  onChanged: onMaterialChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomDropdownField(
                  label: 'Color',
                  hintText: 'Select',
                  value: selectedColor,
                  items: const ['Red', 'Blue', 'Green'],
                  onChanged: onColorChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomDropdownField(
                  label: 'Shirt Size',
                  hintText: 'Select',
                  value: selectedSize,
                  items: const ['S', 'M', 'L', 'XL'],
                  onChanged: onSizeChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomDateField(
            label: 'Manufacture Date (optional)',
            hintText: 'dd/mm/yyyy',
            controller: manufactureDateController,
          ),
          const SizedBox(height: 20),
          CustomDateField(
            label: 'Expiry Date (optional)',
            hintText: 'dd/mm/yyyy',
            controller: expiryDateController,
          ),
          const SizedBox(height: 20),
          CustomDropdownField(
            label: 'Variant Status',
            hintText: 'Active',
            value: selectedStatus,
            items: const ['Active', 'Inactive'],
            onChanged: onStatusChanged,
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          const Text(
            'SEO Metadata',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            label: 'Meta Title (optional)',
            hintText: 'Enter meta title...',
            controller: metaTitleController,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Meta Keywords (optional)',
            hintText: 'e.g. shirt, cotton, blue',
            controller: metaKeywordsController,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Meta Description (optional)',
            hintText: 'Enter meta description...',
            maxLines: 3,
            controller: metaDescriptionController,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Short Description',
            hintText: 'Write a short description for this variant...',
            maxLines: 4,
            controller: shortDescriptionController,
          ),
          const SizedBox(height: 25),
          const Text(
            'Full Description',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF334155)),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              maxLines: 8,
              controller: fullDescriptionController,
              decoration: const InputDecoration(
                hintText: 'Write a detailed, formatted description for this variant...',
                hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SEOMetadataSection extends StatelessWidget {
  final TextEditingController metaTitleController;
  final TextEditingController metaKeywordsController;
  final TextEditingController metaDescriptionController;
  final TextEditingController shortDescriptionController;
  final TextEditingController fullDescriptionController;

  const SEOMetadataSection({
    super.key,
    required this.metaTitleController,
    required this.metaKeywordsController,
    required this.metaDescriptionController,
    required this.shortDescriptionController,
    required this.fullDescriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SEO Metadata',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 15),
        CustomTextField(
          label: 'Meta Title (optional)',
          hintText: 'Enter meta title...',
          controller: metaTitleController,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Meta Keywords (optional)',
          hintText: 'e.g. shirt, cotton, blue',
          controller: metaKeywordsController,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Meta Description (optional)',
          hintText: 'Enter meta description...',
          maxLines: 3,
          controller: metaDescriptionController,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Short Description',
          hintText: 'Write a short description for this variant...',
          maxLines: 4,
          controller: shortDescriptionController,
        ),
        const SizedBox(height: 25),
        const Text(
          'Full Description',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF334155)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            maxLines: 8,
            controller: fullDescriptionController,
            decoration: const InputDecoration(
              hintText: 'Write a detailed, formatted description for this variant...',
              hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              contentPadding: EdgeInsets.all(16),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
