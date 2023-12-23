import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/data/model/restaurants_response_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/pages/story_page/story_restaurant_page.dart';

class StoryRestaurants extends StatelessWidget {
  final List<Restaurant> restaurants;
  final String type;
  const StoryRestaurants({
    super.key,
    required this.restaurants,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return restaurants != []
        ? SizedBox(
            height: 104,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryRestaurantPage(
                          dataRestaurant: restaurants[index],
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: '${restaurants[index].pictureId}-$type',
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 12,
                      ),
                      height: 88,
                      width: 88,
                      decoration: BoxDecoration(
                        color: colorGray400,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurants[index].pictureId}',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 48,
                          right: 8,
                          left: 9,
                          bottom: 9,
                        ),
                        child: Text(
                          restaurants[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: body3med.copyWith(
                            color: colorWhite,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox(
            height: 104,
            child: Center(
              child: Text('Data story tidak ada.'),
            ),
          );
  }
}
