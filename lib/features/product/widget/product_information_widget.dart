import 'package:flutter/material.dart';
import 'add_product_wudget.dart';

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
