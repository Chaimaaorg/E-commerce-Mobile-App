import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../size_config.dart';
import '../../screens/category/category_screen.dart';
import '../../screens/show_all_products/show_all_products_screen.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/KVM.svg",
        "text": "KVM",
        "category":"KVM"
      },
      {"icon": "assets/icons/streaming.svg", "text": "Stream","category":"Streaming"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game","category":"Gaming"},
      {"icon": "assets/icons/Video Projection.svg", "text": "Video Projection","category":"Video projection"},
      {"icon": "assets/icons/Discover.svg", "text": "More","category":"More"},
    ];
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenWidth(0),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          bottom: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
              (index) =>
              CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                category: categories[index]["category"],
              ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.category,
  }) : super(key: key);

  final String? icon, text;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (category == "More") {
          // Navigate to the More screen
          navigateToMoreScreen(context);
        } else {
          // Navigate to the regular category screen
          navigateToCategoryScreen(context, category);
        }
      },
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFfee6ea),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(
              text!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void navigateToCategoryScreen(BuildContext context, String? category) {
    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: category);
  }

  void navigateToMoreScreen(BuildContext context) {
    Navigator.pushNamed(context, ShowAllProductsScreen.routeName);
  }
}
