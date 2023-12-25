import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/pages/detail_restaurant_page/detail_restaurant_page.dart';
import 'package:ulmo_restaurants/provider/add_review_provider.dart';
import 'package:ulmo_restaurants/provider/detail_restaurant.dart';
import 'package:ulmo_restaurants/provider/list_of_search.dart';
import 'package:ulmo_restaurants/provider/search_restaurant_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchC = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<SearchRestaurantProvider>(
            builder: (context, searchRestaurant, child) {
              return Consumer<ListOfSearchProvider>(
                builder: (context, listOfSearch, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            controller: searchC,
                            autofocus: true,
                            onSubmitted: (value) {
                              if (value != "") {
                                listOfSearch.addToSearch(value);
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                searchC.text = value;
                                searchRestaurant.searchRestaurant(searchC.text);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search restaurant',
                              hintStyle: body1reg.copyWith(
                                color: colorGray500,
                              ),
                              border: InputBorder.none,
                              icon: const Icon(
                                Icons.search,
                                size: 24,
                              ),
                              suffixIcon: searchC.text == ""
                                  ? const Icon(
                                      Icons.mic,
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          searchC.clear();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.cancel_outlined,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      searchC.text == ""
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: listOfSearch.historySearch.isEmpty
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Column(
                                      children: listOfSearch.showLastHistory
                                          .map((e) => GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    searchC.text = e;
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                    vertical: 20,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.schedule,
                                                          size: 24),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          e,
                                                          style: body1reg,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          listOfSearch
                                                              .removeSearch(e);
                                                        },
                                                        child: const Icon(
                                                          Icons.cancel_outlined,
                                                          color: colorGray500,
                                                          size: 24,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                            )
                          : Consumer<SearchRestaurantProvider>(
                              builder: (context, value, child) {
                                if (value.state == ResultStateSearch.loading) {
                                  return const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (value.state ==
                                    ResultStateSearch.hasData) {
                                  if (value
                                      .restaurantResult.restaurants.isEmpty) {
                                    return SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          16,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/dissatisfied.svg'),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'nothing found restaurant, try something else',
                                              style: heading2semi,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Text(
                                            'Restaurant',
                                            style: body0med,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: value.restaurantResult
                                              .restaurants.length,
                                          itemBuilder: (context, index) {
                                            var restaurantName = value
                                                .restaurantResult
                                                .restaurants[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChangeNotifierProvider(
                                                      create: (context) =>
                                                          DetailRestaurantProvider(
                                                        apiRestaurant:
                                                            ApiRestaurant(),
                                                        id: restaurantName.id,
                                                      ),
                                                      child: ChangeNotifierProvider(
                                                          create: (context) =>
                                                              AddReviewProvider(
                                                                  apiRestaurant:
                                                                      ApiRestaurant()),
                                                          child:
                                                              const DetailRestaurantPage()),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 14,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 36,
                                                      width: 36,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: colorGray400,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 18,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                'https://restaurant-api.dicoding.dev/images/medium/${restaurantName.pictureId}'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        restaurantName.name,
                                                        style: body1reg,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                } else if (value.state ==
                                    ResultStateSearch.noData) {
                                  return Center(
                                    child: Text(value.message),
                                  );
                                } else if (value.state ==
                                    ResultStateSearch.error) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 20,
                                    ),
                                    child: const Text(
                                        'An error occurred... try searching for the restaurant again'),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
