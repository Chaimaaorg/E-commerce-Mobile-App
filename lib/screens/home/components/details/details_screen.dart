import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/Product.dart';
import '../../../../providers/share_provider.dart';
import '../../../../widgets/details_widgets/custom_app_bar.dart';
import 'components/body.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailsScreen> {
  late Product _product; // Declare a new instance variable for the product
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeTempImagePath();
  }

  Future<void> _initializeTempImagePath() async {
    await context.read<ShareProvider>().createTempImagePath();
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
    ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    _product = args.product;
    bool isFavourite = args.isFavourite;
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(product: args.product),
        ),
        body: Body(
          isFavourite: isFavourite,
          product: args.product, shareProduct: () => context.read<ShareProvider>().shareProduct(context, _globalKey,args.product),
        ),
      ),
    );
  }


}

class ProductDetailsArguments {
  final Product product;
  final bool isFavourite;

  ProductDetailsArguments({required this.isFavourite, required this.product});
}

