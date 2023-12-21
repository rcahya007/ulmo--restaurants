import 'package:flutter/material.dart';

class ListOfSearchProvider extends ChangeNotifier {
  final List<String> _historySearch = [];
  List<String> get historySearch => _historySearch;

  void addToSearch(String text) {
    _historySearch.add(text);
    notifyListeners();
  }

  void removeSearch(String text) {
    _historySearch.remove(text);
    notifyListeners();
  }

  List<String> get showLastHistory => _historySearch.reversed.take(3).toList();
}
