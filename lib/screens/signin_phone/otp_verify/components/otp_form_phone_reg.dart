import 'package:Districap/screens/signin_phone/components/signin_phone_form.dart';
import 'package:flutter/material.dart';
import 'package:Districap/components/default_button.dart';
import 'package:Districap/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../../components/snack_bar.dart';
import '../../../../constants.dart';
import '../../../../providers/internet_provider.dart';
import '../../../../providers/sign_in_provider.dart';
import '../../../home/home_screen.dart';

class OtpFormPhoneReg extends StatefulWidget {
  @override
  _OtpFormPhoneRegState createState() => _OtpFormPhoneRegState();
}

class _OtpFormPhoneRegState extends State<OtpFormPhoneReg> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<String> pinValues = ['', '', '', '', '', ''];

  _OtpFormPhoneRegState();

  var code = "";

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  String getPinValue() {
    return pinValues.join('');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        SizedBox(height: SizeConfig.screenHeight * 0.15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: TextFormField(
                autofocus: true,
                obscureText: true,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin2FocusNode);
                  setState(() {
                    pinValues[0] = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: TextFormField(
                focusNode: pin2FocusNode,
                obscureText: true,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin3FocusNode);
                  setState(() {
                    pinValues[1] = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: TextFormField(
                focusNode: pin3FocusNode,
                obscureText: true,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin4FocusNode);
                  setState(() {
                    pinValues[2] = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: TextFormField(
                focusNode: pin4FocusNode,
                obscureText: true,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin5FocusNode);
                  setState(() {
                    pinValues[3] = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: TextFormField(
                focusNode: pin5FocusNode,
                obscureText: true,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value, pin6FocusNode);
                  setState(() {
                    pinValues[4] = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: TextFormField(
                focusNode: pin6FocusNode,
                obscureText: true,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  if (value.length == 1) {
                    pin6FocusNode!.unfocus();
                    // Then you need to check is the code is correct or not
                    setState(() {
                      pinValues[5] = value;
                      code = getPinValue();
                    });
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.15),
        DefaultButton(
            text: "Continue",
            color: kPrimaryColor,
            press: () async {
              final sp = context.read<SignInProvider>();
              final ip = context.read<InternetProvider>();
              await ip.checkInternetConnection();

              FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: SignInPhoneForm.phoneNumber,
                  verificationCompleted: (AuthCredential credential) async {
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    openSnackbar(context, e.toString(), Colors.red);
                  },
                  codeSent:
                      (String verificationId, int? forceResendingToken) async {
                    AuthCredential authCredential =
                        PhoneAuthProvider.credential(
                            verificationId: SignInPhoneForm.verify, smsCode: code);
                    User user = (await FirebaseAuth.instance
                            .signInWithCredential(authCredential))
                        .user!;
                    // save the values
                    sp.phoneNumberUser(
                        user, SignInPhoneForm.email, SignInPhoneForm.fullName,FirebaseAuth.instance.currentUser!.uid);
                    // checking whether user exists,
                    sp.checkUserExists().then((value) async {
                      if (value == true) {
                        // user exists
                        await sp.getUserDataFromFirestore(sp.uid).then(
                            (value) => sp
                                .saveDataToSharedPreferences()
                                .then((value) => sp.setSignIn().then((value) {
                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.routeName);
                                    })));
                      } else {
                        // user does not exist
                        await sp.saveDataToFirestore().then((value) => sp
                            .saveDataToSharedPreferences()
                            .then((value) => sp.setSignIn().then((value) {
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.routeName);
                                })));
                      }
                    });
                  },
                  codeAutoRetrievalTimeout: (String verification) {});
            })
      ]),
    );
  }
}
