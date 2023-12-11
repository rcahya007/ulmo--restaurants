import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/presentation/pages/cart_page/cart_page.dart';
import 'package:ulmo_restaurants/presentation/pages/home_page/home_page.dart';
import 'package:ulmo_restaurants/presentation/pages/liked_page/liked_page.dart';
import 'package:ulmo_restaurants/presentation/pages/user_page/user_page.dart';

const List<Widget> homeMenu = <Widget>[
  HomePage(),
  CartPage(),
  LikedPage(),
  UserPage(),
];
