import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';

class CardMenu extends StatelessWidget {
  final String title;
  final List<dynamic> menu;
  final IconData icon;

  const CardMenu({
    super.key,
    required this.title,
    required this.menu,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: body0med,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 24,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Showing ${menu[index].name}',
                    ),
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: colorGray400,
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    menu[index].name,
                    style: body1light,
                  ),
                ],
              ),
            );
          },
          itemCount: menu.length,
        ),
      ],
    );
  }
}
