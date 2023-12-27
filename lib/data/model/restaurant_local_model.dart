class RestaurantLocalModel {
  String? id;
  String? name;
  String? pictureId;
  String? city;
  double? rating;
  RestaurantLocalModel({
    required this.id,
    required this.name,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  RestaurantLocalModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    pictureId = map['pictureId'];
    city = map['city'];
    rating = map['rating'];
  }
}
