import 'package:flutter/material.dart';
import 'package:tax/models/barangay.dart';

class CustomDropdownWithSuffix extends StatelessWidget {
  final List<Barangay> items;
  final String suffixText;
  final String labelText;
  final Barangay? selectedItem;
  final ValueChanged<Barangay?> onChanged;

  const CustomDropdownWithSuffix({
    super.key,
    required this.items,
    required this.suffixText,
    required this.labelText,
    this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: const TextStyle(fontSize: 16)),
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: const Color(0xffEEE8F4),
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 120, 120, 120)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Barangay>(
              dropdownColor: Colors.white,
              value: selectedItem,
              isExpanded: true,
              items: items.map((Barangay item) {
                return DropdownMenuItem<Barangay>(
                  value: item,
                  child: Text(
                    '${item.barangayName}$suffixText',
                    style: const TextStyle(
                        fontFamily: "Inter", fontWeight: FontWeight.normal),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
