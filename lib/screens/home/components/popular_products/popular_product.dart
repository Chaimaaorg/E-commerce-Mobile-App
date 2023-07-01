import 'package:Districap/controllers/product_controller.dart';
import 'package:Districap/screens/show_all_products/show_all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:Districap/widgets/product_card.dart';
import '../../../../components/size_config.dart';
import '../../../../models/Product.dart';
import '../../../../widgets/home_widgets/section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.pushNamed(context, ShowAllProductsScreen.routeName);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder<List<Product>>(
            stream: ProductController().getAllProductsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                List<Product> productsList = snapshot.data!;
                return Row(
                  children: [
                    ...List.generate(
                      productsList.length,
                          (index) {
                        if (productsList[index].isPopular) {
                          return FutureBuilder(
                            future: ProductController.isProductFavorite(
                                productsList[index].id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                bool isFavorite = snapshot.data as bool;
                                return ProductCard(
                                  product: productsList[index],
                                  isFavorite: isFavorite,
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
