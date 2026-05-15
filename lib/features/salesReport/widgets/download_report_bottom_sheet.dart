import 'package:billtrack/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class DownloadReportBottomSheet extends StatefulWidget {
  const DownloadReportBottomSheet({super.key});

  @override
  State<DownloadReportBottomSheet> createState() => _DownloadReportBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DownloadReportBottomSheet(),
    );
  }
}

class _DownloadReportBottomSheetState extends State<DownloadReportBottomSheet> {
  String selectedPeriod = 'Today';
  String selectedFormat = 'Excel';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select option to download',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Choose desire conditions for reports',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.red, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Dashed Divider
          Row(
            children: List.generate(
              30,
              (index) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Time Period Selection
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSelectableChip('Today', selectedPeriod, (val) => setState(() => selectedPeriod = val)),
                const SizedBox(width: 10),
                _buildSelectableChip('Week', selectedPeriod, (val) => setState(() => selectedPeriod = val)),
                const SizedBox(width: 10),
                _buildSelectableChip('Month', selectedPeriod, (val) => setState(() => selectedPeriod = val)),
                const SizedBox(width: 10),
                _buildSelectableChip('Custom', selectedPeriod, (val) => setState(() => selectedPeriod = val)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Format Selection
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSelectableChip('Excel', selectedFormat, (val) => setState(() => selectedFormat = val)),
                const SizedBox(width: 10),
                _buildSelectableChip('PDF', selectedFormat, (val) => setState(() => selectedFormat = val)),
                const SizedBox(width: 10),
                _buildSelectableChip('CSV', selectedFormat, (val) => setState(() => selectedFormat = val)),
                const SizedBox(width: 10),
                _buildSelectableChip('Xls', selectedFormat, (val) => setState(() => selectedFormat = val)),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Download Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Download',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableChip(String label, String selectedValue, Function(String) onSelected) {
    bool isSelected = label == selectedValue;
    return GestureDetector(
      onTap: () => onSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEFE8) : const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.orange : Colors.black87,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
