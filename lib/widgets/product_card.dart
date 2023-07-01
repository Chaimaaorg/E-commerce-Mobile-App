import 'package:Districap/providers/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Districap/models/Product.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/promotion_provider.dart';
import '../screens/home/components/details/details_screen.dart';
import '../size_config.dart';
import '../controllers/product_controller.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.product,
    required this.isFavorite,
  }) : super(key: key);

  final double width, aspectRatio;
  final Product product;
  final bool isFavorite;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;
  bool _updatingFavorite = false;
  bool _isPromoted = false;
  String? _discount;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _checkPromotion();
  }

  Future<void> _checkPromotion() async {
    final provider =context.read<PromotionProvider>();
    bool isPromoted =
        await provider.isPromoted(widget.product.id);
    String? discount = await provider.getPromoDiscountByProdId(widget.product.id);
    setState(() {
      _isPromoted = isPromoted;
      _discount = discount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return widget.product.availability == 0
        ?buildCardWithBanner('Sold out', buildProductCard())
        : _isPromoted ? buildCardWithBanner('Promo -$_discount\%', buildProductCard()) : buildProductCard();
  }
  ClipRRect buildCardWithBanner(String title,Padding buildProductCard )
  {
    return ClipRRect(
      child: Banner(
        message: title,
        location: BannerLocation.topEnd,
        color: kPrimaryColor,
        textStyle: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600),
        child: buildProductCard,
      ),
    );
  }

  Padding buildProductCard() {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(
              product: widget.product,
              isFavourite: _isFavorite,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(widget.product.images[0]),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.product.price}dh",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
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
                        color:
                            _isFavorite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onHeartIconTap() async {
    setState(() {
      _updatingFavorite = true;
    });

    bool updatedFavorite = await ProductController.toggleFavorite(
      widget.product.id,
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
