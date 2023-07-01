import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../components/size_config.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../../providers/product_provider.dart';
import '../../screens/seek_info/components/rate_product_screen.dart';

class CustomAppBar extends StatefulWidget {
  final Product? product;

  const CustomAppBar({Key? key, required this.product}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _alertShown = false; // Track if the alert has been shown
  double? rate; // Add a rate variable in the state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (!_alertShown) {
        _alertShown = true; // Set the flag to true
        showQuickAlert(context); // Show the initial alert
      }
    });

    // Call getAverageRating to fetch the average rating
    Provider.of<ProductProvider>(context, listen: false)
        .getAverageRating(widget.product!.id)
        .then((value) {
      setState(() {
        rate = value; // Set the rate after fetching
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProv = Provider.of<ProductProvider>(context);
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                RateProductBottomSheet(
                        product: widget.product, productProvider: productProv)
                    .showRatingDialog(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      (rate ?? 0.0).toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showQuickAlert(BuildContext context) {
    return QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        confirmBtnColor: Colors.amber,
        text: 'Click on the star icon to rate the product!',
        textColor: Colors.black,
        backgroundColor: Colors.white);
  }
}
