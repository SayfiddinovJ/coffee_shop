import 'package:coffee_shop/data/models/coffee/coffee_model.dart';

class OrderModel {
  final String orderId;
  final List<CoffeeModel> orders;
  final String status;
  final String name;
  final String phone;
  final String address;
  final String total;
  final String createdAt;

  OrderModel({
    required this.orderId,
    required this.orders,
    required this.status,
    required this.name,
    required this.phone,
    required this.address,
    required this.total,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> orderList = json['orders'];
    final orders = orderList.map((e) => CoffeeModel.fromJson(e)).toList();

    return OrderModel(
      orderId: json['orderId'],
      orders: orders,
      status: json['status'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      total: json['total'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final List<dynamic> orderList = orders.map((e) => e.toJson()).toList();

    return {
      'orderId': orderId,
      'orders': orderList,
      'status': status,
      'name': name,
      'phone': phone,
      'address': address,
      'total': total,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return '''
    orderId: $orderId,
    orders: $orders,
    status: $status,
    name: $name,
    phone: $phone, 
    address: $address, 
    total: $total, 
    createdAt: $createdAt
    ''';
  }
}
