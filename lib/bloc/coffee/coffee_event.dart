import 'package:coffee_shop/data/models/product/product_field_keys.dart';

abstract class ProductEvent {}

class GetProductEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
}

class UpdateProductEvent extends ProductEvent {}

class UpdateCurrentProductEvent extends ProductEvent {
  final ProductFieldKeys fieldKey;
  final dynamic value;

  UpdateCurrentProductEvent({required this.fieldKey, required this.value});
}

class DeleteProductEvent extends ProductEvent {
  final String productId;

  DeleteProductEvent({required this.productId});
}

class PureEvent extends ProductEvent {}
