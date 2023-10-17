import 'package:coffee_shop/data/models/coffee/coffee_model.dart';

class OrderModel {
  final String orderId;
  final List<CoffeeModel> orders;
  final String status;
  final String phone;
  final String address;
  final String total;
  final String createdAt;

  OrderModel({
    required this.orderId,
    required this.orders,
    required this.status,
    required this.phone,
    required this.address,
    required this.total,
    required this.createdAt,
  });

  OrderModel copyWith({
    String? orderId,
    List<CoffeeModel>? orders,
    String? status,
    String? phone,
    String? address,
    String? total,
    String? createdAt,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      orders: orders ?? this.orders,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> orderList = json['orders'];
    final orders = orderList.map((e) => CoffeeModel.fromJson(e)).toList();

    return OrderModel(
      orderId: json['orderId'],
      orders: orders,
      status: json['status'],
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
    phone: $phone, 
    address: $address, 
    total: $total, 
    createdAt: $createdAt
    ''';
  }
}
