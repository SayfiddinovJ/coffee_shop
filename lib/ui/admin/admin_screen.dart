import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/repository/coffee_repo.dart';
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
      backgroundColor: AppColors.FF0C0F14,
      appBar: AppBar(
        backgroundColor: AppColors.FF0C0F14,
        title: const Text('Admin'),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {}),
        ],
      ),
      body: StreamBuilder<List<CoffeeModel>>(
        stream: context.read<CoffeeRepo>().getCoffees(),
        builder: (context, AsyncSnapshot<List<CoffeeModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView(children: [
              ...List.generate(snapshot.data!.length, (index) {
                CoffeeModel coffee = snapshot.data![index];
                return ListTile(
                  leading: Image.network(coffee.image),
                  title: Text(
                    coffee.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              })
            ]);
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