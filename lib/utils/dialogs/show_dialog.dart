import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showMessage({
  required String message,
  required BuildContext context,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: AppColors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Text(
            message,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
