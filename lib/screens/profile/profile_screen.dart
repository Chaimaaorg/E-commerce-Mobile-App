import 'package:Districap/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:Districap/widgets/coustom_bottom_nav_bar.dart';
import 'package:Districap/enums.dart';
import '../../providers/theme_provider.dart';
import '../../theme.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/body.dart';
import '../../../../providers/sign_in_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Theme(
        data: context
            .watch<ThemeProvider>()
            .themeData, // Use the current theme from the provider
        child: Scaffold(
          appBar: commonAppBarProfile(
              context,
              'Profile',
              90.0,
              () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              'assets/icons/Log out.svg',
              false,
              () {
                sp.userSignOut();
                Navigator.pushReplacementNamed(context, SignInScreen.routeName);
              }),
          body: Body(),
          bottomNavigationBar: CustomBottomNavBar(
            selectedMenu: MenuState.profile,
            height: 56.0,
            color: context
                        .watch<ThemeProvider>()
                        .themeData
                        .scaffoldBackgroundColor ==
                    Colors.grey.shade900
                ? Colors.grey.shade900
                : Colors.white,
          ),
        ));
  }
}
