import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/domain/entities/search_result_response_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/provider/list_of_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchC = TextEditingController(text: "");
  bool isFocus = true;

  @override
  Widget build(BuildContext context) {
    final listOfSearch = Provider.of<ListOfSearchProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
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
                  onTap: () {},
                  onChanged: (value) {
                    setState(() {
                      searchC.text = value;
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
                    child: Consumer<ListOfSearchProvider>(
                      builder: (context, value, child) {
                        if (value.historySearch.isEmpty) {
                          return const SizedBox(
                            height: 0,
                          );
                        } else {
                          return Column(
                            children: value.showLastHistory
                                .map((e) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.schedule, size: 24),
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
                                              value.removeSearch(e);
                                            },
                                            child: const Icon(
                                              Icons.cancel_outlined,
                                              color: colorGray500,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          );
                        }
                      },
                    ),
                  )
                : FutureBuilder<SearchRestaurantResult>(
                    future: ApiRestaurant().searchResult(searchC.text),
                    builder: (context, snapshot) {
                      var state = snapshot.connectionState;
                      switch (state) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(
                                16,
                              ),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            if (snapshot.data!.restaurants.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(
                                  16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    itemCount:
                                        snapshot.data?.restaurants.length,
                                    itemBuilder: (context, index) {
                                      var restaurantName =
                                          snapshot.data?.restaurants[index];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 36,
                                              width: 36,
                                              decoration: const BoxDecoration(
                                                color: colorGray400,
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircleAvatar(
                                                radius: 18,
                                                backgroundImage: NetworkImage(
                                                    'https://restaurant-api.dicoding.dev/images/medium/${restaurantName!.pictureId}'),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Text(
                                                restaurantName.name,
                                                style: body1reg,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: const Text(
                                  'An error occurred... try searching for the restaurant again'),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: const Text(''),
                            );
                          }
                        default:
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            child: const Text(''),
                          );
                      }
                    },
                  ),
          ],
        ),
      )),
    );
  }
}
