import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/repository/product_repo.dart';
import 'package:coffee_shop/ui/user/widgets/favorites_view.dart';
import 'package:coffee_shop/ui/user/widgets/populars_view.dart';
import 'package:coffee_shop/ui/widgets/product_search.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () async {
              await showSearch(
                  context: context, delegate: ProductSearchDelegate(products));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductRepo>().getProducts(),
        builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            products = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.w, bottom: 8.h),
                    child: Text(
                      "Your Favorites",
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FavoritesView(products: snapshot.data!),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 24.w, bottom: 16.h, top: 16.h),
                    child: Text(
                      "Popular Now",
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 0.7,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        ProductModel product = snapshot.data![index];
                        return PopularsView(product: product);
                      },
                      childCount: snapshot.data!.length,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            const Center(
              child: Text(
                'On error',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            const Center(
              child: Text(
                'There are no products yet',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
