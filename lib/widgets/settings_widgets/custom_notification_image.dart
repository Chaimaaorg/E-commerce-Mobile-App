import 'package:Districap/constants.dart';
import 'package:flutter/material.dart';

class CustomNotificationImage extends StatelessWidget {

  CustomNotificationImage({
    this.color = kSecondaryColor,
    required this.active,
    required this.image,
    Key? key,
  }) : super(key: key);
  String? image;
  Color? color;
  bool? active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color != null && active == true
            ? color!.withOpacity(0.1)
            : Colors.transparent,
        boxShadow: active == true
            ? [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // controls the shadow position
          ),
        ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image ?? "", // Use an empty string as the default value if image is null
          width: 57,
          height: 57,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


}
