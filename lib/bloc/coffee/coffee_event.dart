import 'package:coffee_shop/data/models/coffee/coffee_field_keys.dart';

abstract class CoffeeEvent {}

class GetCoffeeEvent extends CoffeeEvent {}

class AddCoffeeEvent extends CoffeeEvent {
}

class UpdateCoffeeEvent extends CoffeeEvent {}

class UpdateCurrentCoffeeEvent extends CoffeeEvent {
  final CoffeeFieldKeys fieldKey;
  final dynamic value;

  UpdateCurrentCoffeeEvent({required this.fieldKey, required this.value});
}

class DeleteCoffeeEvent extends CoffeeEvent {
  final String coffeeId;

  DeleteCoffeeEvent({required this.coffeeId});
}
