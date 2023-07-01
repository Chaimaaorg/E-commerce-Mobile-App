import 'package:Districap/constants.dart';
import 'package:Districap/widgets/details_widgets/see_more_details_screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../models/Product.dart';
import 'cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {
  final VoidCallback shareproduct;
  final Product? product;

  const CounterWithFavBtn({
    Key? key,
    required this.shareproduct,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        SizedBox(width: 70,),
        GestureDetector(
          onTap: shareproduct,
          child: Container(
            padding: EdgeInsets.all(8),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/icons/share.svg",
              color: Colors.white,
            ),
          ),
        ),
        GestureDetector(
          onTap: () =>Navigator.pushReplacementNamed(context, SeeMoreDetailsScreenHome.routeName,arguments: product),
          child: Container(
            padding: EdgeInsets.only(top:8,bottom: 8,left: 8,right: 8),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/icons/Discover.svg",
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
