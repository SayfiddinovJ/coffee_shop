import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/repository/product_repo.dart';
import 'package:coffee_shop/ui/admin/product_add/product_add_screen.dart';
import 'package:coffee_shop/ui/admin/widgets/product_container.dart';
import 'package:coffee_shop/ui/widgets/product_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products.isEmpty ? 'Admin' : 'Products'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                  context: context, delegate: ProductSearchDelegate(products));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductRepo>().getProducts(),
        builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                children: [
                  ...List.generate(
                    snapshot.data!.length,
                    (index) {
                      ProductModel product = snapshot.data![index];
                      products = snapshot.data!;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: ProductContainer(product: product),
                      );
                    },
                  )
                ],
              );
            } else {
              return const Center(child: Text('There are no products yet'));
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('On error'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductAddScreen(),
            ),
          );
        },
      ),
    );
  }
}
