import 'package:flutter/material.dart';

class AddNewSectionWidget extends StatelessWidget {
  final VoidCallback onTap;

  const AddNewSectionWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4338CA)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Color(0xFF4338CA)),
            SizedBox(width: 8),
            Text(
              'Add New Variant Section',
              style: TextStyle(
                color: Color(0xFF4338CA),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
