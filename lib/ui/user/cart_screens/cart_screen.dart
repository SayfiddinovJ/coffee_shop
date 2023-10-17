import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/repository/order_repo.dart';
import 'package:coffee_shop/ui/user/cart_screens/views/confirmed_orders_view.dart';
import 'package:coffee_shop/ui/user/cart_screens/views/not_ordered_view.dart';
import 'package:coffee_shop/ui/user/cart_screens/views/ordered_view.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/user_orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          bottom: const TabBar(
            tabAlignment: TabAlignment.fill,
            tabs: <Widget>[
              Tab(text: "Not ordered"),
              Tab(text: 'Ordered'),
              Tab(text: 'Confirmed'),
            ],
          ),
          title: const Text(
            'Cart',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: context.read<OrderRepo>().getOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CoffeeModel> inProgress = [];
              List<CoffeeModel> sent = [];
              int i = 0;
              for (OrderModel element in snapshot.data!) {
                if (element.orders[i].status == "In Progress") {
                  inProgress.add(element.orders[i]);
                } else if (element.orders[i].status == "Sent") {
                  inProgress.add(element.orders[i]);
                }
                i++;
              }

              return TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  NotOrderedView(orders: coffeeOrders),
                  OrderedView(orders: inProgress),
                  ConfirmedOrdersView(orders: sent),
                ],
              );
            } else if (snapshot.hasError) {
              const Center(
                child: Text(
                  'On error',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
