import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/repository/coffee_repo.dart';
import 'package:coffee_shop/ui/admin/coffee_add_screen/coffee_add_screen.dart';
import 'package:coffee_shop/ui/admin/coffees_screen/widgets/coffee_container.dart';
import 'package:coffee_shop/ui/widgets/coffee_search.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoffeesScreen extends StatefulWidget {
  const CoffeesScreen({super.key});

  @override
  State<CoffeesScreen> createState() => _CoffeesScreenState();
}

class _CoffeesScreenState extends State<CoffeesScreen> {
  List<CoffeeModel> coffees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('All coffees'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                  context: context, delegate: CoffeeSearchDelegate(coffees));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CoffeeAddScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<CoffeeModel>>(
        stream: context.read<CoffeeRepo>().getCoffees(),
        builder: (context, AsyncSnapshot<List<CoffeeModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              children: [
                ...List.generate(
                  snapshot.data!.length,
                  (index) {
                    CoffeeModel coffee = snapshot.data![index];
                    coffees = snapshot.data!;
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: CoffeeContainer(coffee: coffee),
                    );
                  },
                )
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
