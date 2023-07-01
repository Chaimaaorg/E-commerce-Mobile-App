import 'package:Districap/screens/category/components/body.dart';
import 'package:Districap/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../enums.dart';
import '../../../../theme.dart';
import '../../../../widgets/coustom_bottom_nav_bar.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_search_state.dart';

class CategoryScreen extends StatelessWidget {
  static String routeName="/sub-category";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.removeExpiredItems();
    int cartItemCount = cartProvider.cartCount;
    String category = ModalRoute.of(context)!.settings.arguments as String;
    final searchPro = Provider.of<ProductSearchState>(context);
    return Scaffold(
      appBar: buildAppCategory(context,cartItemCount,HomeScreen.routeName,category),
      body: Body(category:category,searchPro: searchPro,),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home,),
    );
  }


}



