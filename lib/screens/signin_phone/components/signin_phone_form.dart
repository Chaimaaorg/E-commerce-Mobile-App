import 'package:Districap/screens/signin_phone/otp_verify/otp_screen_phone_reg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Districap/components/custom_surfix_icon.dart';
import 'package:Districap/components/default_button.dart';
import 'package:Districap/components/form_error.dart';
import 'package:provider/provider.dart';
import '../../../components/snack_bar.dart';
import '../../../constants.dart';
import '../../../providers/internet_provider.dart';
import '../../../providers/sign_in_provider.dart';
import '../../../size_config.dart';
import '../../home/home_screen.dart';
class SignInPhoneForm extends StatefulWidget {
  const SignInPhoneForm({super.key});

  static String verify="" ;
  static String phoneNumber = "";
  static String email = "";
  static String fullName = "";


  @override
  State<SignInPhoneForm> createState() => _SignInPhoneFormState();
}

class _SignInPhoneFormState extends State<SignInPhoneForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? fullName;
  String? phoneNumber;
  String? email;
  static final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final otpCodeController = TextEditingController();
  final _fullNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();


  @override
  void initState() {
    countryController.text = "+212";
  }

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            color: kPrimaryColor,
            press: () async {
              if (_formKey.currentState!.validate()) {
                SignInPhoneForm.phoneNumber = "+212${_phoneController.text.trim()}";
                SignInPhoneForm.email = _emailController.text;
                SignInPhoneForm.fullName = _fullNameController.text;
                final sp = context.read<SignInProvider>();
                final ip = context.read<InternetProvider>();
                await ip.checkInternetConnection();

                try {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: SignInPhoneForm.phoneNumber,
                    verificationCompleted: (AuthCredential credential) async {
                      await FirebaseAuth.instance.signInWithCredential(credential);
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      openSnackbar(context, e.toString(), Colors.red);
                    },
                    codeSent: (String verificationId, int? forceResendingToken) {
                      SignInPhoneForm.verify = verificationId;
                      Navigator.pushNamed(
                        context,
                        OtpScreenPhone.routeName,
                      );
                    },
                    codeAutoRetrievalTimeout: (String verification) {
                      SignInPhoneForm.verify = verification;
                    },
                  );
                } catch (e) {
                  // Handle any errors that may occur during phone number verification.
                  print("Error: $e");
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Row buildPhoneNumberFormField() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 40,
          child: TextField(
            controller: countryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        Text(
          "|",
          style: TextStyle(fontSize: 33, color: Colors.grey),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phoneNumber = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPhoneNumberNullError);
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPhoneNumberNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              contentPadding: EdgeInsets.only(left:25,top:17,bottom: 20),
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
        ),
      ],
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      controller: _fullNameController,
      onSaved: (newValue) => fullName = newValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        contentPadding: EdgeInsets.only(left:25,top:17,bottom: 20),
        labelText: "Full Name",
        hintText: "Enter your full name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        contentPadding: EdgeInsets.only(left:25,top:17,bottom: 20),
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  Future login(BuildContext context, String mobile) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your internet connection", Colors.red);
    } else {
      if (_formKey.currentState!.validate()) {
        FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: mobile,
            verificationCompleted: (AuthCredential credential) async {
              await FirebaseAuth.instance.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              openSnackbar(context, e.toString(), Colors.red);
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Enter Code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: otpCodeController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.code),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    const BorderSide(color: Colors.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                    const BorderSide(color: Colors.grey))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final code = otpCodeController.text.trim();
                              AuthCredential authCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: code);
                              User user = (await FirebaseAuth.instance
                                  .signInWithCredential(authCredential))
                                  .user!;
                              // save the values
                              sp.phoneNumberUser(user, _emailController.text,
                                  _fullNameController.text,FirebaseAuth.instance.currentUser!.uid);
                              // checking whether user exists,
                              sp.checkUserExists().then((value) async {
                                if (value == true) {
                                  // user exists
                                  await sp
                                      .getUserDataFromFirestore(sp.uid)
                                      .then((value) =>
                                      sp
                                          .saveDataToSharedPreferences()
                                          .then((value) =>
                                          sp.setSignIn().then((value) {
                                            Navigator.pushReplacementNamed(
                                                context,
                                                HomeScreen.routeName);
                                          })));
                                } else {
                                  // user does not exist
                                  await sp.saveDataToFirestore().then((value) =>
                                      sp.saveDataToSharedPreferences().then(
                                              (value) =>
                                              sp.setSignIn().then((value) {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    HomeScreen.routeName);
                                              })));
                                }
                              });
                            },
                            child: const Text("Confirm"),
                          )
                        ],
                      ),
                    );
                  });
            },
            codeAutoRetrievalTimeout: (String verification) {});
      }
    }
  }
}





