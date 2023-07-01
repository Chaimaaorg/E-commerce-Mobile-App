import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.top = 8,
    this.right = 9,
    this.numOfitem = 0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final double top, right;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: SvgPicture.asset(
            svgSrc,
            color: kTextColor,
          ),
          onPressed: press,
        ),
        if (numOfitem != 0)
          Positioned(
            top: top,
            right: right,
            child: Container(
              padding: EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$numOfitem",
                // Replace this with the actual number of notifications
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
