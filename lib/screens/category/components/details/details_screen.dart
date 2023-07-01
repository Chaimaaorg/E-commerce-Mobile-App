import 'package:Districap/enums.dart';
import 'package:Districap/screens/seek_info/components/rate_product_screen.dart';
import 'package:Districap/widgets/coustom_bottom_nav_bar.dart';
import 'package:Districap/screens/category/components/details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../../../../constants.dart';
import '../../../../../../models/Product.dart';
import '../../../../../../providers/share_provider.dart';
import '../../../../providers/product_provider.dart';

class DetailsScreen extends StatefulWidget {
  final Product? product;

  const DetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey _detailsGolablKey = GlobalKey();

  bool _alertShown = false; // Track if the alert has been shown

  @override
  void initState() {
    super.initState();
    _initializeTempImagePath();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (!_alertShown) {
        _alertShown = true; // Set the flag to true
        showQuickAlert(context); // Show the initial alert
      }
    });
  }

  Future<void> _initializeTempImagePath() async {
    await context.read<ShareProvider>().createTempImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _detailsGolablKey,
      child: Scaffold(
        backgroundColor: kBeautifulBlue,
        appBar: buildAppBar(context),
        body: Body(
          product: widget.product,
          heroTag: widget.product!.id.toString(),
          shareproduct: () => context.read<ShareProvider>().shareProduct(context,_detailsGolablKey, widget.product),
        ),
        bottomNavigationBar: const CustomBottomNavBar(
          selectedMenu: MenuState.favourite,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final productProv = Provider.of<ProductProvider>(context);
    final productProvider = context.read<ProductProvider>();
    return AppBar(
      backgroundColor: kBeautifulBlue,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/Back ICon.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 5, right: 5),
          child: GestureDetector(
            onTap: ()=>RateProductBottomSheet(product:widget.product, productProvider: productProv).showRatingDialog(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14), color: Colors.white),
              child: Row(
                children: [
                  Text(
                    productProvider.rate.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
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
