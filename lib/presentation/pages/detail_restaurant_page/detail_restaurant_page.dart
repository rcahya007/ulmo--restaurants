import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/model/add_review_request_model.dart';
import 'package:ulmo_restaurants/data/model/restaurant_local_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/pages/no_connection_page/no_connection_page.dart';
import 'package:ulmo_restaurants/presentation/widgets/card_menu.dart';
import 'package:ulmo_restaurants/provider/add_review_provider.dart';
import 'package:ulmo_restaurants/provider/db_provider.dart';
import 'package:ulmo_restaurants/provider/detail_restaurant.dart';

class DetailRestaurantPage extends StatefulWidget {
  final RestaurantLocalModel? restaurantLocalModel;
  const DetailRestaurantPage({super.key, this.restaurantLocalModel});

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  bool? isLiked;
  bool isShowMore = false;
  final TextEditingController nameC = TextEditingController();
  final TextEditingController reviewC = TextEditingController();
  @override
  void initState() {
    if (widget.restaurantLocalModel == null) {
      isLiked = false;
    } else {
      isLiked = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailRestaurantProvider>(
        builder: (context, value, child) {
          if (value.state == ResultStateDetail.loading) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (value.state == ResultStateDetail.hasData) {
            return NestedScrollView(
              headerSliverBuilder: (context, isScorlled) {
                return [
                  SliverAppBar(
                    backgroundColor: colorGray400,
                    pinned: true,
                    collapsedHeight: 100,
                    automaticallyImplyLeading: false,
                    expandedHeight: 458,
                    flexibleSpace: Stack(
                      children: [
                        Hero(
                          tag: value.detailRestaurantResponseModel.restaurant
                              .pictureId,
                          child: Container(
                            height: 490,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: colorGray500,
                                  offset: Offset(
                                    5.0,
                                    5.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ), //Box
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://restaurant-api.dicoding.dev/images/large/${value.detailRestaurantResponseModel.restaurant.pictureId}',
                                ),
                                fit: BoxFit.cover,
                              ),
                              color: colorGray400,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 44,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorWhite,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.arrow_back_rounded,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLiked = !isLiked!;
                                        if (widget.restaurantLocalModel ==
                                            null) {
                                          final restaurantLocal =
                                              RestaurantLocalModel(
                                            id: value
                                                .detailRestaurantResponseModel
                                                .restaurant
                                                .id,
                                            name: value
                                                .detailRestaurantResponseModel
                                                .restaurant
                                                .name,
                                            pictureId: value
                                                .detailRestaurantResponseModel
                                                .restaurant
                                                .pictureId,
                                            city: value
                                                .detailRestaurantResponseModel
                                                .restaurant
                                                .city,
                                            rating: value
                                                .detailRestaurantResponseModel
                                                .restaurant
                                                .rating,
                                          );
                                          Provider.of<DbProvider>(context,
                                                  listen: false)
                                              .addRestaurant(restaurantLocal);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Restaurant "${value.detailRestaurantResponseModel.restaurant.name}" ditambahkan kedalam daftar suka.'),
                                              duration: const Duration(
                                                milliseconds: 800,
                                              ),
                                            ),
                                          );
                                        } else {
                                          Provider.of<DbProvider>(context,
                                                  listen: false)
                                              .deleteRestaurant(value
                                                  .detailRestaurantResponseModel
                                                  .restaurant
                                                  .id);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Restaurant "${value.detailRestaurantResponseModel.restaurant.name}" dihapus dari daftar suka.'),
                                              duration: const Duration(
                                                milliseconds: 800,
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorWhite,
                                      ),
                                      child: Center(
                                          child: Icon(
                                        isLiked!
                                            ? Icons.favorite_sharp
                                            : Icons.favorite_border_sharp,
                                        size: 24,
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.detailRestaurantResponseModel.restaurant
                                    .name,
                                style: heading1semi,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    itemSize: 22,
                                    initialRating: value
                                        .detailRestaurantResponseModel
                                        .restaurant
                                        .rating,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${value.detailRestaurantResponseModel.restaurant.rating}',
                                    style: body1reg,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      '${value.detailRestaurantResponseModel.restaurant.address}, ${value.detailRestaurantResponseModel.restaurant.city}',
                                      style: body1reg,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: value.detailRestaurantResponseModel
                                    .restaurant.categories
                                    .map(
                                      (e) => Container(
                                        margin: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 7.5,
                                        ),
                                        decoration: BoxDecoration(
                                            color: colorWhite,
                                            border: Border.all(
                                              color: colorBlack,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                8,
                                              ),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: colorBlack,
                                                blurRadius: 0,
                                                offset: Offset(2, 2),
                                              )
                                            ]),
                                        child: Text(
                                          e.name,
                                          style: body2med,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 400),
                                    crossFadeState: isShowMore
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    firstChild: Text(
                                      value.detailRestaurantResponseModel
                                          .restaurant.description,
                                      style: body1reg,
                                      textAlign: TextAlign.justify,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    secondChild: Text(
                                      value.detailRestaurantResponseModel
                                          .restaurant.description,
                                      style: body1reg,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorGray300,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isShowMore = !isShowMore;
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            isShowMore
                                                ? 'Read Less'
                                                : 'Read More',
                                            style: body2reg.copyWith(
                                              color: colorBlack,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          AnimatedRotation(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            turns: isShowMore ? 0.5 : 0,
                                            child: const Icon(
                                              Icons.expand_circle_down_outlined,
                                              color: colorBlack,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Consumer<AddReviewProvider>(
                                builder: (context, addReview, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ScaffoldMessenger(
                                            child: Builder(builder: (context) {
                                              return Scaffold(
                                                backgroundColor:
                                                    Colors.transparent,
                                                body: AlertDialog(
                                                  backgroundColor: colorWhite,
                                                  surfaceTintColor: colorWhite,
                                                  insetPadding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                  ),
                                                  content: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Icon(
                                                                Icons
                                                                    .close_rounded,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                'Add New Review',
                                                                style: body1med,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colorGray100,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: TextField(
                                                            controller: nameC,
                                                            style: body1reg,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Your name',
                                                              labelStyle:
                                                                  body2reg
                                                                      .copyWith(
                                                                color:
                                                                    colorGray500,
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 9.5,
                                                                horizontal: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colorGray100,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: TextField(
                                                            controller: reviewC,
                                                            style: body1reg,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Your review',
                                                              labelStyle:
                                                                  body2reg
                                                                      .copyWith(
                                                                color:
                                                                    colorGray500,
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 9.5,
                                                                horizontal: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 24,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (nameC.text
                                                                    .isEmpty ||
                                                                reviewC.text
                                                                    .isEmpty) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  duration:
                                                                      Duration(
                                                                    milliseconds:
                                                                        500,
                                                                  ),
                                                                  content: Text(
                                                                      'Field is required'),
                                                                ),
                                                              );
                                                            } else {
                                                              setState(() {
                                                                addReview.postReview(AddRiviewRequestModel(
                                                                    id: value
                                                                        .detailRestaurantResponseModel
                                                                        .restaurant
                                                                        .id,
                                                                    name: nameC
                                                                        .text,
                                                                    review: reviewC
                                                                        .text));
                                                              });
                                                              nameC.clear();
                                                              reviewC.clear();
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  duration:
                                                                      Duration(
                                                                    milliseconds:
                                                                        1000,
                                                                  ),
                                                                  content: Text(
                                                                      'Review telah ditambahkan'),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color:
                                                                  colorYellow400,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 16,
                                                              vertical: 20,
                                                            ),
                                                            child: Center(
                                                              child: addReview
                                                                          .state ==
                                                                      ResultStateAddReview
                                                                          .loading
                                                                  ? const CircularProgressIndicator()
                                                                  : Text(
                                                                      'Send review',
                                                                      style:
                                                                          body1med,
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Add New Review',
                                              style: body1reg,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 20,
                                            color: colorBlack,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showReviews(context, value);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Reviews',
                                          style: body1reg,
                                        ),
                                      ),
                                      Text(
                                        '${value.detailRestaurantResponseModel.restaurant.customerReviews.length}',
                                        style: body1reg.copyWith(
                                          color: colorGray500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child: Text(
                                  'Menu',
                                  style: heading2semi,
                                ),
                              ),
                              CardMenu(
                                icon: Icons.restaurant_menu_rounded,
                                title: 'Foods',
                                menu: value.detailRestaurantResponseModel
                                    .restaurant.menu.foods,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CardMenu(
                                icon: Icons.local_cafe_rounded,
                                title: 'Drinks',
                                menu: value.detailRestaurantResponseModel
                                    .restaurant.menu.drinks,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (value.state == ResultStateDetail.noData) {
            return Center(
              child: Text(value.message),
            );
          } else if (value.state == ResultStateDetail.error) {
            return const NoConnectionPage();
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> _showReviews(
      BuildContext context, DetailRestaurantProvider value) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          8,
        ),
      )),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 10,
                      width: 50,
                      decoration: BoxDecoration(
                          color: colorGray500,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.detailRestaurantResponseModel.restaurant
                          .customerReviews.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colorGray500,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  value.detailRestaurantResponseModel.restaurant
                                      .customerReviews[index].date,
                                  style: body2reg.copyWith(
                                    color: colorGray500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                value.detailRestaurantResponseModel.restaurant
                                    .customerReviews[index].name,
                                style: body1med,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                value.detailRestaurantResponseModel.restaurant
                                    .customerReviews[index].review,
                                style: body2reg.copyWith(
                                  color: colorGray500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
