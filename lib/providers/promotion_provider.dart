import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controllers/product_controller.dart';
import '../models/Product.dart';
import '../models/Promotion.dart';
class PromotionProvider extends ChangeNotifier {
  final CollectionReference _promotionsCollection =
  FirebaseFirestore.instance.collection('Promotions');
  final ProductController _productController = ProductController();

  Future<List<Promotion>> getPromotions() async {
    final querySnapshot = await _promotionsCollection.get();
    List<Promotion> promotions = [];

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Product? product = await _productController.getProductById(
          docSnapshot['prodId']);
      Promotion promotion = Promotion.fromJson(
          docSnapshot.data() as Map<String, dynamic>, product!);
      promotions.add(promotion);
    }
    return promotions;
  }

  Future<bool> isPromoted(String productId) async {
    List<Promotion> promotions = await getPromotions();
    return promotions.any((promotion) => promotion.productId == productId);
  }
  Future<String?> getPromoDiscountByProdId(String prodId) async {
    QuerySnapshot querySnapshot = await _promotionsCollection
        .where('prodId', isEqualTo: prodId)
        .get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      return docSnapshot['discount'] as String?;
    }

    return null; // No promotion found for the given prodId
  }
}
