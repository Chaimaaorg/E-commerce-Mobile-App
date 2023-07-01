import 'package:Districap/constants.dart';
import 'package:Districap/controllers/cart_controller.dart';
import 'package:Districap/widgets/details_widgets/more_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:Districap/components/default_button.dart';
import 'package:Districap/models/Product.dart';
import 'package:Districap/size_config.dart';

import '../../../../../widgets/details_widgets/color_dots.dart';
import '../../../../../widgets/details_widgets/product_description.dart';
import '../../../../../widgets/details_widgets/product_images.dart';
import '../../../../../widgets/details_widgets/top_rounded_container.dart';

class Body extends StatelessWidget {

  final Product product;
  final VoidCallback shareProduct;
  final bool isFavourite;
  void _onSeeMoreDetails(BuildContext context) {
    Navigator.pushReplacementNamed(context,MoreDetailsScreen.routeName,arguments: product);
  }
  const Body(
      {Key? key,
      required this.isFavourite,
      required this.product,
      required this.shareProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                isFavourite: isFavourite,
                pressOnSeeMore: () => _onSeeMoreDetails(context),
                shareProduct:
                    shareProduct, // Pass the share function to ProductDescription
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(0),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          color: kPrimaryColor,
                          press: () {CartController().addToCart(product, context,);},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
