import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/data/models/product/product_model.dart';
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
                        print(product.productId);
                        context.read<ProductBloc>().add(DeleteProductEvent(
                            productId: product.productId ?? ''));
                        Navigator.pop(context);
                        // Navigator.pop(context);
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.productId ?? 'null',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  height: 450.h,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name - ${product.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Price - ${product.price} so\'m',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Description - ${product.description}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
