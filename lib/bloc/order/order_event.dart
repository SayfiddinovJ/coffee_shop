import 'package:coffee_shop/data/models/order/order_field_keys.dart';

abstract class OrderEvent {}

class GetOrderEvent extends OrderEvent {}

class AddOrderEvent extends OrderEvent {}

class UpdateOrderEvent extends OrderEvent {}

class UpdateCurrentOrderEvent extends OrderEvent {
  final OrderFieldKeys fieldKey;
  final dynamic value;

  UpdateCurrentOrderEvent({required this.fieldKey, required this.value});
}

class DeleteOrderEvent extends OrderEvent {
  final String orderId;

  DeleteOrderEvent({required this.orderId});
}
