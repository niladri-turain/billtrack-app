import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String label;
  final String hintText;
  final bool isMandatory;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefix;
  final bool readOnly;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;

  const CustomTextField({
    super.key,
    required this.name,
    required this.label,
    required this.hintText,
    this.isMandatory = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefix,
    this.readOnly = false,
    this.validator,
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
        FormBuilderTextField(
          name: name,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            prefixIcon: prefix,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            errorMaxLines: 3,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4338CA), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDateField extends StatelessWidget {
  final String name;
  final String label;
  final String hintText;
  final bool isMandatory;
  final TextEditingController? controller;
  final String? Function(DateTime?)? validator;

  const CustomDateField({
    super.key,
    required this.name,
    required this.label,
    required this.hintText,
    this.isMandatory = false,
    this.controller,
    this.validator,
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
        FormBuilderDateTimePicker(
          name: name,
          inputType: InputType.date,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20, color: Color(0xFF64748B)),
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            errorMaxLines: 3,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4338CA), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String name;
  final String label;
  final String hintText;
  final bool isMandatory;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final bool isLoading;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.name,
    required this.label,
    required this.hintText,
    required this.items,
    this.isMandatory = false,
    this.value,
    this.onChanged,
    this.isLoading = false,
    this.validator,
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
        FormBuilderDropdown<String>(
          name: name,
          initialValue: value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          isExpanded: true,
          decoration: InputDecoration(

            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(color: (isLoading || items.isEmpty) ? const Color(0xFF94A3B8) : Colors.black, fontSize: 14),
            // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            errorMaxLines: 3,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4338CA), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF334155))),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
