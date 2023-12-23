class AddRiviewRequestModel {
  final String id;
  final String name;
  final String review;

  AddRiviewRequestModel({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
