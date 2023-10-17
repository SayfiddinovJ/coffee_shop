import 'package:coffee_shop/bloc/order/order_bloc.dart';
import 'package:coffee_shop/bloc/order/order_event.dart';
import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/data/models/order/order_field_keys.dart';
import 'package:coffee_shop/ui/admin/widgets/global_text_field.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showPADialog(BuildContext context, CoffeeModel coffee) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      title: const Text(
        "Order Now",
        style: TextStyle(color: AppColors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalTextField(
            hintText: 'Address',
            onChanged: (v) {
              context.read<OrderBloc>().add(
                    UpdateCurrentOrderEvent(
                      fieldKey: OrderFieldKeys.address,
                      value: v,
                    ),
                  );
            },
          ),
          16.ph,
          GlobalTextField(
            hintText: 'Phone',
            onChanged: (v) {
              context.read<OrderBloc>().add(
                    UpdateCurrentOrderEvent(
                      fieldKey: OrderFieldKeys.phone,
                      value: v,
                    ),
                  );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (context.read<OrderBloc>().canRequest().isEmpty) {
              context.read<OrderBloc>().add(UpdateCurrentOrderEvent(
                  fieldKey: OrderFieldKeys.orders, value: [coffee]));

              context.read<OrderBloc>().add(UpdateCurrentOrderEvent(
                  fieldKey: OrderFieldKeys.status, value: 'Ordered'));
              context.read<OrderBloc>().add(UpdateCurrentOrderEvent(
                  fieldKey: OrderFieldKeys.createdAt,
                  value: DateTime.now().toString()));
              context.read<OrderBloc>().add(AddOrderEvent());
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(msg: 'Fill the fields');
            }
          },
          child: const Text(
            "Ok",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
    ),
  );
}
