import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/repository/order_repo.dart';
import 'package:coffee_shop/ui/admin/coffees_screen/coffees_screen.dart';
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Admin'),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CoffeesScreen(),
                  ),
                );
              }),
        ],
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: context.read<OrderRepo>().getOrders(),
        builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text(
                      'There are no orders yet',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView(
                    children: [
                      ...List.generate(
                        snapshot.data!.length,
                        (index) {
                          OrderModel order = snapshot.data![index];
                          return ListTile(
                            title: Text(
                              order.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
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
