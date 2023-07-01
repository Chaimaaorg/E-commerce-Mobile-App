import 'package:Districap/screens/profile/components/edit_profile/edit_profile_screen.dart';
import 'package:Districap/screens/profile/components/help_profile/help_profile_screen.dart';
import 'package:Districap/screens/profile/components/settings/settings_screen.dart';
import 'package:Districap/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/sign_in_provider.dart';
import 'notifs/notification_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          const SizedBox(height: 4),
          ProfileMenu(
            notif: false,
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushReplacementNamed(context, EditProfileScreen.routeName)
            },
          ),
          ProfileMenu(
            notif: true,
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.pushReplacementNamed(context, NotificationScreen.routeName);
            },
          ),
          ProfileMenu(
            notif: false,
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () => {
              Navigator.pushReplacementNamed(context, SettingsScreen.routeName)
            },
          ),
          ProfileMenu(
            notif: false,
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () => {
              Navigator.pushReplacementNamed(context, HelpProfileScreen.routeName)

            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              sp.userSignOut();
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            }, notif: false,
          ),
        ],
      ),
    );
  }
}
