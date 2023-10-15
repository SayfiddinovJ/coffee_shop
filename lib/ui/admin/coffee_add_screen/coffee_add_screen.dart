import 'package:coffee_shop/ui/admin/widgets/global_text_field.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoffeeAddScreen extends StatelessWidget {
  const CoffeeAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.FF0C0F14,
      appBar: AppBar(
        title: const Text('Add Coffee'),
        backgroundColor: AppColors.FF0C0F14,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: [
          10.ph,
          const GlobalTextField(hintText: 'Name'),
        ],
      ),
    );
  }
}
