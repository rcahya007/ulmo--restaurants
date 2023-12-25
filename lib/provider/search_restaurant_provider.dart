import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/data/model/search_result_response_model.dart';

enum ResultStateSearch { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  ApiRestaurant apiRestaurant = ApiRestaurant();
  SearchRestaurantProvider({required this.apiRestaurant});

  late SearchRestaurantResult _restaurantResult;
  late ResultStateSearch _state;
  String _message = '';

  SearchRestaurantResult get restaurantResult => _restaurantResult;
  ResultStateSearch get state => _state;
  String get message => _message;

  Future<dynamic> searchRestaurant(String input) async {
    try {
      _state = ResultStateSearch.loading;
      notifyListeners();
      final searchRestaurant = await ApiRestaurant().searchResult(input);
      if (searchRestaurant.error) {
        _state = ResultStateSearch.noData;
        notifyListeners();
        return _message = 'No data restaurant';
      } else {
        _state = ResultStateSearch.hasData;
        notifyListeners();
        return _restaurantResult = searchRestaurant;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultStateSearch.error;
        notifyListeners();
        return _message = 'Check your internet connection';
      } else {
        _state = ResultStateSearch.error;
        notifyListeners();
        return _message = 'Error --> $e';
      }
    }
  }
}
