import 'package:Districap/controllers/product_controller.dart';
import 'package:Districap/models/Product.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  final ProductController _productController = ProductController();
  double? _averageRating;

  double? get rate => _averageRating;

  Future<double?> getAverageRating(String productId) async {
    Product? product = await _productController.getProductById(productId);
    if (product != null) {
      _averageRating = product.averageRating;
      notifyListeners(); // Notify listeners about the change
    }
    return _averageRating;
  }

  Future<void> updateAverageRating(String productId, double newRating) async {
    Product? product = await _productController.getProductById(productId);
    if (product == null) {
      return; // Handle this as needed
    }

    double updatedRating = (product.averageRating + newRating) / 2;

    // Update the product's rating in Firebase through the controller
    await _productController.updateProductRating(productId, updatedRating);

    // Update the local product instance
    product.averageRating = updatedRating;

    // Set the _averageRating and notifyListeners here
    _averageRating = updatedRating;
    notifyListeners();
  }
}

