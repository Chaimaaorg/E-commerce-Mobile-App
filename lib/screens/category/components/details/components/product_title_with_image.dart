import 'package:Districap/components/size_config.dart';
import 'package:flutter/material.dart';
import '../../../../../../../constants.dart';
import '../../../../../../../models/Product.dart';

class ProductTitleWithImage extends StatelessWidget {
  final String? heroTag;
  final Product? product;
  const ProductTitleWithImage({Key? key, this.product, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kDefaultPaddin,right: kDefaultPaddin,top: 0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product!.category,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            product!.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children:[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "${product!.price}dh",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "favourite_${heroTag!}",
                  child: Image.network(
                    product!.images[0],
                    height:getProportionateScreenWidth(200) ,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
