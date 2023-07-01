import 'package:flutter/material.dart';
import '../../../components/default_button.dart';
import '../../../components/size_config.dart';
import '../../../components/utils.dart';
import '../../../constants.dart';
import '../../home/home_screen.dart';


class ErrorScreen extends StatelessWidget {
  static String routeName = "/order_error";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(250)),
          Image.asset(
            "assets/images/popular-x-circle.png",
            height: getProportionateScreenHeight(100), //40%
          ),
          SizedBox(height: getProportionateScreenHeight(20),),
          Center(
            child: Text(
              'Your request was not sent successfully.',
              maxLines: 2,
              textAlign:  TextAlign.center,
              style: safeGoogleFont(
                'ABeeZee',
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Color(0xfc000000),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30),),
          SizedBox(
            width: getProportionateScreenWidth(150),
            child: DefaultButton(
              text: "Back to home",
              color: bluePanel,
              press: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ),
          SizedBox(height: 5,),
        ],
      ),
      bottomNavigationBar:
      Image.asset(
        "assets/images/bg-pc7.png",
        color: kPrimaryColor,
        height: getProportionateScreenHeight(240),
        width: double.infinity,//40%
      ),
    );
  }
}



