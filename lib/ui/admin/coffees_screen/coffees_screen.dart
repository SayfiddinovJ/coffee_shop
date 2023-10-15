import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/repository/coffee_repo.dart';
import 'package:coffee_shop/ui/admin/coffee_add_screen/coffee_add_screen.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeesScreen extends StatefulWidget {
  const CoffeesScreen({super.key});

  @override
  State<CoffeesScreen> createState() => _CoffeesScreenState();
}

class _CoffeesScreenState extends State<CoffeesScreen> {
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CoffeeAddScreen(),
                  ),
                );
              }),
        ],
      ),
      body: StreamBuilder<List<CoffeeModel>>(
        stream: context.read<CoffeeRepo>().getCoffees(),
        builder: (context, AsyncSnapshot<List<CoffeeModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                ...List.generate(
                  snapshot.data!.length,
                  (index) {
                    CoffeeModel coffee = snapshot.data![index];
                    return ListTile(
                      leading: Image.network(
                        coffee.image,
                        height: 50,
                        width: 50,
                      ),
                      title: Text(
                        coffee.name,
                        style: const TextStyle(color: Colors.white),
                      ),
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
