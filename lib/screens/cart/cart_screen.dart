import 'package:flutter/material.dart';
import 'package:Districap/models/Cart.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.removeExpiredItems();
    List<Cart> cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: buildAppBar(context, cartItems.length),
      body: Body(cartItems: cartItems),
      bottomNavigationBar: CheckoutCard(),
    );
  }




  double calculateTotalPrice(List<Cart> cartItems) {
    double totalPrice = 0;
    for (Cart cartItem in cartItems) {
      // Calculate the price for each product and add it to the total
      double productPrice = cartItem.product.price;
      int quantity = cartItem.numOfItem;
      totalPrice += productPrice * quantity;
    }
    return totalPrice;
  }

  AppBar buildAppBar(BuildContext context, int cartItemCount) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "$cartItemCount items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
