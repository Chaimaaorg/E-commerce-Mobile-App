import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../sign_in/sign_in_screen.dart';
import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
          ),
        ),
      ),
      body: Body(),
    );
  }
}
