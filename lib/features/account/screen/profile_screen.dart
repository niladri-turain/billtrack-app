import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transactionBg,
      appBar: CustomAppBar(
        title: 'Profile setting',
        onBackPress: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            // Section 1: Business Name
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(AppImagesPng.user),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Business Name',
                            style: TextStyle(color: Colors.black87, fontSize: 13),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'MOUSIN ALI',
                            hintStyle: const TextStyle(color: Color(0xFF6A7282), fontSize: 14),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),



            // Section 2: Primary Information
            Container(width: double.infinity,
            height: 15,
            color: AppColors.transactionBg,),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                    child: Text("Primary information",style: TextStyle(color: AppColors.grey,fontSize: 18),),
                  ),
                  _buildProfileTile(AppImagesPng.phone, 'Phone Number', '6290397299'),
                  const Divider(height: 1, indent: 56, endIndent: 16),
                  _buildProfileTile(AppImagesPng.email, 'Email Address', ''),
                  const Divider(height: 1, indent: 56, endIndent: 16),
                  _buildProfileTile(AppImagesPng.businessType, 'Business Type', ''),
                ],
              ),
            ),
            Container(width: double.infinity,
              height: 15,
              color: AppColors.transactionBg,),

            // Section 3: Business Information
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                    child: Text(
                      'Business information',
                      style: TextStyle(color: AppColors.grey, fontSize: 18),
                    ),
                  ),
                  _buildProfileTile(AppImagesPng.gstNumber, 'GST Number', ''),
                  const Divider(height: 1, indent: 56, endIndent: 16),
                  _buildProfileTile(AppImagesPng.businessAddress, 'Business Address', ''),
                  const Divider(height: 1, indent: 56, endIndent: 16),
                  _buildProfileTile(AppImagesPng.pannumber, 'PAN Card Number', ''),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Save Button
            Center(
              child: SizedBox(
                width: 160,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.saveButtonGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'SAVE CHANGES',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(String iconPath, String title, String trailingText) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24, height: 24),
      title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText.isNotEmpty)
            Text(
              trailingText,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
      onTap: () {},
    );
  }
}
