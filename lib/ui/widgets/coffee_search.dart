import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/ui/admin/coffees_screen/widgets/coffee_container.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoffeeSearchDelegate extends SearchDelegate<CoffeeModel> {
  final List<CoffeeModel> coffeeList;

  CoffeeSearchDelegate(this.coffeeList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: AppColors.FF0C0F14,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 18.sp),
      ),
      scaffoldBackgroundColor: AppColors.FF0C0F14,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(
          context,
          CoffeeModel(
            coffeeId: '',
            name: '',
            type: '',
            price: '',
            image: '',
            description: '',
            createdAt: '',
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredCoffeeList = coffeeList
        .where(
            (coffee) => coffee.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredCoffeeList.length,
      itemBuilder: (context, index) {
        final coffee = filteredCoffeeList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: CoffeeContainer(coffee: coffee),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? coffeeList
        : coffeeList
            .where((coffee) =>
                coffee.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final coffee = suggestionList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: CoffeeContainer(coffee: coffee),
        );
      },
    );
  }
}
