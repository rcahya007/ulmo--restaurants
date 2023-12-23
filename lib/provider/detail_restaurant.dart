import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/data/model/detail_restaurant_response_model.dart';

enum ResultStateDetail { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiRestaurant apiRestaurant;
  String id;
  DetailRestaurantProvider({required this.apiRestaurant, required this.id}) {
    _fetchDetailRestaurant();
  }

  late DetailRestaurantResponseModel _detailRestaurantResponseModel;
  late ResultStateDetail _state;
  String _message = '';

  String get message => _message;
  DetailRestaurantResponseModel get detailRestaurantResponseModel =>
      _detailRestaurantResponseModel;
  ResultStateDetail get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultStateDetail.loading;
      notifyListeners();
      final detailRestaurant = await ApiRestaurant().getDetailRestaurant(id);
      if (detailRestaurant.error) {
        _state = ResultStateDetail.noData;
        notifyListeners();
        return _message = detailRestaurant.message;
      } else {
        _state = ResultStateDetail.hasData;
        notifyListeners();
        return _detailRestaurantResponseModel = detailRestaurant;
      }
    } catch (e) {
      _state = ResultStateDetail.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
