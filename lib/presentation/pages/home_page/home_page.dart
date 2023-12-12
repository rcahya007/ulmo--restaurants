import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/domain/entities/restaurants_response_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/widgets/card_restaurants.dart';
import 'package:ulmo_restaurants/presentation/widgets/story_restaurants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Restaurant>> getRestaurant() async {
    String fetch = await DefaultAssetBundle.of(context)
        .loadString('assets/data_restaurants/restaurants.json');

    RestaurantsResponseModel dataResponse =
        RestaurantsResponseModel.fromRawJson(fetch);

    List<Restaurant> dataRestaurant = dataResponse.restaurants;
    return dataRestaurant;
  }

  @override
  void initState() {
    getRestaurant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 56,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ulmo',
                      style: heading1semi,
                    ),
                    Text(
                      'Recommendation restaurant for you!',
                      style: heading2light,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorGray100,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: body1reg.copyWith(
                      color: colorGray500,
                    ),
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.search,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Restaurant>>(
              future: getRestaurant(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Restaurant> restaurants = snapshot.data!;
                  String type = 'story';
                  return StoryRestaurants(restaurants: restaurants, type: type);
                } else {
                  return const SizedBox(
                    height: 104,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<List<Restaurant>>(
              future: getRestaurant(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Restaurant> restaurants = snapshot.data!;
                  return CardRestaurants(restaurants: restaurants);
                } else {
                  return const SizedBox(
                    height: 104,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
