import 'package:flutter/foundation.dart';

import '../data/cart_storage.dart';
import '../models/Cart.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _cartItems = [];

  CartProvider() {
    // Load cart data from SharedPreferences when the provider is initialized
    CartStorage.getCart().then((cartData) {
      _cartItems = cartData;
      removeExpiredItems(); // Remove expired items when the provider is initialized
      notifyListeners();
    });
  }

  List<Cart> get cartItems => _cartItems;

  int get cartCount => _cartItems.length;

  void removeExpiredItems() {
    final now = DateTime.now();
    for (var cartItem in List.from(_cartItems)) {
      if (now.difference(cartItem.addedTime) > const Duration(minutes: 60)) {
        removeFromCart(cartItem);
      }
    }
  }

  void addToCart(Cart cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
    // Save the updated cart data to SharedPreferences
    CartStorage.saveCart(_cartItems);
  }

  void removeFromCart(Cart cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
    // Save the updated cart data to SharedPreferences
    CartStorage.saveCart(_cartItems);
  }

  void clearCart() {
    _cartItems.clear();
    CartStorage.removeCart();
    notifyListeners();
  }
}
