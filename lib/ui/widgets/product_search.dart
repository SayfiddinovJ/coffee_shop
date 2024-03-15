import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/ui/admin/widgets/product_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSearchDelegate extends SearchDelegate<ProductModel> {
  final List<ProductModel> productList;

  ProductSearchDelegate(this.productList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          ProductModel(
            productId: '',
            name: '',
            price: '',
            image: '',
            description: '',
            createdAt: '',
            count: '0',
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredCoffeeList = productList
        .where(
            (coffee) => coffee.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredCoffeeList.length,
      itemBuilder: (context, index) {
        final coffee = filteredCoffeeList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: ProductContainer(product: coffee),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? productList
        : productList
            .where((coffee) =>
                coffee.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final coffee = suggestionList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: ProductContainer(product: coffee),
        );
      },
    );
  }
}
