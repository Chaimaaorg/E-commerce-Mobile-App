import 'package:Districap/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';
import '../../../../../providers/promotion_provider.dart';

class ItemCard extends StatelessWidget {
  final Product? product;
  final void Function()? press;
  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSoldOut = product!.availability == 0;
    final provider = context.read<PromotionProvider>();

    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: isSoldOut
                  ? buildBanner('Sold out')
                  : FutureBuilder<bool>(
                future: provider.isPromoted(product!.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(); // Replace with an empty container or any other widget
                  } else if (snapshot.hasError) {
                    return Text('Error'); // Handle error
                  } else {
                    final isPromoted = snapshot.data ?? false;
                    return isPromoted
                        ? buildBanner('Promotion')
                        : Hero(
                      tag: "favourites_${product!.id}",
                      child: Image.network(product!.images[0]),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product!.name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "${product!.price}dh",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  ClipRRect buildBanner(String title) {
    return ClipRRect(
      child: Banner(
        message: title,
        location: BannerLocation.topEnd,
        color: kPrimaryColor,
        textStyle: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600),
        child: Hero(
          tag: "favourites_${product!.id}",
          child: Image.network(product!.images[0]),
        ),
      ),
    );
  }
}
