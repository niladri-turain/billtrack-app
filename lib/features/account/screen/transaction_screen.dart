import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        'title': 'Basic Plan',
        'subtitle': 'Until Dec 22, 2026',
        'amount': '₹ 999.00',
        'date': 'Dec 22, 2025',
        'amountColor': Colors.green,
        'subtitleColor': Colors.grey,
      },
      {
        'title': 'Pro Plan',
        'subtitle': 'Subscription had ended',
        'amount': '₹ 1499.00',
        'date': 'Dec 22, 2025',
        'amountColor': Colors.green,
        'subtitleColor': Colors.red,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.transactionBg,
      appBar: CustomAppBar(
        title: 'Transactions',
        onBackPress: () {
          Navigator.pop(context);
        },
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final item = transactions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      item['amount'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: item['amountColor'],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['subtitle'],
                      style: TextStyle(
                        fontSize: 12,
                        color: item['subtitleColor'],
                      ),
                    ),
                    Text(
                      item['date'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
