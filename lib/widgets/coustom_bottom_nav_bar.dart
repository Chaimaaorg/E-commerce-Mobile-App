import 'package:Districap/screens/cart/cart_screen.dart';
import 'package:Districap/screens/seek_info/seek_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Districap/screens/home/home_screen.dart';
import 'package:Districap/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enums.dart';
import '../screens/home/components/favourite_products/favourite_products.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,this.height=56.0,  this.color =Colors.white }) : super(key: key);

  final MenuState selectedMenu;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    int currentIndex = _mapMenuStateToIndex(selectedMenu);

    return Padding(
      padding: const EdgeInsets.only(top:0.0),
      child: CurvedNavigationBar(
        backgroundColor: color,
        buttonBackgroundColor: kPrimaryColor,
        color: kPrimaryColor,
        height: height,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) => navigateToPage(context, index),
        index: currentIndex,
        items: [
          SvgPicture.asset(
            "assets/icons/Shop Icon.svg",
            height: 20,
            color: MenuState.home == selectedMenu ? Colors.white : Colors.white,
          ),
          SvgPicture.asset(
            "assets/icons/Heart Icon.svg",
            height: 20,
            color: MenuState.favourite == selectedMenu
                ? Colors.white
                : Colors.white,
          ),
          SvgPicture.asset(
            "assets/icons/Chat bubble Icon.svg",
            height: 20,
            color: MenuState.cart == selectedMenu
                ? Colors.white
                : Colors.white,
          ),
          SvgPicture.asset(
            "assets/icons/User Icon.svg",
            height: 20,
            color: MenuState.profile == selectedMenu
                ? Colors.white
                : Colors.white,
          ),
        ],
      ),
    );
  }

  void navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomeScreen.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, FavouriteProductsScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, SeekInfoScreen.routeName);
        break;
      case 3:
        Navigator.pushNamed(context, ProfileScreen.routeName);
        break;
    }
  }

  int _mapMenuStateToIndex(MenuState menuState) {
    switch (menuState) {
      case MenuState.home:
        return 0;
      case MenuState.favourite:
        return 1;
      case MenuState.message:
        return 2;
      case MenuState.profile:
        return 3;
      default:
        return 0;
    }
  }
}
