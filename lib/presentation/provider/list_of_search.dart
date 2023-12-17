import 'package:flutter/material.dart';

class ListOfSearchProvider extends ChangeNotifier {
  final List<String> _historySearch = [
    'Test 1',
    'Test 2',
  ];
  List<String> get historySearch => _historySearch;

  void addToSearch(String text) {
    _historySearch.add(text);
    notifyListeners();
  }
}
