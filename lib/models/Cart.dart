import 'package:Districap/controllers/product_controller.dart';

import 'Product.dart';

class Cart {
  Product product;
  int numOfItem;
  DateTime addedTime; // New field to store the time when the item was added

  Cart({required this.product, required this.numOfItem, required this.addedTime});

  // Convert the Cart object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'numOfItem': numOfItem,
      'addedTime': addedTime.toIso8601String(), // Convert DateTime to string
    };
  }

  // Create a Cart object from JSON data
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      product: Product.fromJJson(json['product'], json['product']['images']),
      numOfItem: json['numOfItem'],
      addedTime: DateTime.parse(json['addedTime']), // Parse string back to DateTime
    );
  }

  // Convert the Cart list to JSON representation
  static List<Map<String, dynamic>> cartListToJson(List<Cart> cartItems) {
    return cartItems.map((cartItem) => cartItem.toJson()).toList();
  }

  // Convert JSON data to the Cart list
  static List<Cart> cartListFromJson(List<dynamic> cartData) {
    return cartData.map((json) => Cart.fromJson(json)).toList();
  }
}
