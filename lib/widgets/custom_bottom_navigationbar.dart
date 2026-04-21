import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/features/account/screen/account_screen.dart';
import 'package:billtrack/features/createBill/screen/create_bill_screen.dart';
import 'package:billtrack/features/home/screen/home_screen.dart';
import 'package:billtrack/features/invoice/screen/invoice_screen.dart';
import 'package:billtrack/features/product/screen/product_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  final GlobalKey<NavigatorState> _accountNavKey = GlobalKey<NavigatorState>();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const ProductScreen(),
      const CreateBillScreen(),
      const InvoiceScreen(),
      _buildAccountTabNavigator(),
    ];
  }

  Widget _buildAccountTabNavigator() {
    return Navigator(
      key: _accountNavKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const AccountScreen(),
        );
      },
    );
  }

  void onItemTapped(int index) {
    if (_selectedIndex == index && index == 4) {
      // If already on Account tab, pop to its root
      _accountNavKey.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (_selectedIndex == 4) {
          final NavigatorState? nav = _accountNavKey.currentState;
          if (nav != null && nav.canPop()) {
            nav.pop();
            return;
          }
        }

        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return;
        }

        // If on Home tab and can't pop anymore, exit
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFE0E0E0), width: 0.8),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    selectedImage: AppImagesPng.homeSelect,
                    unselectedImage: AppImagesPng.homeUnselect,
                    label: 'Home',
                    index: 0,
                  ),
                  _buildNavItem(
                    selectedImage: AppImagesPng.productSelect,
                    unselectedImage: AppImagesPng.product,
                    label: 'Product',
                    index: 1,
                  ),
                  _buildCenterNavItem(AppImagesPng.bill, 2),
                  _buildNavItem(
                    selectedImage: AppImagesPng.invoiceSelect,
                    unselectedImage: AppImagesPng.invoice,
                    label: 'Invoice',
                    index: 3,
                  ),
                  _buildNavItem(
                    selectedImage: AppImagesPng.accountSelect,
                    unselectedImage: AppImagesPng.account,
                    label: 'Account',
                    index: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    String? selectedImage,
    String? unselectedImage,
    IconData? icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedImage != null && unselectedImage != null)
              Image.asset(
                isSelected ? selectedImage : unselectedImage,
                height: 20,
                width: 20,
              )
            else
              Icon(
                icon,
                color: isSelected ? Colors.black : AppColors.grey,
                size: 26,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : AppColors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNavItem(String imagePath, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: AppColors.orange,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            height: 25,
            width: 25,
          ),
        ),
      ),
    );
  }
}
