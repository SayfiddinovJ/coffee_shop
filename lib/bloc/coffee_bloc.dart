import 'dart:async';

import 'package:coffee_shop/bloc/coffee_event.dart';
import 'package:coffee_shop/bloc/coffee_state.dart';
import 'package:coffee_shop/data/models/coffee/coffee_field_keys.dart';
import 'package:coffee_shop/data/models/coffee/coffee_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:coffee_shop/repository/coffee_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final CoffeeRepo coffeeRepo;

  CoffeeBloc({required this.coffeeRepo})
      : super(CoffeeState(
          coffeeModel: CoffeeModel(
            coffeeId: '',
            name: '',
            type: '',
            price: '',
            image: '',
            description: '',
            createdAt: '',
            // count: 0,
          ),
          status: FormStatus.pure,
          coffees: const [],
          statusText: '',
          count: 0,
        )) {
    on<CoffeeEvent>((event, emit) {});
    on<AddCoffeeEvent>(addCoffee);
    on<UpdateCoffeeEvent>(updateCoffee);
    on<DeleteCoffeeEvent>(deleteCoffee);
    on<UpdateCurrentCoffeeEvent>(updateCurrentCoffeeField);
  }

  Future<void> addCoffee(
      AddCoffeeEvent addCoffeeEvent, Emitter<CoffeeState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    debugPrint('Add coffee bloc');
    UniversalData data =
        await coffeeRepo.addCoffee(coffeeModel: state.coffeeModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success, statusText: 'Coffee added successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Coffee add failure'));
    }
  }

  Future<void> updateCoffee(
      UpdateCoffeeEvent updateCoffeeEvent, Emitter<CoffeeState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    UniversalData data =
        await coffeeRepo.updateCoffee(coffeeModel: state.coffeeModel);
    if (data.error.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.success,
          statusText: 'Coffee update successfully'));
    } else {
      emit(state.copyWith(
          status: FormStatus.failure, statusText: 'Coffee update failure'));
    }
  }

  Future<void> deleteCoffee(
      DeleteCoffeeEvent deleteCoffeeEvent, Emitter<CoffeeState> emit) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    UniversalData data =
        await coffeeRepo.deleteCoffee(coffeeId: deleteCoffeeEvent.coffeeId);
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

  updateCurrentCoffeeField(UpdateCurrentCoffeeEvent updateCurrentUserEvent,
      Emitter<CoffeeState> emit) {
    CoffeeModel currentCoffee = state.coffeeModel;

    switch (updateCurrentUserEvent.fieldKey) {
      case CoffeeFieldKeys.name:
        currentCoffee = currentCoffee.copyWith(
            name: updateCurrentUserEvent.value as String);
        break;

      case CoffeeFieldKeys.image:
        currentCoffee = currentCoffee.copyWith(
            image: updateCurrentUserEvent.value as String);
        break;

      case CoffeeFieldKeys.id:
        currentCoffee = currentCoffee.copyWith(
            coffeeId: updateCurrentUserEvent.value as String);
        break;

      case CoffeeFieldKeys.createdAt:
        currentCoffee = currentCoffee.copyWith(
            createdAt: updateCurrentUserEvent.value as String);
        break;

      case CoffeeFieldKeys.price:
        currentCoffee = currentCoffee.copyWith(
            price: updateCurrentUserEvent.value as String);
        break;

      // case CoffeeFieldKeys.count:
      //   currentCoffee =
      //       currentCoffee.copyWith(count: updateCurrentUserEvent.value as int);
      //   break;

      case CoffeeFieldKeys.description:
        currentCoffee = currentCoffee.copyWith(
            description: updateCurrentUserEvent.value as String);
        break;

      case CoffeeFieldKeys.category:
        currentCoffee = currentCoffee.copyWith(
            type: updateCurrentUserEvent.value as String);
        break;
    }

    debugPrint("Coffee Model: $currentCoffee");
    emit(state.copyWith(coffeeModel: currentCoffee));
  }
}
