import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ulmo_restaurants/data/model/restaurants_response_model.dart';

void main() {
  test('Test parsing JSON Restaurant', () {
    // Skenario pengujian dituliskan di sini
    // Data
    var testRestaurantData = Restaurant(
      id: 'rqdv5juczeskfw1e867',
      name: 'Melting Pot',
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
      pictureId: '14',
      city: 'Medan',
      rating: 4.2,
    );
    // Make data to String
    var restaurantString = json.encode(testRestaurantData);
    // Rubah data String to Object Restaurant
    var result = Restaurant.fromRawJson(restaurantString);
    // Verifikasi Result
    expect(result.id, 'rqdv5juczeskfw1e867');
    expect(result.name, 'Melting Pot');
    expect(result.description,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.');
    expect(result.pictureId, '14');
    expect(result.city, 'Medan');
    expect(result.rating, 4.2);
    // Test Error
    // expect(result.rating, '4.2');
  });
}
