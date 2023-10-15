import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:equatable/equatable.dart';

class CoffeeState extends Equatable {
  final String statusText;
  final int count;
  final CoffeeModel coffeeModel;
  final List<CoffeeModel> coffees;
  final FormStatus status;

  const CoffeeState({
    required this.statusText,
    required this.coffeeModel,
    required this.coffees,
    required this.status,
    required this.count,
  });

  CoffeeState copyWith({
    String? statusText,
    int? count,
    CoffeeModel? coffeeModel,
    List<CoffeeModel>? coffees,
    FormStatus? status,
  }) {
    return CoffeeState(
      statusText: statusText ?? this.statusText,
      coffeeModel: coffeeModel ?? this.coffeeModel,
      coffees: coffees ?? this.coffees,
      status: status ?? this.status,
      count: count ?? this.count,
    );
  }

  String canRequest() {
    if (coffeeModel.name.isEmpty) return 'Name';
    if (coffeeModel.price.isEmpty) return 'Price';
    if (coffeeModel.type.isEmpty) return 'Type';
    if (coffeeModel.image.isEmpty) return 'Image';
    if (coffeeModel.description.isEmpty) return 'Description';
    return '';
  }

  @override
  List<Object?> get props => [statusText, status, coffeeModel, coffees, count];
}
