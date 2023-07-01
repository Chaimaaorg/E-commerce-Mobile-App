import 'package:Districap/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../constants.dart';
import '../../../components/size_config.dart';
import '../../../controllers/product_controller.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/promotion_provider.dart';

class ItemCard extends StatefulWidget {
  final Product? product;
  final void Function()? press;
  final bool? isFavorite;
  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
    this.isFavorite,
  }) : super(key: key);
  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _isFavorite = false;
  bool _updatingFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite!;
  }

  @override
  Widget build(BuildContext context) {
    final isSoldOut = widget.product!.availability == 0;
    final provider = context.read<PromotionProvider>(); // Initialize PromotionProvider

    return GestureDetector(
      onTap: widget.press,
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
                future: provider.isPromoted(widget.product!.id),
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
                      tag: "all_products_${widget.product!.id}",
                      child: Image.network(widget.product!.images[0]),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              widget.product!.name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Row(
            children: [
              Text(
                "${widget.product!.price}dh",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: getProportionateScreenWidth(50)),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: _updatingFavorite ? null : _onHeartIconTap,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  height: getProportionateScreenWidth(28),
                  width: getProportionateScreenWidth(28),
                  decoration: BoxDecoration(
                    color: _isFavorite
                        ? kPrimaryColor.withOpacity(0.15)
                        : kSecondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Heart Icon_2.svg",
                    color: _isFavorite
                        ? Color(0xFFFF4848)
                        : Color(0xFFDBDEE4),
                  ),
                ),
              ),
            ],
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
          tag: "all_products_${widget.product!.id}",
          child: Image.network(widget.product!.images[0]),
        ),
      ),
    );
  }

  void _onHeartIconTap() async {
    setState(() {
      _updatingFavorite = true;
    });

    bool updatedFavorite = await ProductController.toggleFavorite(
      widget.product!.id,
      _isFavorite,
    );

    setState(() {
      _updatingFavorite = false;

      if (updatedFavorite != _isFavorite) {
        _isFavorite = updatedFavorite;
      }
    });
  }
}
