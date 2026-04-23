import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class InvoiceViewScreen extends StatelessWidget {
  const InvoiceViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: const CustomAppBar(title: 'Invoice Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
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
                  _buildDottedDivider(),

                  // Invoice Info
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildInfoRow("Invoice No : TS252612531", "Billed By : Mousin"),
                        const SizedBox(height: 4),
                        _buildInfoRow("Date : 24-10-2025", "Time : 11 : 25 AM"),
                      ],
                    ),
                  ),

                  _buildDottedDivider(),

                  // Customer Info
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _buildInfoRow("Name : Rohan", "Number : 62903 97293"),
                  ),

                  _buildDottedDivider(),

                  // Table Header
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(flex: 4, child: Text("Description", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 1, child: Text("QTY", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text("Price", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text("Amount", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),

                  _buildDottedDivider(),

                  // Items List (Static Data based on your image)
                  _buildItemRow("Chicken Biryani", "2", "247.62", "495.24"),
                  _buildDottedDivider(),
                  _buildItemRow("Spl. Chicken Biryani", "1", "333.33", "333.33"),
                  _buildDottedDivider(),
                  _buildItemRow("Butter Chicken", "1", "261.90", "261.90"),
                  _buildDottedDivider(),
                  _buildItemRow("Butter Naan", "4", "47.62", "190.48"),
                  _buildDottedDivider(),
                  _buildItemRow("Mineral Water *", "2", "30.00", "60.00"),

                  _buildDottedDivider(),

                  // Sub-total
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _buildInfoRow("Total Quantity : 10", "Sub Total : 1340.95"),
                  ),

                  _buildDottedDivider(),

                  // Taxes
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildTaxRow("1280.95 @ CGST - 2.5%", "32.02"),
                        _buildTaxRow("1280.95 @ SGST - 2.5%", "32.02"),
                        _buildTaxRow("Round Off", "0.01"),
                      ],
                    ),
                  ),

                  _buildDottedDivider(),

                  // Final Total
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payment : Cash", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                        Text("Total Amount : 1405.00", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      ],
                    ),
                  ),


                  _buildDottedDivider(),
                  const Text("Thank You & Visit Again", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


  Widget _buildInfoRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        Text(right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildTaxRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildItemRow(String desc, String qty, String price, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(desc, style: const TextStyle(fontSize: 13))),
          Expanded(flex: 1, child: Text(qty, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400))),
          Expanded(flex: 2, child: Text(price, textAlign: TextAlign.right, style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400))),
          Expanded(flex: 2, child: Text(amount, textAlign: TextAlign.right, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }

  Widget _buildDottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: List.generate(
          80,
              (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.grey.withOpacity(0.5),
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}