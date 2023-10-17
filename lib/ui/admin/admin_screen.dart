import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/repository/order_repo.dart';
import 'package:coffee_shop/ui/admin/coffees_screen/coffees_screen.dart';
import 'package:coffee_shop/ui/admin/views/in_progress_orders_view.dart';
import 'package:coffee_shop/ui/admin/views/not_confirmed_view.dart';
import 'package:coffee_shop/ui/admin/views/sent_orders_view.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: const Text('Admin'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CoffeesScreen(),
                  ),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabAlignment: TabAlignment.fill,
            tabs: <Widget>[
              Tab(text: "Not Accepted"),
              Tab(text: 'In progress'),
              Tab(text: 'Sent orders'),
            ],
          ),
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: context.read<OrderRepo>().getOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> notConfirmed = [];
              List<OrderModel> inProgress = [];
              List<OrderModel> sent = [];
              snapshot.data!.map((e) {
                if (e.status == 'Not Confirmed') {
                  notConfirmed.add(e);
                } else if (e.status == 'In Progress') {
                  inProgress.add(e);
                } else if (e.status == 'Sent') {
                  sent.add(e);
                }
              });
              return TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  NotConfirmedView(orders: notConfirmed),
                  InProgressOrdersView(orders: inProgress),
                  SentOrdersView(orders: sent),
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
