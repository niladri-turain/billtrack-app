import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:flutter/material.dart';

import '../../invoice/screen/invoice_view.dart';

class InvoiceListTile extends StatefulWidget {
  final String invoiceNo;
  final String phone;
  final String date;
  final String amount;
  final String status;

  const InvoiceListTile({
    super.key,
    required this.invoiceNo,
    required this.phone,
    required this.date,
    required this.amount,
    this.status = 'Paid',
  });

  @override
  State<InvoiceListTile> createState() => _InvoiceListTileState();
}

class _InvoiceListTileState extends State<InvoiceListTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Row 1: Invoice No and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.invoiceNo,
                  style: const TextStyle(
                    color: AppColors.orangeTitle,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAFAEC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.status,
                    style: const TextStyle(
                      color: Color(0xFF27C840),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Row 2: Date (Centered and separate)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                widget.date,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            // Row 3: Phone and Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.phone,
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '₹ ${widget.amount}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            if (_isExpanded) ...[
              const SizedBox(height: 0),
              // Dotted Line
              Row(
                children: List.generate(
                  100,
                  (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0 ? Colors.transparent : Colors.grey.withOpacity(0.3),
                      height: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Action Icons Row with small images and labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionItem(AppImagesPng.message, 'SMS', const Color(0xFF2196F3), () {
                    // SMS logic here
                  }),
                  _buildActionItem(AppImagesPng.whatsapp, 'Whatsapp', const Color(0xFF27C840), () {
                    // Whatsapp logic here
                  }),
                  _buildActionItem(AppImagesPng.print, 'Print', const Color(0xFFF44336), () {
                    // Print logic here
                  }),
                  _buildActionItem(AppImagesPng.view, 'Details', const Color(0xFF757575), () {
                    // Details logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InvoiceViewScreen()),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 8),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(String assetPath, String label, Color textColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetPath,
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
