import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/pages/no_connection_page/no_connection_page.dart';
import 'package:ulmo_restaurants/presentation/pages/search_page/search_page.dart';
import 'package:ulmo_restaurants/presentation/widgets/card_restaurants.dart';
import 'package:ulmo_restaurants/presentation/widgets/story_restaurants.dart';
import 'package:ulmo_restaurants/provider/restaurant_provider.dart';
import 'package:ulmo_restaurants/provider/search_restaurant_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantProvider>(builder: (context, value, child) {
        String type = 'story';
        if (value.state == ResultState.loading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (value.state == ResultState.hasData) {
          return SingleChildScrollView(
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
                                    create: (context) =>
                                        SearchRestaurantProvider(
                                            apiRestaurant: ApiRestaurant()),
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
                  //Story Card
                  StoryRestaurants(
                    restaurants: value.result.restaurants,
                    type: type,
                  ),
                  // Card of Restaurant
                  CardRestaurants(
                    restaurants: value.result.restaurants,
                  ),
                ],
              ),
            ),
          );
        } else if (value.state == ResultState.noData) {
          return Center(
            child: Text(value.message),
          );
        } else if (value.state == ResultState.error) {
          return const NoConnectionPage();
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
