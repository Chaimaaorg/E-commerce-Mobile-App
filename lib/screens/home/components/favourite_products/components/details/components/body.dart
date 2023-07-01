import 'package:Districap/components/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../../../constants.dart';
import '../../../../../../../models/Product.dart';
import 'add_to_cart.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Product? product;
  final String? heroTag;
  final VoidCallback shareproduct;


  const Body({Key? key, this.product, this.heroTag,required this.shareproduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product myFavProduct = Product(
      availability: 10,
      averageRating: 4.5,
      price: 199.99,
      id: '1',
      name: 'Example Product',
      category: 'Electronics',
      subCategory: 'Smartphones',
      reference: 'ABC123',
      brand: 'XYZ Brand',
      description: 'This is an example product description.',
      features: 'Feature 1, Feature 2, Feature 3',
      linkVideo: 'https://example.com/video',
      pdfUrl: 'https://example.com/pdf',
      images: ['image1.jpg', 'image2.jpg', 'image3.jpg'],
      colors: [Colors.red, Colors.blue, Colors.green],
      isPopular: true,
    );
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: getProportionateScreenHeight(219.24)),
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(60),
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Description(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      CounterWithFavBtn(shareproduct:shareproduct,
                        product:product
                      ),
                      SizedBox(height: kDefaultPaddin / 2),
                      AddToCart(product: product ?? myFavProduct,),
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product, heroTag: "favorite_${heroTag}",),
              ],
            ),
          )
        ],
      ),
    );
  }
}
