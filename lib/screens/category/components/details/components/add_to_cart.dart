import 'package:Districap/components/default_button.dart';
import 'package:Districap/screens/category/components/details/components/cart_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../constants.dart';
import '../../../../../controllers/cart_controller.dart';
import '../../../../../models/Product.dart';

class AddToCart extends StatelessWidget {
  final Product product;

  const AddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: kBeautifulBlue,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Cart Icon.svg",
                color: kBeautifulBlue,
              ),
              onPressed: () {CartController().addToCartNoColorDots(product,CartCounter.numOfItems, context);},
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: DefaultButton(
                color: kBeautifulBlue,
                press: () {},
                text: "Buy  Now",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
