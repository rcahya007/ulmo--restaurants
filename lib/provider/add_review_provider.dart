import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/data/model/add_review_request_model.dart';
import 'package:ulmo_restaurants/data/model/add_review_response_model.dart';

enum ResultState { loading, noData, hasData, error }

class AddReviewProvider extends ChangeNotifier {
  final ApiRestaurant apiRestaurant;
  AddReviewProvider({required this.apiRestaurant});

  late AddRiviewResponseModel _addRiviewResponseModel;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  AddRiviewResponseModel get addRiviewResponseModel => _addRiviewResponseModel;
  ResultState get state => _state;

  void postReview(AddRiviewRequestModel dataReview) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final postReview = await ApiRestaurant().postReview(dataReview);
      if (postReview.error) {
        _state = ResultState.noData;
        notifyListeners();
        _message = postReview.message;
        print(message);
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _addRiviewResponseModel = postReview;
        print(addRiviewResponseModel);
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error --> $e';
      print(message);
    }
  }
}
