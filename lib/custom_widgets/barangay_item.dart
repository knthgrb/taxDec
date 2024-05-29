import 'package:flutter/material.dart';
import 'package:tax/constants/colors.dart';

class BarangayItem extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const BarangayItem({
    super.key,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: selected ? darkGrayColor : Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: TextStyle(
                letterSpacing: 0,
                fontFamily: "Inter",
                color: selected ? Colors.white : darkTextColor,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
