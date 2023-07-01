import 'package:Districap/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../components/size_config.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../theme.dart';
import '../../../../widgets/coustom_bottom_nav_bar.dart';
import '../../../../enums.dart';
import '../../../../providers/sign_in_provider.dart';
import '../../../sign_in/sign_in_screen.dart';
import 'package:Districap/screens/profile/components/help_profile/components/body.dart';

class HelpProfileScreen extends StatelessWidget {
  static String routeName = "/help-center";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      appBar: commonAppBarProfile(context, 'Help Center',70.0,(){
        Navigator.pushReplacementNamed(
            context, ProfileScreen.routeName);
      }, 'assets/icons/Log out.svg', false, () {
        sp.userSignOut();
        Navigator.pushReplacementNamed(
            context, SignInScreen.routeName);
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
    );
  }
}
