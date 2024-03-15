import 'dart:async';

import 'package:coffee_shop/bloc/coffee/coffee_event.dart';
import 'package:coffee_shop/bloc/coffee/coffee_state.dart';
import 'package:coffee_shop/data/models/product/product_field_keys.dart';
import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:coffee_shop/repository/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo coffeeRepo;

  ProductBloc({required this.coffeeRepo})
      : super(ProductState(
          productModel: ProductModel(
            productId: '',
            name: '',
            price: '',
            image: '',
            description: '',
            createdAt: '',
            count: '0',
          ),
          status: FormStatus.pure,
          products: const [],
          statusText: '',
        )) {
    on<ProductEvent>((event, emit) {});
    on<AddProductEvent>(addProduct);
    on<UpdateProductEvent>(updateProduct);
    on<DeleteProductEvent>(deleteProduct);
    on<UpdateCurrentProductEvent>(updateCurrentProductField);
  }

  Future<void> addProduct(
      AddProductEvent addProductEvent, Emitter<ProductState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    debugPrint('Add product bloc');
    UniversalData data =
        await coffeeRepo.addProduct(productModel: state.productModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success, statusText: 'Coffee added successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Coffee add failure'));
    }
  }

  Future<void> updateProduct(
      UpdateProductEvent updateProductEvent, Emitter<ProductState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    UniversalData data =
        await coffeeRepo.updateProduct(productModel: state.productModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success,
          statusText: 'Coffee update successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Coffee update failure'));
    }
  }

  Future<void> deleteProduct(
      DeleteProductEvent deleteProductEvent, Emitter<ProductState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    UniversalData data =
        await coffeeRepo.deleteProduct(productId: deleteProductEvent.productId);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success,
          statusText: 'Coffee deleted successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Coffee deleted failure'));
    }
  }

  String canRequest() {
    return state.canRequest();
  }

  updateCurrentProductField(UpdateCurrentProductEvent updateCurrentProductEvent,
      Emitter<ProductState> emit) {
    ProductModel currentProduct = state.productModel;

    switch (updateCurrentProductEvent.fieldKey) {
      case ProductFieldKeys.name:
        currentProduct = currentProduct.copyWith(
            name: updateCurrentProductEvent.value as String);
        break;

      case ProductFieldKeys.image:
        currentProduct = currentProduct.copyWith(
            image: updateCurrentProductEvent.value as String);
        break;

      case ProductFieldKeys.id:
        currentProduct = currentProduct.copyWith(
            productId: updateCurrentProductEvent.value as String);
        break;

      case ProductFieldKeys.createdAt:
        currentProduct = currentProduct.copyWith(
            createdAt: updateCurrentProductEvent.value as String);
        break;

      case ProductFieldKeys.price:
        currentProduct = currentProduct.copyWith(
            price: updateCurrentProductEvent.value as String);
        break;

      case ProductFieldKeys.count:
        currentProduct = currentProduct.copyWith(
            count: updateCurrentProductEvent.value as String);
        break;

      case ProductFieldKeys.description:
        currentProduct = currentProduct.copyWith(
            description: updateCurrentProductEvent.value as String);
        break;
    }

    debugPrint("Coffee Model: $currentProduct");
    emit(state.copyWith(productModel: currentProduct));
  }
}
