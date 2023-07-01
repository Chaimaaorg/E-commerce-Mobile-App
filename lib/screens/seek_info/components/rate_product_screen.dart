import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/quickalert.dart';

import '../../../models/Product.dart';
import '../../../providers/product_provider.dart';

class RateProductBottomSheet {
  final Product? product;
  final ProductProvider productProvider;

  RateProductBottomSheet({this.product,required this.productProvider});
  Future<void> showRatingDialog(BuildContext context) async {
    double newRating = 0.0; // Initialize the new rating
    await QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        barrierDismissible: true,
        title: 'Rate this product!',
        titleColor: Colors.black,
        confirmBtnText: 'Save',
        confirmBtnTextStyle: const TextStyle(color: Colors.black),
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.white,
        customAsset: 'assets/images/image_banner.png',
        widget: RatingBar.builder(
          initialRating: 3,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            newRating = rating;
          },
        ));
    if (newRating > 0) {
      await productProvider.updateAverageRating(product!.id, newRating);
    }
  }
}
