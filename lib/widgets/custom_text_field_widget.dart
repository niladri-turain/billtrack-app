import 'package:billtrack/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isDropDown;
  final List<String>? dropDownItems;
  final Widget? suffixIcon;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final int? maxLength;

  const CustomTextFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.isDropDown = false,
    this.dropDownItems,
    this.suffixIcon,
    this.borderColor,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: borderColor ?? AppColors.borderColor,
          width: 1,
        ),
      ),
      child: isDropDown
          ? DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                hint: Text(
                  hintText,
                  style: const TextStyle(color: AppColors.grey, fontSize: 14),
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  border: InputBorder.none,
                ),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.orange),
                items: dropDownItems?.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            )
          : TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                counterText: "",
              ),
            ),
    );
  }
}
