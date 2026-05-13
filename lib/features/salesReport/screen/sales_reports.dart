import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/features/salesReport/widgets/sales_summary_card.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  String selectedFilter = 'Month';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Sales report',
        actions: [
          IconButton(
            icon: Image.asset(AppImagesPng.question, width: 22),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppImagesPng.notification, width: 22),
                Positioned(
                  top: 12,
                  right: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(thickness: 0.5, height: 1),
            // Download Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Download detailed report',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Click to choose date range & file type',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Summary Cards
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SalesSummaryCard(
                      title: 'Sales',
                      percentage: '+2.5%',
                      value: '₹ 10289.00',
                      subText: 'Compared to\n(₹ 9340.00 last month)',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: SalesSummaryCard(
                      title: 'Invoice',
                      percentage: '+2.5%',
                      value: '2358',
                      subText: 'Compared to\n(1256 last month)',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Filter Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _buildFilterTab('Month'),
                  _buildFilterTab('3 Months'),
                  _buildFilterTab('This Year'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Chart Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monthly Sales',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '₹ 5104.00',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_upward, color: AppColors.saveGreenText, size: 16),
                      const Text(
                        '1.3% increased',
                        style: TextStyle(
                          color: AppColors.saveGreenText,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Image.asset(
                    AppImagesPng.chartFlow,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTab(String title) {
    bool isSelected = selectedFilter == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected ? Border.all(color: Colors.grey.shade200) : null,
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.orange : Colors.black54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
