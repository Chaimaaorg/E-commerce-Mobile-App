import 'package:Districap/constants.dart';
import 'package:flutter/material.dart';
import 'package:Districap/screens/sign_in/components/body.dart';
import 'package:Districap/size_config.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Text("Sign In ",style: TextStyle(color: kPrimaryColor),),
        ),
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
