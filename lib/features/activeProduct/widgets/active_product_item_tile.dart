import 'package:billtrack/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/app_pngs.dart';

class ActiveProductItemTile extends StatelessWidget {
  final String productName;
  final String price;
  final String category;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const ActiveProductItemTile({
    super.key,
    required this.productName,
    required this.price,
    required this.category,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image Placeholder
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F5F9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              AppImagesPng.defaultImage,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_outlined, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.selectedItemBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: AppColors.checkboxGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Toggle Switch
          Switch(
            value: isActive,
            onChanged: onToggle,
            activeColor: Colors.white,
            activeTrackColor: AppColors.orange,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
