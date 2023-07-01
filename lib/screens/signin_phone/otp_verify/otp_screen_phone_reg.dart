import 'package:Districap/screens/signin_phone/signin_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:Districap/size_config.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'components/body.dart';

class OtpScreenPhone extends StatelessWidget {
  static String routeName = "/otp-verify";

  const OtpScreenPhone({super.key});
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
              Navigator.pushReplacementNamed(context, SignInPhone.routeName);
            },
          ),
        ),
      ),
      body: Body(),
    );
  }
}
