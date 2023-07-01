import 'package:Districap/providers/product_search_state.dart';
import 'package:Districap/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../enums.dart';
import '../../../../theme.dart';
import '../../../../widgets/coustom_bottom_nav_bar.dart';
import 'package:Districap/screens/show_all_products/components/body.dart';

import '../../providers/cart_provider.dart';

class ShowAllProductsScreen extends StatelessWidget {
  static String routeName="/all-products";

  const ShowAllProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.removeExpiredItems();
    int cartItemCount = cartProvider.cartCount;
    final searchPro = Provider.of<ProductSearchState>(context);
    return Scaffold(
      appBar: buildAppAllProducts(context,cartItemCount,HomeScreen.routeName),
      body: Body(searchPro:searchPro),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home,),
    );
  }

}