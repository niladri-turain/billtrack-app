import 'package:billtrack/features/product/provider/hsn_provider.dart';
import 'package:billtrack/features/product/widget/hsn_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:billtrack/features/product/widget/add_product_wudget.dart';

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
            name: 'product_title',
            label: 'Product Title',
            hintText: 'Enter product title',
            isMandatory: true,
            controller: titleController,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Product title is required'),
              FormBuilderValidators.minLength(2, errorText: 'Min 2 characters required'),
            ]),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Consumer<HSNProvider>(
                  builder: (context, hsnProvider, child) {
                    return ValueListenableBuilder<TextEditingValue>(
                      valueListenable: hsnController,
                      builder: (context, value, child) {
                        return HSNSearchableDropdown(
                          label: 'HSN Code',
                          hintText: 'Select HSN Code',
                          isMandatory: true,
                          items: hsnProvider.hsnList,
                          selectedValue: value.text.isNotEmpty ? value.text : null,
                          isLoading: hsnProvider.isLoading,
                          // Note: HSNSearchableDropdown is a custom widget, 
                          // we might need to wrap it or handle its validation manually 
                          // if it's not a FormBuilderField.
                          // For now, let's keep it as is or update it later if needed.
                          onSelected: (selectedHsn) {
                            hsnController.text = selectedHsn.hsnCode.isEmpty ? 'No Code' : selectedHsn.hsnCode;
                            gstController.text = selectedHsn.gst;
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  name: 'gst_rate',
                  label: 'GST Rate (%)',
                  hintText: '',
                  isMandatory: true,
                  keyboardType: TextInputType.number,
                  controller: gstController,
                  readOnly: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
