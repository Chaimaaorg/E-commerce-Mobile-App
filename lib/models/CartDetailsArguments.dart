import 'Cart.dart';

class CartDetailsArguments {
  final List<Cart> cartItems;
  final double total;

  CartDetailsArguments({required this.cartItems, required this.total});
}