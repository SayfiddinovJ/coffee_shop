import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.FF0C0F14,
      appBar: AppBar(
        title: const Text('Coffee'),
        backgroundColor: AppColors.FF0C0F14,
        elevation: 0,
      ),
    );
  }
}
