import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                'bag',
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
                        'your bag is empty',
                        style: heading2semi,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'items remain in your bag for 1 hour, and then they’re moved to your Saved items',
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
                'Continue with phone',
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
        ),
      ),
    );
  }
}
