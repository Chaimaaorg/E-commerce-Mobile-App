import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../data/cart_storage.dart';
import '../models/Cart.dart';
import '../models/Product.dart';
import '../providers/cart_provider.dart';
import '../widgets/details_widgets/color_dots.dart';

class CartController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(
      Product product,
      BuildContext context) async {
    try {
      DocumentSnapshot productSnapshot =
      await _firestore.collection("Products").doc(product.id).get();

      int availability = productSnapshot["availability"];
      int selectedQuantity = ColorDots.selectedQuantity;

      if (availability > 0 && selectedQuantity <= availability) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        Cart existingCartItem = cartProvider.cartItems.firstWhere(
              (cartItem) => cartItem.product.id == product.id,
          orElse: () =>
              Cart(
                product: product,
                numOfItem: 0,
                addedTime: DateTime.now(),
              ),
        );

        if (existingCartItem.numOfItem == 0) {
          existingCartItem.numOfItem = selectedQuantity;
          cartProvider.addToCart(existingCartItem);
        } else {
          existingCartItem.numOfItem = selectedQuantity;
          existingCartItem.addedTime =
              DateTime.now(); // Update addedTime for existing items
        }

        CartStorage.saveCart(cartProvider.cartItems);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Product added to cart!"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Product is out of stock!"),
          ),
        );
      }
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  Future<void> removeFromCart(Cart cartItem, BuildContext context) async {
    try {
      // Update the cart count using CartProvider
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.removeFromCart(cartItem);

      // Save the updated cart data to SharedPreferences
      CartStorage.saveCart(cartProvider.cartItems);
      CartStorage.removeCart();
    } catch (e) {
      print("Error removing from cart: $e");
    }
  }
  Future<void> addToCartNoColorDots(
      Product product,
      int selectedQuantity,
      BuildContext context) async {
    try {
      DocumentSnapshot productSnapshot =
      await _firestore.collection("Products").doc(product.id).get();

      int availability = productSnapshot["availability"];

      if (availability > 0 && selectedQuantity <= availability) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        Cart existingCartItem = cartProvider.cartItems.firstWhere(
              (cartItem) => cartItem.product.id == product.id,
          orElse: () =>
              Cart(
                product: product,
                numOfItem: 0,
                addedTime: DateTime.now(),
              ),
        );

        if (existingCartItem.numOfItem == 0) {
          existingCartItem.numOfItem = selectedQuantity;
          cartProvider.addToCart(existingCartItem);
        } else {
          existingCartItem.numOfItem = selectedQuantity;
          existingCartItem.addedTime = DateTime.now();
        }

        CartStorage.saveCart(cartProvider.cartItems);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product added to cart!"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product is out of stock!"),
          ),
        );
      }
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }
}
