import 'dart:async';

import 'package:coffee_shop/bloc/order/order_event.dart';
import 'package:coffee_shop/bloc/order/order_state.dart';
import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/data/models/order/order_field_keys.dart';
import 'package:coffee_shop/data/models/order/order_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:coffee_shop/repository/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepo orderRepo;

  OrderBloc({required this.orderRepo})
      : super(OrderState(
          orderModel: OrderModel(
            orderId: '',
            orders: [],
            status: '',
            phone: '',
            address: '',
            total: '',
            createdAt: '',
          ),
          status: FormStatus.pure,
          orders: const [],
          statusText: '',
          count: 0,
        )) {
    on<OrderEvent>((event, emit) {});
    on<AddOrderEvent>(addOrder);
    on<UpdateOrderEvent>(updateOrder);
    on<DeleteOrderEvent>(deleteOrder);
    on<UpdateCurrentOrderEvent>(updateCurrentOrderField);
  }

  Future<void> addOrder(
      AddOrderEvent addOrderEvent, Emitter<OrderState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    UniversalData data = await orderRepo.addOrder(orderModel: state.orderModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success, statusText: 'Order added successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Order add failure'));
    }
  }

  String canRequest(){
  return  state.canRequest();
  }

  Future<void> updateOrder(
      UpdateOrderEvent updateOrderEvent, Emitter<OrderState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    UniversalData data =
        await orderRepo.updateOrder(orderModel: state.orderModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success,
          statusText: 'Order update successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Order update failed'));
    }
  }

  Future<void> deleteOrder(
      DeleteOrderEvent deleteOrderEvent, Emitter<OrderState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    UniversalData data =
        await orderRepo.deleteOrder(orderId: deleteOrderEvent.orderId);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success,
          statusText: 'Order deleted successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Order deleted failure'));
    }
  }

  updateCurrentOrderField(UpdateCurrentOrderEvent updateCurrentOrderEvent,
      Emitter<OrderState> emit) {
    OrderModel currentOrder = state.orderModel;

    switch (updateCurrentOrderEvent.fieldKey) {
      case OrderFieldKeys.phone:
        currentOrder = currentOrder.copyWith(
            phone: updateCurrentOrderEvent.value as String);
        break;
      case OrderFieldKeys.address:
        currentOrder = currentOrder.copyWith(
            address: updateCurrentOrderEvent.value as String);
        break;
      case OrderFieldKeys.total:
        currentOrder = currentOrder.copyWith(
            total: updateCurrentOrderEvent.value as String);
        break;
      case OrderFieldKeys.orderId:
        currentOrder = currentOrder.copyWith(
            orderId: updateCurrentOrderEvent.value as String);
        break;
      case OrderFieldKeys.orders:
        currentOrder = currentOrder.copyWith(
            orders: updateCurrentOrderEvent.value as List<CoffeeModel>);
        break;
      case OrderFieldKeys.status:
        currentOrder = currentOrder.copyWith(
            status: updateCurrentOrderEvent.value as String);
        break;
      case OrderFieldKeys.createdAt:
        currentOrder = currentOrder.copyWith(
            createdAt: updateCurrentOrderEvent.value as String);
        break;
    }

    debugPrint("Order Model: $currentOrder");
    emit(state.copyWith(orderModel: currentOrder));
  }
}
