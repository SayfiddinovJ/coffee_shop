import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:equatable/equatable.dart';

class OrderState extends Equatable {
  final String statusText;
  final int count;
  final OrderModel orderModel;
  final List<OrderModel> orders;
  final FormStatus status;

  const OrderState({
    required this.statusText,
    required this.orderModel,
    required this.orders,
    required this.status,
    required this.count,
  });

  OrderState copyWith({
    String? statusText,
    int? count,
    OrderModel? orderModel,
    List<OrderModel>? orders,
    FormStatus? status,
  }) {
    return OrderState(
      statusText: statusText ?? this.statusText,
      orderModel: orderModel ?? this.orderModel,
      orders: orders ?? this.orders,
      status: status ?? this.status,
      count: count ?? this.count,
    );
  }

  String canRequest() {
    if (orderModel.address.isEmpty) 'Address is required';
    if (orderModel.phone.isEmpty) 'Phone is required';
    return '';
  }

  @override
  List<Object?> get props => [statusText, status, orderModel, orders, count];
}
