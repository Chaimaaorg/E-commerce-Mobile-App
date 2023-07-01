import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_search_state.dart';
import '../screens/category/components/body.dart';

class ProductSearchDelegateCategory extends SearchDelegate<String> {
  final ProductSearchState searchState;
  final String category;

  ProductSearchDelegateCategory(this.searchState, this.category);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchState = Provider.of<ProductSearchState>(context, listen: false);

    Future.microtask(() {
      searchState.setSearchQuery(query);
    });

    return Body(searchPro: searchState, category: category,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Body(searchPro: searchState, category: category,);
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        query ='';
        close(context, ''); // Close the search bar
      },
    );
  }

}
