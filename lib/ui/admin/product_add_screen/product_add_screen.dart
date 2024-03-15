import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/bloc/coffee/coffee_state.dart';
import 'package:coffee_shop/data/models/product/product_field_keys.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:coffee_shop/ui/admin/product_add_screen/widgets/image_upload.dart';
import 'package:coffee_shop/ui/admin/widgets/global_text_field.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/utils/dialogs/show_dialog.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:coffee_shop/utils/formats/price_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        elevation: 0,
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
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
                        context.read<ProductBloc>().add(
                              UpdateCurrentProductEvent(
                                fieldKey: ProductFieldKeys.name,
                                value: value,
                              ),
                            );
                      },
                    ),
                    24.ph,
                    GlobalTextField(
                      hintText: 'Price',
                      textInputFormatter: PriceFormatter(),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      onChanged: (value) {
                        context.read<ProductBloc>().add(
                              UpdateCurrentProductEvent(
                                fieldKey: ProductFieldKeys.price,
                                value: value,
                              ),
                            );
                      },
                    ),
                    24.ph,
                    SizedBox(
                      height: 120.h,
                      child: GlobalTextField(
                        hintText: 'Description',
                        maxLines: 3,
                        onChanged: (value) {
                          context.read<ProductBloc>().add(
                                UpdateCurrentProductEvent(
                                  fieldKey: ProductFieldKeys.description,
                                  value: value,
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: GlobalButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(UpdateCurrentProductEvent(
                          fieldKey: ProductFieldKeys.createdAt,
                          value: DateTime.now().toString()));
                      if (context.read<ProductBloc>().canRequest().isEmpty) {
                        context.read<ProductBloc>().add(AddProductEvent());
                      } else {
                        Fluttertoast.showToast(
                          msg:
                              "${context.read<ProductBloc>().canRequest()} is not filled",
                          textColor: Colors.white,
                        );
                      }
                    },
                    data: 'Add new product'),
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
            context.read<ProductBloc>().add(UpdateCurrentProductEvent(
                fieldKey: ProductFieldKeys.image, value: ''));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}