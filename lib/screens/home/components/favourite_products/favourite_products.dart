import 'package:Districap/screens/home/components/favourite_products/components/body.dart';
import 'package:Districap/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../enums.dart';
import '../../../../providers/cart_provider.dart';
import '../../../../providers/product_search_state.dart';
import '../../../../theme.dart';
import '../../../../widgets/coustom_bottom_nav_bar.dart';

class FavouriteProductsScreen extends StatelessWidget {
  static String routeName = "/favourite-products";

  const FavouriteProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.removeExpiredItems();
    final searchPro = Provider.of<ProductSearchState>(context);

    int cartItemCount = cartProvider.cartCount;

    return Scaffold(
      appBar: buildAppBarFavProducts(context, cartItemCount, HomeScreen.routeName),
      body: Body(searchPro: searchPro),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}


