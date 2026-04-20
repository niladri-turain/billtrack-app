import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/features/account/widgets/account_menu_tile.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Help & support'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 0.5),
            AccountMenuTile(
              iconPath: 'assets/images/help_support.png', // Using existing help icon for now
              title: 'Call Support',
              onTap: () {},
            ),
            AccountMenuTile(
              iconPath: 'assets/images/help_support.png', // Using existing help icon for now
              title: 'Chat Support',
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 20, bottom: 10),
              child: Text(
                'FAQs',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            AccountMenuTile(
              title: 'General Inquiry',
              onTap: () {},
            ),
            AccountMenuTile(
              title: 'Feedback & Suggestions',
              onTap: () {},
            ),
            AccountMenuTile(
              title: 'Subscription Related Query',
              onTap: () {},
            ),
            AccountMenuTile(
              title: 'SMS Related Inquiry',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
