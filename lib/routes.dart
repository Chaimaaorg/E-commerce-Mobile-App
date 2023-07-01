import 'package:Districap/screens/cart/cart_screen.dart';
import 'package:Districap/screens/category/category_screen.dart';
import 'package:Districap/screens/check_out/check_out_screen.dart';
import 'package:Districap/screens/check_out/components/error_screen.dart';
import 'package:Districap/screens/check_out/components/success_screen.dart';
import 'package:Districap/screens/home/components/details/details_screen.dart';
import 'package:Districap/screens/home/components/favourite_products/components/details/components/see_more_details_screen.dart';
import 'package:Districap/screens/home/components/favourite_products/favourite_products.dart';
import 'package:Districap/screens/onboarding/onboarding_screen.dart';
import 'package:Districap/screens/profile/components/edit_profile/edit_profile_screen.dart';
import 'package:Districap/screens/profile/components/help_profile/help_profile_screen.dart';
import 'package:Districap/screens/profile/components/notifs/notification_screen.dart';
import 'package:Districap/screens/profile/components/settings/settings_screen.dart';
import 'package:Districap/screens/profile/profile_screen.dart';
import 'package:Districap/screens/seek_info/components/send_message_screen.dart';
import 'package:Districap/screens/seek_info/seek_info_screen.dart';
import 'package:Districap/screens/show_all_products/show_all_products_screen.dart';
import 'package:Districap/screens/signin_phone/otp_verify/otp_screen_phone_reg.dart';
import 'package:Districap/screens/signin_phone/signin_phone_screen.dart';
import 'package:Districap/widgets/details_widgets/more_details_screen.dart';
import 'package:Districap/widgets/details_widgets/see_more_details_screen_home.dart';
import 'package:Districap/widgets/settings_widgets/change_password.dart';
import 'package:Districap/widgets/settings_widgets/content_settings.dart';
import 'package:Districap/widgets/settings_widgets/terms_and_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Districap/screens/complete_profile/complete_profile_screen.dart';
import 'package:Districap/screens/forgot_password/forgot_password_screen.dart';
import 'package:Districap/screens/home/home_screen.dart';
import 'package:Districap/screens/login_success/login_success_screen.dart';
import 'package:Districap/screens/otp/otp_screen.dart';
import 'package:Districap/screens/sign_in/sign_in_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  SignInPhone.routeName: (context) =>SignInPhone(),
  OtpScreenPhone.routeName: (context) => OtpScreenPhone(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  SettingsScreen.routeName: (context) =>SettingsScreen(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  HelpProfileScreen.routeName: (context) => HelpProfileScreen(),
  MoreDetailsScreen.routeName: (context) => MoreDetailsScreen(),
  ChangePassword.routeName: (context) => ChangePassword(),
  // Languages.routeName: (context) => Languages(),
  ContentSettings.routeName : (context) =>  ContentSettings(),
  TermsAndPolicy.routeName: (context) => TermsAndPolicy(mdFileName: 'privacy_policy.md',),
  FavouriteProductsScreen.routeName: (context) => FavouriteProductsScreen(),
  CategoryScreen.routeName: (context) =>  CategoryScreen(),
  ShowAllProductsScreen.routeName : (context) =>  ShowAllProductsScreen(),
  SeekInfoScreen.routeName: (context) =>SeekInfoScreen(),
  SendMessageScreen.routeName: (context) =>SendMessageScreen(),
  SeeMoreDetailsScreen.routeName : (context) => SeeMoreDetailsScreen(),
  SeeMoreDetailsScreenHome.routeName:(context) =>SeeMoreDetailsScreenHome(),
  CheckOutScreen.routeName:(context) =>CheckOutScreen(),
  SuccessScreen.routeName:(context) =>SuccessScreen(),
  ErrorScreen.routeName:(context) =>ErrorScreen(),


};

