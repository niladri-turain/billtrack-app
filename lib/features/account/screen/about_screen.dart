import 'package:billtrack/features/account/widgets/account_menu_tile.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'About billtrack'),
      body: Column(
        children: [

          AccountMenuTile(
            title: 'About Billtrack App',
            onTap: () {},
          ),
          AccountMenuTile(
            title: 'Privacy Policy',
            onTap: () {},
          ),
          AccountMenuTile(
            title: 'Terms & Conditions',
            onTap: () {},
          ),
          AccountMenuTile(
            title: 'Cancelation Policy',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
