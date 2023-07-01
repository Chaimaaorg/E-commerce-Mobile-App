import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Cart.dart';

class CartStorage {
  static const String _cartKey = 'cart';

  // Save the cart data to SharedPreferences
  static Future<void> saveCart(List<Cart> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = Cart.cartListToJson(cartItems);
    prefs.setString(_cartKey, jsonEncode(cartData));
  }

  // Retrieve the cart data from SharedPreferences
  static Future<List<Cart>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_cartKey);
    if (cartData != null) {
      final decodedData = jsonDecode(cartData) as List<dynamic>;
      return Cart.cartListFromJson(decodedData);
    }
    return [];
  }
  static Future<void> removeCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cartKey);
  }
}