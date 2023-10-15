import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.FF0C0F14,
        title: const Text('User'),
        elevation: 0,
      ),
    );
  }
}
