import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/features/home/widgets/invoice_list_tile.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:billtrack/widgets/custom_bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transactionBg,
      appBar: CustomAppBar(
        title: 'Invoice list',
        onBackPress: () {
          final navState = context.findAncestorStateOfType<CustomBottomNavigationBarState>();
          if (navState != null) {
            navState.onItemTapped(0);
          }
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.black),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Image.asset(AppImagesPng.notification, width: 22),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header: All Invoice List and Sort Button

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8


              )
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Invoice List',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF040707),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0x1AEA6B23), // #EA6B231A
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Sort',
                            style: TextStyle(
                              color: Color(0xFFEA6B23), // #EA6B23
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.swap_vert, color: Color(0xFFEA6B23), size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Scrollable Invoice List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return const InvoiceListTile(
                    invoiceNo: 'TS252612531',
                    phone: '6290397298',
                    date: '16-10-2025 16:54',
                    amount: '250.00',
                    status: 'Paid',
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
