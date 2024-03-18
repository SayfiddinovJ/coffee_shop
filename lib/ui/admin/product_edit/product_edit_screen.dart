import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/bloc/coffee/coffee_state.dart';
import 'package:coffee_shop/data/models/product/product_field_keys.dart';
import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:coffee_shop/ui/admin/admin_screen.dart';
import 'package:coffee_shop/ui/admin/widgets/global_text_field.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/utils/dialogs/loading.dart';
import 'package:coffee_shop/utils/dialogs/show_dialog.dart';
import 'package:coffee_shop/utils/extensions/extensions.dart';
import 'package:coffee_shop/utils/formats/price_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  int selectedUnitIndex = 0;
  List<String> units = ['Kilogram', 'Litr', 'Dona'];
  String selectedUnit = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<ProductBloc>().add(PureEvent());
    selectedUnit = widget.product.piece;
    _nameController.text = widget.product.name;
    _priceController.text = widget.product.price;
    _descriptionController.text = widget.product.description;
    context.read<ProductBloc>().add(UpdateCurrentProductEvent(
        fieldKey: ProductFieldKeys.id, value: widget.product.productId));
    context.read<ProductBloc>().add(UpdateCurrentProductEvent(
        fieldKey: ProductFieldKeys.piece, value: selectedUnit));
    context.read<ProductBloc>().add(UpdateCurrentProductEvent(
        fieldKey: ProductFieldKeys.image, value: widget.product.image));
    context.read<ProductBloc>().add(UpdateCurrentProductEvent(
        fieldKey: ProductFieldKeys.name, value: _nameController.text));
    context.read<ProductBloc>().add(UpdateCurrentProductEvent(
        fieldKey: ProductFieldKeys.price, value: _priceController.text));
    context.read<ProductBloc>().add(UpdateCurrentProductEvent(
        fieldKey: ProductFieldKeys.description,
        value: _descriptionController.text));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
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
                    GlobalTextField(
                      hintText: 'Name',
                      controller: _nameController,
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
                      controller: _priceController,
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
                    DropdownButtonFormField2<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      value: selectedUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          context.read<ProductBloc>().add(
                                UpdateCurrentProductEvent(
                                  fieldKey: ProductFieldKeys.piece,
                                  value: newValue,
                                ),
                              );
                          selectedUnit = newValue!;
                        });
                      },
                      items: units
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    24.ph,
                    SizedBox(
                      height: 120.h,
                      child: GlobalTextField(
                        hintText: 'Description',
                        controller: _descriptionController,
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
                        context.read<ProductBloc>().add(UpdateProductEvent());
                      } else {
                        Fluttertoast.showToast(
                          msg:
                              "${context.read<ProductBloc>().canRequest()} is not filled",
                          textColor: Colors.white,
                        );
                      }
                    },
                    data: 'Edit product'),
              ),
              24.ph,
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.loading) {
            showLoading(context: context);
            const Center(child: CircularProgressIndicator());
          }
          if (state.status == FormStatus.success) {
            context.read<ProductBloc>().add(UpdateCurrentProductEvent(
                fieldKey: ProductFieldKeys.image, value: ''));
            Fluttertoast.showToast(msg: 'Product updated successfully');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
