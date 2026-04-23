import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/features/product/widget/add_product_modal.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SetPriceScreen extends StatefulWidget {
  const SetPriceScreen({super.key});

  @override
  State<SetPriceScreen> createState() => _SetPriceScreenState();
}

class _SetPriceScreenState extends State<SetPriceScreen> {
  bool _isGridView = true;

  void _showAddProductModal() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return const AddProductModal();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: anim1,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6ECF4),
      appBar: CustomAppBar(
        title: 'Product list',
        onBackPress: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.grid_view : Icons.list, color: Colors.black),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(AppImagesPng.notification, width: 22),
          ),
        ],
      ),
      body: Stack(
        children: [
          _isGridView ? _buildGridView() : _buildListView(),
          // Floating Add New Item Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: InkWell(
                onTap: _showAddProductModal,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF27C840),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add New Item',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.add, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.99,
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return _buildGridItem();
      },
    );
  }

  Widget _buildGridItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0XFFF00058).withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 05.0),
              child: Center(
                child: Container(
                  height: 70,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Image.asset(AppImagesPng.defaultImage),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Tandoori Kebab',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '₹ NA',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 20,
                  width: 20,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAFAEC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(AppImagesPng.edit1, width: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: 15,
      itemBuilder: (context, index) {
        return _buildListItem();
      },
    );
  }

  Widget _buildListItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(AppImagesPng.defaultImage),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tandoori Kebab',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'Starter',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹ 200.00',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'Per plate',
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
