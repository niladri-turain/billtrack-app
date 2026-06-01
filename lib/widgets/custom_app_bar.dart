import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBackPress;
  final bool? isInvoiceDetails;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBackPress,
    this.isInvoiceDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: const Border(
        bottom: BorderSide(
          color: Color(0x4D000000), // #0000004D
          width: 0.5,
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.orange.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: AppColors.orange, size: 20),
        ),
        onPressed: onBackPress ?? () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: actions ??
          [
            isInvoiceDetails==true?const SizedBox():  IconButton(
              icon:  const Icon(Icons.help_outline, color: Colors.black),
              onPressed: () {},
            ),
            isInvoiceDetails==true?const SizedBox():   Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(AppImagesPng.notification, width: 22),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
