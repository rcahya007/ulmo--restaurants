import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/data/model/add_review_request_model.dart';
import 'package:ulmo_restaurants/data/model/add_review_response_model.dart';

enum ResultStateAddReview { loading, noData, hasData, error }

class AddReviewProvider extends ChangeNotifier {
  final ApiRestaurant apiRestaurant;
  AddReviewProvider({required this.apiRestaurant});

  // Setter
  late AddRiviewResponseModel _addRiviewResponseModel;
  ResultStateAddReview _state = ResultStateAddReview.noData;
  String _message = '';

  // Getter
  AddRiviewResponseModel get addRiviewResponseModel => _addRiviewResponseModel;
  ResultStateAddReview get state => _state;
  String get message => _message;

  Future<dynamic> postReview(AddRiviewRequestModel dataReview) async {
    try {
      _state = ResultStateAddReview.loading;
      notifyListeners();
      final postReview = await ApiRestaurant().postReview(dataReview);
      if (postReview.error == true) {
        _state = ResultStateAddReview.noData;
        notifyListeners();
        return _message = postReview.message;
      } else {
        _state = ResultStateAddReview.hasData;
        notifyListeners();
        return _addRiviewResponseModel = postReview;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultStateAddReview.error;
        notifyListeners();
        return _message = 'Check your internet connection';
      } else {
        _state = ResultStateAddReview.error;
        notifyListeners();
        return _message = 'Error --> $e';
      }
    }
  }
}
