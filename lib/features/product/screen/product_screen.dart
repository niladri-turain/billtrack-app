import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/features/product/screen/set_price_screen.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:billtrack/widgets/custom_bottom_navigationbar.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/app_pngs.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // Sample data
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'TANDOOR & KEBABS',
      'isExpanded': false,
      'items': [
        {'name': 'Chicken Boti Kebab (6pc)', 'isSelected': false},
        {'name': 'Chicken Haryali Kebab (8pc)', 'isSelected': false},
        {'name': 'Chicken Malai Kebab (4pc)', 'isSelected': false},
        {'name': 'Chicken Tangdi Kebab (6pc)', 'isSelected': false},
        {'name': 'Chicken Wings Kebab (8pc)', 'isSelected': false},
        {'name': 'Chicken Kathi Kebab (10pc)', 'isSelected': false},
      ]
    },
    {
      'title': 'MUTTON IN GRAVY',
      'isExpanded': false,
      'items': [
        {'name': 'Mutton Rogan Josh', 'isSelected': false},
        {'name': 'Mutton Kasha', 'isSelected': false},
      ]
    },
    {
      'title': 'CHICKEN IN GRAVY',
      'isExpanded': false,
      'items': [
        {'name': 'Chicken Bharta', 'isSelected': false},
        {'name': 'Chicken Butter Masala', 'isSelected': false},
      ]
    },
    {
      'title': 'BIRYANI',
      'isExpanded': false,
      'items': [
        {'name': 'Chicken Biryani', 'isSelected': false},
        {'name': 'Mutton Biryani', 'isSelected': false},
      ]
    },
  ];

  int get selectedCount {
    int count = 0;
    for (var cat in _categories) {
      for (var item in cat['items']) {
        if (item['isSelected']) count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6ECF4), // Light blue background from image
      appBar: CustomAppBar(
        title: 'Product list',
        onBackPress: () {
          final navState = context.findAncestorStateOfType<CustomBottomNavigationBarState>();
          if (navState != null) {
            navState.onItemTapped(0);
          }
        },
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(AppImagesPng.search, width: 18),
          ),Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(AppImagesPng.question, width: 18),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(AppImagesPng.notification, width: 20),
          ),
        
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryTile(_categories[index]);
              },
            ),
          ),
          _buildBottomSummary(),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(Map<String, dynamic> category) {
    return Center(
      child: Container(


        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(

            initiallyExpanded: category['isExpanded'],
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            title: SizedBox(


              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  category['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                category['isExpanded'] = expanded;
              });
            },
            collapsedBackgroundColor: Colors.white,
            backgroundColor: const Color(0xFFFFAE81),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            children: [
              const Divider(height: 1, thickness: 0.5),
              ...category['items'].map<Widget>((item) {
                return _buildProductItem(item);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> item) {
    bool isSelected = item['isSelected'];
    return GestureDetector(
      onTap: () {
        setState(() {
          item['isSelected'] = !item['isSelected'];
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedItemBg : Colors.white,
          border: const Border(
            bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item['name'],
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.checkboxGreen : const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.selectedProductBg,
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Product',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  '$selectedCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SetPriceScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'SET PRICE',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
