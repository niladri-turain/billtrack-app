import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/features/account/screen/about_screen.dart';
import 'package:billtrack/features/account/screen/help_support_screen.dart';
import 'package:billtrack/features/account/screen/profile_screen.dart';
import 'package:billtrack/features/account/screen/subscription_screen.dart';
import 'package:billtrack/features/account/screen/transaction_screen.dart';
import 'package:billtrack/features/account/widgets/account_menu_tile.dart';
import 'package:billtrack/features/product/screen/product_screen.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:billtrack/widgets/custom_bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Account settings',
        onBackPress: () {
          final navState = context.findAncestorStateOfType<CustomBottomNavigationBarState>();
          if (navState != null) {
            navState.onItemTapped(0);
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: .1,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(AppImagesPng.user),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SK MOUSIN ALI',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '6290397299',
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: Image.asset(
                      AppImagesPng.edit,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: .1,),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildReportCard(
                      imagePath: AppImagesPng.salesReport,
                      title: 'Sales report',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildReportCard(
                      imagePath: AppImagesPng.activeProducts,
                      title: 'Active products',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: .1,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text(
                'Settings',
                style: TextStyle(color: AppColors.grey, fontSize: 16),
              ),
            ),
            AccountMenuTile(
              iconPath: AppImagesPng.itemMaster,
              title: 'Item Master',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductScreen()),
                );
              },
            ),
            AccountMenuTile(
              iconPath: AppImagesPng.subscription,
              title: 'Subscriptions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
                );
              },
            ),
            AccountMenuTile(
              iconPath: AppImagesPng.theme,
              title: 'Theme',
              isSwitch: true,
              switchValue: isDarkMode,
              onSwitchChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              onTap: () {},
            ),
            AccountMenuTile(
              iconPath: AppImagesPng.transaction,
              title: 'Transactions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TransactionScreen()),
                );
              },
            ),
            AccountMenuTile(
              iconPath: AppImagesPng.helpSupport,
              title: 'Help & Support',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
                );
              },
            ),
            AccountMenuTile(
              iconPath: AppImagesPng.aboutBilltrack,
              title: 'About Billtrack',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            AccountMenuTile(
              iconPath: AppImagesPng.logout,
              title: 'Logout',
              onTap: () {},
            ),
            const SizedBox(height: 8),
            AccountMenuTile(
              iconPath: AppImagesPng.delete,
              title: 'Delete Account',
              isDelete: true,
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({required String imagePath, required String title}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBg,
        border: Border.all(color: AppColors.lightGrey.withOpacity(0.75)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 22,
            width: 22,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
