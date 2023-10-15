import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:flutter/foundation.dart';

class CoffeeRepo {
  Future<UniversalData> addCoffee({required CoffeeModel coffeeModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('coffees')
          .doc(coffeeModel.coffeeId)
          .set(coffeeModel.toJson());

      return UniversalData(data: 'Coffee added!');
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateCoffee({required CoffeeModel coffeeModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('coffees')
          .doc(coffeeModel.coffeeId)
          .update(coffeeModel.toJson());

      return UniversalData(data: "Coffee updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteCoffee({required String coffeeId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('coffees')
          .doc(coffeeId)
          .delete();

      return UniversalData(data: "Coffee deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<CoffeeModel>> getCoffees() {
    try {
      final collectionStream =
      FirebaseFirestore.instance.collection('coffees').snapshots();
      return collectionStream.map((snapshot) =>
          snapshot.docs.map((doc) => CoffeeModel.fromJson(doc.data())).toList());
    } on FirebaseException catch (e) {
      debugPrint('Firebase Exception: $e');
      return Stream.value([]);
    } catch (error) {
      debugPrint('Error: $error');
      return Stream.value([]);
    }
  }
}
