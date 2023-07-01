import 'package:Districap/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:Districap/constants.dart';
import 'package:Districap/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_content.dart';

// This is the best practice

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "wave": "assets/images/wave1.png",
      "image": "assets/images/shop1.jpg",
      "title": "Purchase Online !!",
      "body":
          "Explore our wide range of products and make hassle-free purchases from the comfort of your fingertips."
    },
    {
      "wave": "assets/images/wave2.png",
      "image": "assets/images/truck2.jpeg",
      "title": "Track your order !!",
      "body":
          "Stay updated with real-time order tracking for a seamless shopping experience."
    },
    {
      "wave": "assets/images/wave3.png",
      "image": "assets/images/delivery3.png",
      "title": "Get your order !!",
      "body":
          "Receive your orders quickly and reliably with our fast delivery service."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => OnBoardingContent(
                  wave: splashData[currentPage]["wave"],
                  // Use currentPage instead of index
                  image: splashData[currentPage]["image"],
                  // Use currentPage instead of index
                  title: splashData[currentPage]['title'],
                  // Use currentPage instead of index
                  body: splashData[currentPage]
                      ['body'], // Use currentPage instead of index
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Handle skip button press
                            setState(() {
                              currentPage = splashData.length - 1;
                            });
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: List.generate(
                            splashData.length,
                            (index) => buildDot(index: index),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            if (currentPage < splashData.length - 1) {
                              // Go to the next page
                              setState(() {
                                currentPage++;
                              });
                            } else {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('ON_BOARDING', false);
                              Navigator.pushReplacementNamed(
                                  context, SignInScreen.routeName);
                              // Handle done button press
                            }
                          },
                          child: Text(
                            currentPage < splashData.length - 1
                                ? "Next"
                                : "Done",
                            style: TextStyle(
                              color: currentPage < splashData.length - 1
                                  ? Colors.black
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
