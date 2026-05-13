import 'package:billtrack/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class SalesSummaryCard extends StatelessWidget {
  final String title;
  final String percentage;
  final String value;
  final String subText;

  const SalesSummaryCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.value,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    percentage,
                    style: const TextStyle(
                      color: AppColors.saveGreenText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_upward,
                    color: AppColors.saveGreenText,
                    size: 12,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subText,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
