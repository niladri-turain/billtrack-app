import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/app_pngs.dart';

class InvoiceViewScreen extends StatelessWidget {


  const InvoiceViewScreen({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Invoice Details', isInvoiceDetails: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Decathlon Header
            const SizedBox(height: 20),

            Image.asset(AppImagesPng.billTrackLogo, height: 20, errorBuilder: (context, error, stackTrace) => const Icon(Icons.receipt_long, size: 20)),
            const Text(
              "Mousin's Kitchen Pvt. Ltd.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Phone Number : +91 6290 397200", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            const Text("Opening : 11:00 AM to 11:00 PM", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            const Text(
              "Address : 2/25 Poddarnagar Kolkata ,\n West bengal - 700046",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            const Text("GST NO : 19YWFAS0292L8Z8", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),

            const SizedBox(height: 15),

            _buildDashedDivider(),

            // Bill Information Section
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date & Time : ${'2024-10-25 15:15'}", style: TextStyle(fontSize: 12)),
                    Text("POS : 231", style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 4),
                Text("Bill : '703134231/2416600'", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Cashier : ayushmita guha", style: TextStyle(fontSize: 12)),
              ],
            ),

            _buildDashedDivider(),

            // Customer Details (Right Aligned)
            const Column(

              children: [
                Align(child: _RightInfoRow(label: "Customer Name :", value:  "Niladri Roy")),
                _RightInfoRow(label: "Customer ID :", value: "2230356410222"),
                _RightInfoRow(label: "Email :", value: "niladriroy20065@gmail.com"),
                _RightInfoRow(label: "Mobile no :", value: "8254878880"),
              ],
            ),

            _buildDashedDivider(),

            // Items Table Section
            Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Description\nSAQ Code\nHSN Code", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    Text("QTY", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    Text("Unit Amt\nTotal Amt", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 10),
                _buildItemRow("Phone Iphone", "1237733", "48194000", "1", "12.00", "12.00"),
                _buildItemRow("Joystick", "4721236", "62121010", "1", "599.00", "599.00"),
                _buildItemRow("T-Shirt", "2333833", "62024090", "1", "799.00", "799.00"),
              ],
            ),

            _buildDashedDivider(),

            // Totals Section
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total QTY : 3", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text("Grand Total : ₹ ${ '1410.00'}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                _buildAmountRow("Net Payable", "₹ '1410.00'", isBold: true),
                _buildAmountRow("Change Amount", "₹ 0.00"),
              ],
            ),

            _buildDashedDivider(),

            // Payment Mode Section



            // Tax Information Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tax Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                _buildAmountRow("Taxable Amount", "₹  1194.92", isBold: true),
                _buildAmountRow("CGST (9.00%)", "₹ 107.54"),
                _buildAmountRow("SGST (9.00%)", "₹ 107.54"),
                const Divider(),
                _buildAmountRow("Total Tax", "₹ 215.08", isBold: true),
              ],
            ),

            _buildDashedDivider(),

            // Footer Section
            const Column(
              children: [
                Text("Decathlon Sports India Pvt Ltd", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 5),
                Text(
                  "Address: Survey No.78/10 A20 Chikkajala Village, Bellary Road, Bangalore, Karnataka, 562157",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
                Text("CIN No: U72200KA2004PTC033858", style: TextStyle(fontSize: 10)),
                Text("Fax: 08033487111", style: TextStyle(fontSize: 10)),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(String desc, String code, String hsn, String qty, String unit, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(desc, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                Text(code, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                Text(hsn, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          Expanded(child: Text(qty, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("₹$unit", style: const TextStyle(fontSize: 11)),
                Text("₹$total", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: 12, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: List.generate(
          40,
          (index) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 1,
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(width: 5),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 11))),
        ],
      ),
    );
  }
}

class _RightInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _RightInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(width: 5),
          Text(value, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
