import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({super.key, required this.onPressed, required this.data});

  final VoidCallback onPressed;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.FFD17842,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          data,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
