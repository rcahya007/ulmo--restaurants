import 'package:ulmo_restaurants/data/model/add_review_request_model.dart';
import 'package:ulmo_restaurants/data/model/add_review_response_model.dart';
import 'package:ulmo_restaurants/data/model/detail_restaurant_response_model.dart';
import 'package:ulmo_restaurants/data/model/restaurants_response_model.dart';
import 'package:ulmo_restaurants/data/model/search_result_response_model.dart';
import 'package:http/http.dart' as http;

class ApiRestaurant {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<SearchRestaurantResult> searchResult(String input) async {
    final fetch = await http.get(Uri.parse('$_baseUrl/search?q=$input'));
    if (fetch.statusCode == 200) {
      return SearchRestaurantResult.fromRawJson(fetch.body);
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<ListRestaurantResponseModel> getRestaurant() async {
    final getData = await http.get(Uri.parse('$_baseUrl/list'));
    if (getData.statusCode == 200) {
      return ListRestaurantResponseModel.fromRawJson(getData.body);
    } else {
      throw Exception('Failed to get data list of Restaurant');
    }
  }

  Future<DetailRestaurantResponseModel> getDetailRestaurant(String id) async {
    final getData = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (getData.statusCode == 200) {
      return DetailRestaurantResponseModel.fromRawJson(getData.body);
    } else {
      throw Exception('Failed to get detail data of Restaurant');
    }
  }

  Future<AddRiviewResponseModel> postReview(AddRiviewRequestModel model) async {
    final postData = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: {
        'Content-type': 'application/json',
      },
      body: model.toJson(),
    );
    if (postData.statusCode == 200) {
      return AddRiviewResponseModel.fromRawJson(postData.body);
    } else {
      throw Exception('Failed add your review');
    }
  }
}
