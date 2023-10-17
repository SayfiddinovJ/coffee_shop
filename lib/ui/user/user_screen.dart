import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/repository/coffee_repo.dart';
import 'package:coffee_shop/ui/user/cart_screens/cart_screen.dart';
import 'package:coffee_shop/ui/user/widgets/favorites_view.dart';
import 'package:coffee_shop/ui/user/widgets/populars_view.dart';
import 'package:coffee_shop/ui/widgets/coffee_search.dart';
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
  List<CoffeeModel> coffees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Coffees'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () async {
              await showSearch(
                  context: context, delegate: CoffeeSearchDelegate(coffees));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<List<CoffeeModel>>(
        stream: context.read<CoffeeRepo>().getCoffees(),
        builder: (context, AsyncSnapshot<List<CoffeeModel>> snapshot) {
          if (snapshot.hasData) {
            coffees = snapshot.data!;
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
                  child: FavoritesView(coffees: snapshot.data!),
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
                        CoffeeModel coffee = snapshot.data![index];
                        return PopularsView(coffee: coffee);
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
                'There are no coffees yet',
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
