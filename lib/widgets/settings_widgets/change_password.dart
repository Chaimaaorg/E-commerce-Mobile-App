import 'package:Districap/providers/theme_provider.dart';
import 'package:Districap/screens/profile/components/settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_surfix_icon.dart';
import '../../components/default_button.dart';
import '../../components/form_error.dart';
import '../../components/size_config.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../providers/sign_in_provider.dart';
import '../../screens/sign_in/sign_in_screen.dart';
import '../../theme.dart';
import '../coustom_bottom_nav_bar.dart';

class ChangePassword extends StatelessWidget {
  static String routeName = "/edit-password";

  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    SizeConfig().init(context);
    return Theme(
      data: context.watch<ThemeProvider>().themeData,
      child: Scaffold(
        appBar: commonAppBarProfile(
            context,
            'Password settings',
            50.0,
            () {
              Navigator.pushReplacementNamed(context, SettingsScreen.routeName);
            },
            'assets/icons/Log out.svg',
            false,
            () {
              sp.userSignOut();
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            }),
        body: ChangePasswordBody(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.profile,
          height: 63.0,
          color: context
                      .watch<ThemeProvider>()
                      .themeData
                      .scaffoldBackgroundColor ==
                  Colors.grey.shade900
              ? Colors.grey.shade900
              : Colors.white,
        ),
      ),
    );
  }
}

class ChangePasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Change Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Please enter your new password",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ChangePassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePassForm extends StatefulWidget {
  @override
  _ChangePassFormState createState() => _ChangePassFormState();
}

class _ChangePassFormState extends State<ChangePassForm> {
  final _formKey = GlobalKey<FormState>();
  String? password;
  String? conform_password;
  bool remember = false;
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void updatePassword() async {
    try {
      // Re-authenticate the user before updating the password
      var user = FirebaseAuth.instance.currentUser;
      var credential = EmailAuthProvider.credential(
          email: user!.email!, password: password!);
      await user.reauthenticateWithCredential(credential);

      // If re-authentication is successful, update the password
      await user.updatePassword(conform_password!);

      // The password update is successful, now sign out the user
      await FirebaseAuth.instance.signOut();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text('Your password has been changed. Please log in again!'),
      ));
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kPaletteColor,
        content: Text('An error occurred. Please try again.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              contentPadding: EdgeInsets.only(left: 25, top: 17, bottom: 20),
              labelText: "Old password",
              hintText: "Enter your password",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => conform_password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              conform_password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              contentPadding: EdgeInsets.only(left: 25, top: 17, bottom: 20),
              labelText: "New Password",
              hintText: "Enter your new password",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          DefaultButton(
            color: kPrimaryColor,
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  password = _passwordController.text;
                });
                updatePassword();
                // Do what you want to do
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
        ],
      ),
    );
  }
}
