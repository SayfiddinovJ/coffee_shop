import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/bloc/coffee/coffee_state.dart';
import 'package:coffee_shop/data/models/coffee/coffee_field_keys.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:coffee_shop/ui/admin/coffee_add_screen/widgets/drop_down.dart';
import 'package:coffee_shop/ui/admin/coffee_add_screen/widgets/image_upload.dart';
import 'package:coffee_shop/ui/admin/widgets/global_text_field.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/utils/app_colors/app_colors.dart';
import 'package:coffee_shop/utils/dialogs/show_dialog.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:coffee_shop/utils/formats/price_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CoffeeAddScreen extends StatefulWidget {
  const CoffeeAddScreen({super.key});

  @override
  State<CoffeeAddScreen> createState() => _CoffeeAddScreenState();
}

class _CoffeeAddScreenState extends State<CoffeeAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Add Coffee'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: BlocConsumer<CoffeeBloc, CoffeeState>(
        builder: (context, state) {
          if (state.status == FormStatus.failure) {
            showMessage(message: state.statusText, context: context);
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  children: [
                    10.ph,
                    const ImageUpload(),
                    24.ph,
                    GlobalTextField(
                        hintText: 'Name',
                        onChanged: (value) {
                          context.read<CoffeeBloc>().add(
                              UpdateCurrentCoffeeEvent(
                                  fieldKey: CoffeeFieldKeys.name,
                                  value: value));
                        }),
                    24.ph,
                    Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: const CategorySelector(),
                    ),
                    24.ph,
                    GlobalTextField(
                        hintText: 'Price',
                        textInputFormatter: PriceFormatter(),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        onChanged: (value) {
                          context.read<CoffeeBloc>().add(
                              UpdateCurrentCoffeeEvent(
                                  fieldKey: CoffeeFieldKeys.price,
                                  value: value));
                        }),
                    24.ph,
                    SizedBox(
                      height: 120.h,
                      child: GlobalTextField(
                          hintText: 'Description',
                          maxLines: 3,
                          onChanged: (value) {
                            context.read<CoffeeBloc>().add(
                                UpdateCurrentCoffeeEvent(
                                    fieldKey: CoffeeFieldKeys.description,
                                    value: value));
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: GlobalButton(
                    onPressed: () {
                      context.read<CoffeeBloc>().add(UpdateCurrentCoffeeEvent(
                          fieldKey: CoffeeFieldKeys.createdAt,
                          value: DateTime.now().toString()));
                      if (context.read<CoffeeBloc>().canRequest().isEmpty) {
                        context.read<CoffeeBloc>().add(AddCoffeeEvent());
                      } else {
                        Fluttertoast.showToast(
                          msg:
                              "${context.read<CoffeeBloc>().canRequest()} is not filled",
                          backgroundColor: AppColors.black,
                          textColor: Colors.white,
                        );
                      }
                    },
                    data: 'Add new coffee'),
              ),
              24.ph,
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.loading) {
            const Center(child: CircularProgressIndicator());
          }
          if (state.status == FormStatus.success) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
