import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../theme.dart';
import '../../../../widgets/coustom_bottom_nav_bar.dart';
import '../../../../enums.dart';
import '../../../../providers/sign_in_provider.dart';
import '../../../sign_in/sign_in_screen.dart';
import 'package:Districap/screens/profile/components/notifs/components/body.dart';

import '../../profile_screen.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notifs";

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Theme(
        data: context.watch<ThemeProvider>().themeData,
        child: Scaffold(
          appBar: commonAppBarProfile(
              context,
              'Notifications',
              70.0,
              () {
                Navigator.pushReplacementNamed(
                    context, ProfileScreen.routeName);
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
            height: 63.0,
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
