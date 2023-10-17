import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/data/models/category/categories.dart';
import 'package:coffee_shop/data/models/coffee/coffee_field_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      borderRadius: BorderRadius.circular(10.r),
      dropdownColor: Colors.black,
      isExpanded: true,
      hint: const Row(
        children: [
          Expanded(
            child: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: categories
          .map((String item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ))
          .toList(),
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
          context.read<CoffeeBloc>().add(
              UpdateCurrentCoffeeEvent(
                  fieldKey: CoffeeFieldKeys.category,
                  value: value));
      },
    );
  }
}
