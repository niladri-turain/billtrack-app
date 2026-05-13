import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/features/activeProduct/widgets/active_product_item_tile.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ActiveProductScreen extends StatefulWidget {
  const ActiveProductScreen({super.key});

  @override
  State<ActiveProductScreen> createState() => _ActiveProductScreenState();
}

class _ActiveProductScreenState extends State<ActiveProductScreen> {
  final List<Map<String, dynamic>> _products = List.generate(
    8,
    (index) => {
      'name': 'Tandoori Kebab',
      'price': '199.00',
      'category': 'Starter',
      'isActive': index < 4,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transactionBg,
      appBar: CustomAppBar(
        title: 'Active products',
        actions: [
          IconButton(
            icon: Image.asset(AppImagesPng.search, width: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(AppImagesPng.question, width: 22),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Center(child: Image.asset(AppImagesPng.notification, width: 22)),
                Positioned(
                  right: 0,
                  top: 15,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ActiveProductItemTile(
                  productName: product['name'],
                  price: product['price'],
                  category: product['category'],
                  isActive: product['isActive'],
                  onToggle: (value) {
                    setState(() {
                      _products[index]['isActive'] = value;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 160,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.saveButtonGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'SAVE CHANGES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
