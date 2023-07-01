import 'package:Districap/screens/home/components/popular_products/popular_product.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import '../../../widgets/home_widgets/categories.dart';
import '../../../widgets/home_widgets/discount_banner.dart';
import '../../../widgets/home_widgets/special_offers.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(20)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
