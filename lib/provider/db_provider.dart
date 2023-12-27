import 'package:flutter/foundation.dart';
import 'package:ulmo_restaurants/data/model/restaurant_local_model.dart';
import 'package:ulmo_restaurants/database/database_helper.dart';

class DbProvider extends ChangeNotifier {
  List<RestaurantLocalModel> _restaurants = [];
  late DatabaseHelper _dbHelper;

  List<RestaurantLocalModel> get restaurant => _restaurants;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllRestaurant();
  }

  void _getAllRestaurant() async {
    _restaurants = await _dbHelper.getRestaurants();
    notifyListeners();
  }

  Future<void> addRestaurant(RestaurantLocalModel restaurant) async {
    await _dbHelper.insertRestaurant(restaurant);
    _getAllRestaurant();
  }

  Future<RestaurantLocalModel?> getRestaurantById(String id) async {
    return await _dbHelper.getRestaurantById(id);
  }

  void deleteRestaurant(String id) async {
    await _dbHelper.deleteRestaurant(id);
    _getAllRestaurant();
  }
}
