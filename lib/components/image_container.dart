import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    this.height = 125,
    this.borderRadius = 20,
    required this.width,
    required this.imageUrl,
    this.imageUrl1,
    this.padding,
    this.margin,
    this.child,
    required this.networkImage,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageUrl;
  final String? imageUrl1;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;
  final bool networkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            // Add your desired shadow color here
            spreadRadius: 5,
            // Add the spread radius of the shadow
            blurRadius: 7,
            // Add the blur radius of the shadow
            offset: Offset(0, 3), // Add the offset of the shadow
          ),
        ],
        image: networkImage
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
      ),
      child: child,
    );
  }
}
