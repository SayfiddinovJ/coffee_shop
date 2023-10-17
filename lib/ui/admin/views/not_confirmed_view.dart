import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class NotConfirmedView extends StatelessWidget {
  const NotConfirmedView({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Center(
            child: Text(
              'You have no pending orders',
              style: TextStyle(color: AppColors.white),
            ),
          )
        : ListView(
            children: [
              ...List.generate(
                orders.length,
                (index) {
                  OrderModel order = orders[index];
                  return ListTile(
                    title: Text(
                      order.phone,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    subtitle: Text(
                      order.status,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  );
                },
              )
            ],
          );
  }
}
