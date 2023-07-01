import 'package:Districap/screens/home/components/favourite_products/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_search_state.dart';


class ProductSearchDelegateFavourite extends SearchDelegate<String> {
  final ProductSearchState searchState;

  ProductSearchDelegateFavourite(this.searchState);

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

    return Body(searchPro: searchState);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Body(searchPro: searchState);
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        query='';
        close(context, ''); // Close the search bar
      },
    );
  }

}
