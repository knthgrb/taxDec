import 'package:flutter/material.dart';
import 'package:tax/custom_widgets/main_body.dart';
import 'package:tax/custom_widgets/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBarangayIndex = 0;

  void onBarangaySelected(int index) {
    setState(() {
      selectedBarangayIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomSidebar(
              selectedBarangayIndex: selectedBarangayIndex,
              onBarangaySelected: onBarangaySelected),
          MainBody(selectedBarangayIndex: selectedBarangayIndex)
        ],
      ),
    );
  }
}
