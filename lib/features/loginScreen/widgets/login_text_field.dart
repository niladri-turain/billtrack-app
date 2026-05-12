import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/core/constant/app_strings.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  const LoginTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Image.asset(AppImagesPng.phone, width: 22, color: AppColors.orange),
          const SizedBox(width: 10),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: AppStrings.phoneNumberHint,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const Icon(Icons.check_circle, color: AppColors.orange, size: 22),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
