import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final int selectedTab;

  const HomeBody({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    switch (selectedTab) {
      case 0:
        return Placeholder(color: Colors.blue);
      case 1:
        return Placeholder(color: Colors.red);
      case 2:
        return Placeholder(color: Colors.yellow);
      default:
        return SizedBox();
    }
  }
}
