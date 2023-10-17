import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoffeeStack extends StatelessWidget {
  const CoffeeStack({super.key, required this.coffee});

  final CoffeeModel coffee;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CachedNetworkImage(
            imageUrl: coffee.image,
            fit: BoxFit.fill,
            height: 544.h,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Positioned(
          top: 16.h,
          left: 16.w,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            padding: EdgeInsets.all(16.w),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.type,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                4.ph,
                Text(
                  coffee.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white24,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                16.ph,
                Text(
                  coffee.price,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.buttonsColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
              decoration: BoxDecoration(
                  color: AppColors.buttonsColor,
                  borderRadius: BorderRadius.circular(8.r),),
              child: Text('Add to cart',style: TextStyle(
                color: AppColors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
        ),
      ],
    );
  }
}
