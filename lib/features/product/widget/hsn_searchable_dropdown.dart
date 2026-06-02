import 'package:billtrack/features/product/model/hsn_model.dart';
import 'package:flutter/material.dart';

class HSNSearchableDropdown extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isMandatory;
  final List<HSNModel> items;
  final String? selectedValue;
  final Function(HSNModel) onSelected;
  final bool isLoading;

  const HSNSearchableDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.onSelected,
    this.isMandatory = false,
    this.selectedValue,
    this.isLoading = false,
  });

  @override
  State<HSNSearchableDropdown> createState() => _HSNSearchableDropdownState();
}

class _HSNSearchableDropdownState extends State<HSNSearchableDropdown> {
  void _showSearchSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _HSNSearchSheet(
        items: widget.items,
        onSelected: widget.onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            children: widget.isMandatory
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: widget.isLoading ? null : _showSearchSheet,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.isLoading 
                        ? 'Loading...' 
                        : (widget.selectedValue ?? widget.hintText),
                    style: TextStyle(
                      color: widget.selectedValue == null || widget.isLoading
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF334155),
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HSNSearchSheet extends StatefulWidget {
  final List<HSNModel> items;
  final Function(HSNModel) onSelected;

  const _HSNSearchSheet({
    required this.items,
    required this.onSelected,
  });

  @override
  State<_HSNSearchSheet> createState() => _HSNSearchSheetState();
}

class _HSNSearchSheetState extends State<_HSNSearchSheet> {
  late List<HSNModel> filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _filterSearch(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) =>
              item.hsnCode.toLowerCase().contains(query.toLowerCase()) ||
              item.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSearch,
              decoration: InputDecoration(
                hintText: 'Search HSN Code...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6366F1)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredItems.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final displayCode = item.hsnCode.isEmpty ? 'No Code' : item.hsnCode;
                
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayCode,
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'GST ${item.gst}%',
                          style: const TextStyle(
                            color: Color(0xFF4F46E5),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  onTap: () {
                    widget.onSelected(item);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
