import 'package:flutter/cupertino.dart';

class ProductSearchState with ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // Notify listeners to rebuild
  }
}

