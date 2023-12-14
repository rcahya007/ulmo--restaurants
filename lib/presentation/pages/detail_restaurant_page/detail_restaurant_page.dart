import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ulmo_restaurants/domain/entities/restaurants_response_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/widgets/card_menu.dart';

class DetailRestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  const DetailRestaurantPage({super.key, required this.restaurant});

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  bool isLiked = false;
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
                    tag: widget.restaurant.pictureId,
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
                            widget.restaurant.pictureId,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onTap: () {
                                setState(() {
                                  isLiked = !isLiked;
                                  if (isLiked) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Restaurant "${widget.restaurant.name}" ditambahkan kedalam daftar suka.'),
                                        duration: const Duration(
                                          milliseconds: 800,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Restaurant "${widget.restaurant.name}" dihapus dari daftar suka.'),
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
                                  isLiked
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
                          widget.restaurant.name,
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
                              initialRating: widget.restaurant.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
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
                              '${widget.restaurant.rating}',
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
                                widget.restaurant.city,
                                style: body1reg,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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
                                widget.restaurant.description,
                                style: body1reg,
                                textAlign: TextAlign.justify,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              secondChild: Text(
                                widget.restaurant.description,
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
                                      isShowMore ? 'Read Less' : 'Read More',
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
                                      duration:
                                          const Duration(milliseconds: 300),
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
                          menu: widget.restaurant.menus.foods,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CardMenu(
                          icon: Icons.local_cafe_rounded,
                          title: 'Drinks',
                          menu: widget.restaurant.menus.drinks,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
