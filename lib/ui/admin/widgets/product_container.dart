import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Hero(
                  tag: product.productId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.fill,
                      height: 100.w,
                      width: 100.w,
                    ),
                  ),
                ),
                16.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
