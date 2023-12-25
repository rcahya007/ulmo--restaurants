import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/data/model/restaurants_response_model.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiRestaurant apiRestaurant;
  RestaurantProvider({required this.apiRestaurant}) {
    _fetchAllRestaurant();
  }

  late ListRestaurantResponseModel _listRestaurantResponseModel;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurantResponseModel get result => _listRestaurantResponseModel;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiRestaurant().getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurantResponseModel = restaurant;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Check your internet connection';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Error --> $e';
      }
    }
  }
}
