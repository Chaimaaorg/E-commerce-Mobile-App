import 'package:Districap/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../theme.dart';
import '../../../../widgets/coustom_bottom_nav_bar.dart';
import 'package:Districap/screens/profile/components/edit_profile/components/Body.dart';
import '../../../../enums.dart';
import '../settings/settings_screen.dart';

class EditProfileScreen extends StatelessWidget {
  static String routeName = "/edit-profile";

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context
          .watch<ThemeProvider>()
          .themeData,
      child: Scaffold(
        appBar: commonAppBarProfile(context, 'Edit Profile',70.0,(){
          Navigator.pushReplacementNamed(
              context, ProfileScreen.routeName);
        }, 'assets/icons/Settings.svg', true, () {
          Navigator.pushReplacementNamed(
              context, SettingsScreen.routeName);
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
      ),
    );
  }
}

