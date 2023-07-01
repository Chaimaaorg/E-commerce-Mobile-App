import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/snack_bar.dart';
import '../constants.dart';
import '../providers/internet_provider.dart';
import '../providers/sign_in_provider.dart';
import '../screens/complete_profile/complete_profile_screen.dart';
import '../screens/complete_profile/components/complete_profile_form.dart';
import '../screens/home/home_screen.dart';
import '../screens/login_success/login_success_screen.dart';
import '../screens/otp/otp_screen.dart';

class AuthController {
  // handling google sigin in
  Future handleGoogleSignIn(BuildContext context) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      // googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          // googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) =>
                  sp
                      .saveDataToSharedPreferences()
                      .then((value) =>
                      sp.setSignIn().then((value) {
                        // googleController.success();
                        handleAfterSignIn(context);
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) =>
                  sp
                      .saveDataToSharedPreferences()
                      .then((value) =>
                      sp.setSignIn().then((value) {
                        // googleController.success();
                        handleAfterSignIn(context);
                      })));
            }
          });
        }
      });
    }
  }

  // handle after signin
  static handleAfterSignIn(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      print(FirebaseAuth.instance.currentUser!.uid);
      Navigator.pushNamed(context, HomeScreen.routeName);
    });
  }

  Future signIn(BuildContext context, String email, String password,
      bool remember, Function(dynamic) function) async {
    final sp = context.read<SignInProvider>();
    try {
      if (remember) {
        await saveRememberMePreference(true); // Save "Remember me" preference
      } else {
        await saveRememberMePreference(false);
      }
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      // Check if the entered email matches the Firebase email
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.email != email) {
          function("Incorrect email");
          return;
        }
        try {
          // Reauthenticate the user to verify the password
          AuthCredential credential = EmailAuthProvider.credential(
            email: email!,
            password: password!,
          );
          await user.reauthenticateWithCredential(credential);
          // Authentication successful, navigate to the success screen
          FocusScope.of(context).unfocus();
          Navigator.pushNamed(
            context,
            LoginSuccessScreen.routeName,
          );
          await sp.getUserDataFromFirestore(sp.uid).then((value) =>
              sp
                  .saveDataToSharedPreferences()
                  .then((value) =>
                  sp.setSignIn().then((value) {
                    handleAfterSignIn(context);
                  })));
        } catch (e) {
          function("Incorrect password");
        }
      }
    } catch (e) {
      function(kIncorrectEmailPwd);
      print('Authentication failed: $e');
    }
  }

  Future signUpEmailPwd(BuildContext context, String emailController,
      String passwordController) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
      // Extract the user's UID
      String uid = userCredential.user!.uid;
      // Navigate to the next screen and pass the UID as a parameter
      Navigator.pushNamed(
        context,
        CompleteProfileScreen.routeName,
        arguments: uid,
      );
    } catch (e) {
      // Handle any errors that occur during registration
      print('Sign up failed: $e');
    }
  }

  Future signUpComplete(BuildContext context, String uid, String email,
      String fullName, String phone, String address) async {
    final sp = context.read<SignInProvider>();
    try {
      final collectionRef = FirebaseFirestore.instance.collection('Users');
      final userData = {
        'favouriteProducts':null,
        'email': email,
        'fullname': fullName,
        'phone': "+212" + phone.trim(),
        'address': address,
        'uid': uid,
        'provider': "EMAIL/PWD", // Add more fields as needed
        'image_url': "https://winaero.com/blog/wp-content/uploads/2017/12/User-icon-256-blue.png",
      };
      // Set the user data in the Firestore collection
      await collectionRef.doc(uid).set(userData);
      sp.saveDataToSharedPreferences();
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: "+212" + phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          CompleteProfileForm.verify = verificationId;
          CompleteProfileForm.phoneNumber = "+212" + phone;
          Navigator.pushNamed(
            context,
            OtpScreen.routeName,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          CompleteProfileForm.verify = verificationId;
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Failure!!!"),
            content: Text("Failed to create the account, try again!!!"),
          );
        },
      );
      print('Failed to add user: $e');
    }
  }

  Future saveRememberMePreference(bool value) async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setBool('remember_me', value);
  }

}

