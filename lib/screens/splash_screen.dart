import 'dart:async';
import 'package:Districap/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/size_config.dart';
import '../providers/sign_in_provider.dart';
import 'home/home_screen.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    bool showOnboarding = prefs.getBool('ON_BOARDING') ?? true;
    final sp = context.read<SignInProvider>();
    Timer(const Duration(milliseconds: 1500), () {
      if(showOnboarding)
        {
          Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
        }
      else
        {
          if(sp.isSignedIn)
            {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
          else
            {
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);

            }

        }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Image.asset(
                'assets/images/logoSplash.png',
                height: 300.0,
                width: 300.0,
              ),
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Text(
                'Simplify your shopping, enhance your security with DISTRICAP!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFFDD072A)),
                  ),
                  SizedBox(height: 20.0),
                  Text('Loading'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}