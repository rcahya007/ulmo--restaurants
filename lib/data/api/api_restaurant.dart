import 'package:ulmo_restaurants/domain/entities/search_result_response_model.dart';
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
}
