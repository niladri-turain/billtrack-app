import 'package:billtrack/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class AccountMenuTile extends StatelessWidget {
  final String? iconPath;
  final String title;
  final VoidCallback onTap;
  final bool isSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool isDelete;

  const AccountMenuTile({
    super.key,
    this.iconPath,
    required this.title,
    required this.onTap,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSwitch ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: isDelete ? AppColors.deleteBg : Colors.transparent,
        ),
        child: Row(
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                height: 18,
                width: 18,
                color: isDelete ? AppColors.deleteRed : null,
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isDelete ? FontWeight.w500 : FontWeight.w400,
                  color: isDelete ? AppColors.deleteRed : Colors.black87,
                ),
              ),
            ),
            if (isSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeColor: Colors.white,
                activeTrackColor: AppColors.orange,
              )
            else if (!isDelete)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}
