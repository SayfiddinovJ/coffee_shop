import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularsView extends StatelessWidget {
  const PopularsView({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white10,
        ),
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 240.w,
                        child: Text(
                          product.name,
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
                        product.price,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.buttonsColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
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
            ),
          ],
        ),
      ),
    );
  }
}
