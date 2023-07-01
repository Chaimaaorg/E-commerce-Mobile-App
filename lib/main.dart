import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Districap/providers/cart_provider.dart';
import 'package:Districap/providers/internet_provider.dart';
import 'package:Districap/providers/product_provider.dart';
import 'package:Districap/providers/product_search_state.dart';
import 'package:Districap/providers/promotion_provider.dart';
import 'package:Districap/providers/share_provider.dart';
import 'package:Districap/providers/sign_in_provider.dart';
import 'package:Districap/providers/theme_provider.dart';
import 'package:Districap/routes.dart';
import 'package:Districap/screens/splash_screen.dart';
import 'package:Districap/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(
          create: ((context) => ProductSearchState()),
        ), // Add this line
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
        ChangeNotifierProvider(create: ((context) => ShareProvider())),
        ChangeNotifierProvider(create: ((context) => ThemeProvider())),
        ChangeNotifierProvider(create: ((context) => ProductProvider())),
        ChangeNotifierProvider(create: ((context) => PromotionProvider())),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: theme(),
        routes: routes,
      ),
    );
  }
}



