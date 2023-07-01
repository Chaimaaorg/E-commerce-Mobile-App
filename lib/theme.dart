import 'package:Districap/providers/product_search_state.dart';
import 'package:Districap/screens/cart/cart_screen.dart';
import 'package:Districap/screens/profile/components/notifs/notification_screen.dart';
import 'package:Districap/search/produc_search_all_products.dart';
import 'package:Districap/search/product_search_category.dart';
import 'package:Districap/search/product_search_fav.dart';
import 'package:Districap/services/noti.dart';
import 'package:Districap/widgets/home_widgets/icon_btn_with_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  // Define other light theme properties like primary color, text styles, etc.
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // Define other dark theme properties like primary color, text styles, etc.
);

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle:
          TextTheme(headline6: TextStyle(color: Color(0XFFDD072A))).bodyText2,
      titleTextStyle:
          TextTheme(headline6: TextStyle(color: Color(0XFFDD072A))).headline6,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: kTextColor),
      bodyText2: TextStyle(color: kTextColor),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  );
}

AppBar buildAppBar(BuildContext context, int cartItemCount,int numOfNotifs) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset(
          "assets/icons/barMenu.svg",
          width: 25,
          color: kTextColor,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
        color: kSecondaryColor,
      ),
    ),
    actions: <Widget>[
      Row(
        children: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Search Icon.svg",
              color: kTextColor,
            ),
            onPressed: () {},
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: numOfNotifs, // Replace with the actual number of notifications
            press: () {
              Navigator.pushNamed(context, NotificationScreen.routeName);
              // Reset the notification counter when the notifications icon is pressed
              Noti.notificationCounter = 0;
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfitem: cartItemCount, // Total number of items in the cart
            right: 7,
            press: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
        ],
      ),
      const SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

AppBar buildAppBarFavProducts(
    BuildContext context, int cartItemCount, String routeName) {
  final searchState = Provider.of<ProductSearchState>(context, listen: false);

  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
        onPressed: () {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    ),
    actions: <Widget>[
      Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Search Icon.svg",
                color: kTextColor,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegateFavourite(
                      searchState), // Pass searchState to delegate
                );
              },
            ),
          ),
          IconBtnWithCounter(
              numOfitem: cartItemCount,
              right: 7,
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              }),
        ],
      ),
      const SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

AppBar buildAppBarChat(
    BuildContext context, int cartItemCount, String routeName,int numOfNotifs) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
        onPressed: () {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    ),
    actions: <Widget>[
      Row(
        children: [
          IconBtnWithCounter(
              numOfitem: numOfNotifs,
              right: 7,
              svgSrc: "assets/icons/Bell.svg",
              press: () {
                Navigator.pushNamed(context, NotificationScreen.routeName);
                Noti.notificationCounter = 0;
              }),
          IconBtnWithCounter(
              numOfitem: cartItemCount,
              right: 7,
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              }),
        ],
      ),
      const SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

AppBar buildAppCategory(BuildContext context, int cartItemCount,
    String routeName, String category) {
  final searchState = Provider.of<ProductSearchState>(context, listen: false);

  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
        onPressed: () {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    ),
    actions: <Widget>[
      Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Search Icon.svg",
                color: kTextColor,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegateCategory(
                      searchState, category), // Pass searchState to delegate
                );
              },
            ),
          ),
          IconBtnWithCounter(
              numOfitem: cartItemCount,
              right: 7,
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              }),
        ],
      ),
      const SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

AppBar buildAppAllProducts(
    BuildContext context, int cartItemCount, String routeName) {
  final searchStateProducts =
      Provider.of<ProductSearchState>(context, listen: false);

  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
        onPressed: () {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    ),
    actions: <Widget>[
      Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Search Icon.svg",
                color: kTextColor,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegateAllProducts(
                    searchStateProducts,
                  ), // Pass searchState to delegate
                );
              },
            ),
          ),
          IconBtnWithCounter(
              numOfitem: cartItemCount,
              right: 7,
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              }),
        ],
      ),
      const SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

AppBar buildAverageAppBar(BuildContext context, String routeName) {
  return AppBar(
    title: const Padding(
        padding: EdgeInsets.only(left: 70), child: Text("Check out")),
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
        onPressed: () {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    ),
  );
}

AppBar commonAppBarProfile(
    BuildContext context,
    String title,
    double left,
    void Function()? backFun,
    String iconAsset,
    bool setting,
    void Function()? iconFun) {
  return AppBar(
    title: Padding(
      padding: EdgeInsets.only(left: left),
      child: Text(
        title,
        style: const TextStyle(
            color: kPrimaryColor, fontWeight: FontWeight.normal, fontSize: 16),
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 2,
    leading: Builder(
      builder: (context) => IconButton(
        icon: SvgPicture.asset(
          "assets/icons/Back ICon.svg",
        ),
        onPressed: backFun,
        color: kSecondaryColor,
      ),
    ),
    actions: <Widget>[
      Row(
        children: [
          IconButton(
            icon: setting
                ? SvgPicture.asset(
                    iconAsset,
                    width: 30,
                    height: 20,
                    color: Colors.black,
                  )
                : SvgPicture.asset(
                    iconAsset,
                    width: 22,
                    height: 20,
                    color: Colors.black,
                  ),
            onPressed: iconFun,
          ),
        ],
      ),
      const SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}
