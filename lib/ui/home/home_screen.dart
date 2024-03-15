import 'package:coffee_shop/ui/admin/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _go(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/logo.png',
            height: 150.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              "Welcome to Marketplace",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  _go(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminScreen(),
        ),
      );
    });
  }
}
