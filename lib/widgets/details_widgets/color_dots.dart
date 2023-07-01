import 'package:flutter/material.dart';
import 'package:Districap/components/rounded_icon_btn.dart';
import 'package:Districap/models/Product.dart';
import '../../../../../components/size_config.dart';
import '../../../../../constants.dart';
// Create a stateful widget to manage the cart items
class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  static int selectedColor=0;
  static int selectedQuantity=1;


  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
                (index) => GestureDetector(
              onTap: () {
                setState(() {
                  ColorDots.selectedColor = index;
                });
              },
              child: ColorDot(
                color: widget.product.colors[index],
                isSelected: index == ColorDots.selectedColor,
              ),
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                if (ColorDots.selectedQuantity > 0) {
                  ColorDots.selectedQuantity--;
                }
              });
            },
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Text(
            ColorDots.selectedQuantity.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                ColorDots.selectedQuantity++;
              });
            },
          ),
        ],
      ),
    );
  }
}
class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
        Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
