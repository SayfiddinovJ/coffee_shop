import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:flutter/foundation.dart';

class OrderRepo {
  Future<UniversalData> addOrder({required OrderModel orderModel}) async {
    try {
      DocumentReference newOrder = await FirebaseFirestore.instance
          .collection("orders")
          .add(orderModel.toJson());

      await FirebaseFirestore.instance
          .collection("orders")
          .doc(newOrder.id)
          .update({
        "orderId": newOrder.id,
      });

      return UniversalData(data: "Order added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateOrder({required OrderModel orderModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderModel.orderId)
          .update(orderModel.toJson());

      return UniversalData(data: "Order updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteOrder({required String orderId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .delete();

      return UniversalData(data: "Order deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<OrderModel>> getOrders() {
    try {
      final collectionStream =
          FirebaseFirestore.instance.collection('orders').snapshots();
      return collectionStream.map((snapshot) =>
          snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList());
    } on FirebaseException catch (e) {
      debugPrint('Firebase Exception: $e');
      return Stream.value([]);
    } catch (error) {
      debugPrint('Error: $error');
      return Stream.value([]);
    }
  }
}
