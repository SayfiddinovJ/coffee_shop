import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/ui/coffee_detail/coffee_detail_screen.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key, required this.coffees});

  final List<CoffeeModel> coffees;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 438.h,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          ...List.generate(
            coffees.length,
            (index) {
              CoffeeModel coffee = coffees[index];
              return InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoffeeDetailScreen(coffee: coffee),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: CachedNetworkImage(
                              imageUrl: coffee.image,
                              fit: BoxFit.fill,
                              width: 240.w,
                              height: 276.h,
                            ),
                          ),
                          8.ph,
                          Text(
                            coffee.type,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                          4.ph,
                          SizedBox(
                            width: 240.w,
                            child: Text(
                              coffee.name,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white24,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
                    Positioned(
                      right: 16.w,
                      bottom: 16.h,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100.r),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: AppColors.buttonsColor,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
