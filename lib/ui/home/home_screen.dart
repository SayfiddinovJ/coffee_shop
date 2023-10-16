import 'package:coffee_shop/ui/admin/admin_screen.dart';
import 'package:coffee_shop/ui/user/user_screen.dart';
import 'package:coffee_shop/ui/widgets/select_buttons.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.FF0C0F14,
      appBar: AppBar(
        backgroundColor: AppColors.FF0C0F14,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Coffee Shop",
              style: TextStyle(
                fontSize: 32.sp,
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
              ),
            ),
            24.ph,
            Center(
              child: Image.asset(
                'assets/images/coffee_logo.png',
                height: 150.w,
              ),
            ),
            24.ph,
            Text(
              "Please choose who you are",
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
              ),
            ),
            12.ph,
            SizedBox(
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              child: SelectButtons(
                text: 'Admin',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminScreen(),
                    ),
                  );
                },
              ),
            ),
            24.ph,
            const Center(
              child: Text('or', style: TextStyle(color: Colors.white)),
            ),
            24.ph,
            SizedBox(
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              child: SelectButtons(
                text: 'User',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserScreen(),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
