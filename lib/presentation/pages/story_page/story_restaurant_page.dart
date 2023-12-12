// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ulmo_restaurants/domain/entities/restaurants_response_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';

class StoryRestaurantPage extends StatelessWidget {
  final Restaurant dataRestaurant;
  const StoryRestaurantPage({
    Key? key,
    required this.dataRestaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: '${dataRestaurant.pictureId}-story',
              child: Image.network(
                dataRestaurant.pictureId,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                width: 100,
                decoration: BoxDecoration(
                  color: colorYellow400,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Kembali',
                  style: body1med.copyWith(
                    color: colorBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
