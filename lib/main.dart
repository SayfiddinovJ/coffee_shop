import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/data/local/storage_repository.dart';
import 'package:coffee_shop/repository/product_repo.dart';
import 'package:coffee_shop/ui/admin/admin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ProductRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductBloc(productRepo: context.read<ProductRepo>()),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminScreen(),
      ),
    );
  }
}
