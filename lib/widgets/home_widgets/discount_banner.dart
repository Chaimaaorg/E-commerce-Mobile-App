import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(70),
      width: getProportionateScreenWidth(210),
      // margin: EdgeInsets.all(getProportionateScreenWidth(10)),
      margin: EdgeInsets.only(right: 160, top: 0,bottom: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18), // Adjust this value as needed
        child: Transform.scale(
          scale: 1, // Adjust the scale factor to zoom in/out the image
          child: Image.asset(
            "assets/images/banner_image1.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
