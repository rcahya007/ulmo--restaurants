import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
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
                'my account',
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
                      SvgPicture.asset('assets/icons/smiley.svg'),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'come on in',
                        style: heading2semi,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'view orders and update your details',
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
        ),
      ),
    );
  }
}
