// custom_sidebar.dart
import 'package:flutter/material.dart';
import 'package:tax/constants/colors.dart';
import 'package:tax/constants/data/barangay.dart';
import 'package:tax/custom_widgets/barangay_item.dart';
import 'package:tax/main.dart';
import 'package:tax/screens/login_screen.dart';

class CustomSidebar extends StatefulWidget {
  final int? selectedBarangayIndex;
  final ValueChanged<int> onBarangaySelected;
  const CustomSidebar(
      {super.key,
      this.selectedBarangayIndex,
      required this.onBarangaySelected});

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  bool _isHovered = false;

  Future<void> _logout() async {
    await supabase.auth.signOut();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 256,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: borderColor, width: 1)),
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                "taxDec",
                style: TextStyle(
                    fontFamily: "Viga",
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: purpleColor),
              ),
            ),
            // child: Image.asset("assets/icons/sidebar_logo.png"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                itemCount: barangays.length,
                itemBuilder: (context, index) {
                  final barangay = barangays[index];
                  return BarangayItem(
                    name: barangay.barangayName,
                    selected: index == widget.selectedBarangayIndex,
                    onTap: () {
                      setState(() {
                        widget.onBarangaySelected(index);
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: borderColor))),
            child: FilledButton(
              onHover: (hovering) {
                setState(() {
                  _isHovered = hovering;
                });
              },
              style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                  backgroundColor: _isHovered
                      ? MaterialStatePropertyAll(lightGrayColor)
                      : MaterialStatePropertyAll(littleDarkerGrayColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
              onPressed: () {
                _logout();
              },
              child: Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: darkTextColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
