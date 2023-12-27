import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/data/model/restaurant_local_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/pages/detail_restaurant_page/detail_restaurant_page.dart';
import 'package:ulmo_restaurants/provider/add_review_provider.dart';
import 'package:ulmo_restaurants/provider/db_provider.dart';
import 'package:ulmo_restaurants/provider/detail_restaurant.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DbProvider>(
          builder: (context, value, child) {
            final restaurantLocal = value.restaurant;
            if (restaurantLocal.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Text(
                      'saved items',
                      style: heading1semi,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/surprised.svg'),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'nothing saved...',
                              style: heading2semi,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '... no worries. Start saving as you shop by clicking the little heart',
                              style: body1reg.copyWith(
                                color: colorGray500,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorYellow400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Start shopping',
                      style: body1med.copyWith(
                        color: colorBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurantLocal.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        // final data =
                        //     value.getRestaurantById(restaurantLocal[index].id!);
                        // RestaurantLocalModel? dataRestaurant;
                        // data.then((value) => dataRestaurant = value);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => DetailRestaurantProvider(
                                apiRestaurant: ApiRestaurant(),
                                id: restaurantLocal[index].id!,
                              ),
                              child: ChangeNotifierProvider(
                                  create: (context) => AddReviewProvider(
                                      apiRestaurant: ApiRestaurant()),
                                  child: DetailRestaurantPage(
                                    restaurantLocalModel:
                                        restaurantLocal[index],
                                  )),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          color: colorGray100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  left: 16,
                                  right: 16,
                                  bottom: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurantLocal[index].name!,
                                      style: heading2semi,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          itemSize: 20,
                                          initialRating:
                                              restaurantLocal[index].rating!,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${restaurantLocal[index].rating}',
                                          style: body2reg,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.location_on_sharp,
                                          color: colorYellow500,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            restaurantLocal[index].city!,
                                            style: body2reg,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Hero(
                              tag: restaurantLocal[index].pictureId!,
                              child: Container(
                                width: 82,
                                decoration: BoxDecoration(
                                  color: colorGray400,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://restaurant-api.dicoding.dev/images/medium/${restaurantLocal[index].pictureId}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
