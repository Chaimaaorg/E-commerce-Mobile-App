import 'package:Districap/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../widgets/coustom_bottom_nav_bar.dart';
import 'package:Districap/screens/profile/components/settings/components/Body.dart';
import '../../../../enums.dart';
import '../../../../providers/sign_in_provider.dart';
import '../../../sign_in/sign_in_screen.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Theme(
      data: context
          .watch<ThemeProvider>()
          .themeData, // Use the current theme from the provider
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 70.0),
            child: Text(
              'Settings',
              style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.normal),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Back ICon.svg",
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, ProfileScreen.routeName);
              },
              color: kSecondaryColor,
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/Log out.svg',
                      width: 22,
                      height: 20,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      sp.userSignOut();
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                    }),
              ],
            ),
            const SizedBox(width: kDefaultPaddin / 2)
          ],
        ),
        body: const Body(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.profile,
          height: 63.0,
          color: context
              .watch<ThemeProvider>()
              .themeData.scaffoldBackgroundColor == Colors.grey.shade900 ? Colors.grey.shade900 : Colors.white,
        ),
      ),
    );
  }
}
