import 'package:Districap/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:Districap/screens/signin_phone/components/body.dart';
import 'package:Districap/size_config.dart';
import 'package:flutter_svg/svg.dart';


class SignInPhone extends StatelessWidget {
  static String routeName = "/sign_in_phone";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
