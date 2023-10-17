import 'package:coffee_shop/bloc/order/order_bloc.dart';
import 'package:coffee_shop/bloc/order/order_state.dart';
import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:coffee_shop/ui/coffee_detail/widgets/coffee_stack.dart';
import 'package:coffee_shop/ui/user/widgets/phone_address_dialog.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CoffeeDetailScreen extends StatelessWidget {
  const CoffeeDetailScreen({super.key, required this.coffee});

  final CoffeeModel coffee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<OrderBloc, OrderState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    40.ph,
                    CoffeeStack(coffee: coffee),
                    24.ph,
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    8.ph,
                    Text(
                      coffee.description,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: GlobalButton(
                    onPressed: () {
                      showPADialog(context, coffee);
                    },
                    data: 'Order now'),
              ),
              24.ph,
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.loading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == FormStatus.success) {
            Fluttertoast.showToast(msg: 'Coffee ordered');
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
