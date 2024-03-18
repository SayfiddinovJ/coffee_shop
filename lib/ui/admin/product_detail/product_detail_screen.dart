import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/ui/admin/product_edit/product_edit_screen.dart';
import 'package:coffee_shop/ui/admin/widgets/photo_viewer.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Product'),
                  content: const Text(
                      'Are you sure you want to delete this product?'),
                  actions: [
                    TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context)),
                    TextButton(
                      child: const Text('Delete'),
                      onPressed: () {
                        context.read<ProductBloc>().add(
                            DeleteProductEvent(productId: product.productId));
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewer(url: product.image),
                  ),
                );
              },
              child: Hero(
                tag: product.productId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    height: 450.h,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.fade,
              ),
              maxLines: 3,
            ),
            Text(
              'Price',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
              maxLines: 2,
            ),
            Text(
              '${product.price} so\'m / 1 ${product.piece}',
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 4,
            ),
            10.ph,
            GlobalButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductEditScreen(product: product),
                  ),
                );
              },
              data: 'Edit product',
            ),
            24.ph,
          ],
        ),
      ),
    );
  }
}