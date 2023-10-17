import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class NotOrderedView extends StatelessWidget {
  const NotOrderedView({super.key, required this.orders});

  final List<CoffeeModel> orders;

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Center(
            child: Text(
              'Your cart is empty',
              style: TextStyle(color: AppColors.white),
            ),
          )
        : ListView(
            children: [
              ...List.generate(
                orders.length,
                (index) {
                  CoffeeModel order = orders[index];
                  debugPrint(order.count);
                  return ListTile(
                    title: Text(
                      order.name,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    subtitle: Text(
                      order.count,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  );
                },
              )
            ],
          );
  }
}
