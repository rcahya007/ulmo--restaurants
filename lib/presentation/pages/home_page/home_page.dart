import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/domain/entities/restaurants_response_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/pages/search_page/search_page.dart';
import 'package:ulmo_restaurants/presentation/widgets/card_restaurants.dart';
import 'package:ulmo_restaurants/presentation/widgets/story_restaurants.dart';
import 'package:ulmo_restaurants/provider/list_of_search.dart';
import 'package:ulmo_restaurants/provider/restaurant_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // @override
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
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (context) => ListOfSearchProvider(),
                              child: const SearchPage()),
                        ));
                  },
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
            Consumer<RestaurantProvider>(
              builder: (context, value, child) {
                if (value.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              child: FutureBuilder<List<Restaurant>>(
                future: getRestaurant(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      List<Restaurant> restaurants = snapshot.data!;
                      String type = 'story';
                      return StoryRestaurants(
                          restaurants: restaurants, type: type);
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
                },
              ),
            ),
            FutureBuilder<List<Restaurant>>(
              future: getRestaurant(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    List<Restaurant> restaurants = snapshot.data!;
                    return CardRestaurants(restaurants: restaurants);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
