import 'package:Districap/constants.dart';
import 'package:flutter/material.dart';
import 'package:Districap/screens/onboarding/components/body.dart';
import 'package:Districap/size_config.dart';

class OnBoardingScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBgColor,
      body: Body(),
    );
  }
}
