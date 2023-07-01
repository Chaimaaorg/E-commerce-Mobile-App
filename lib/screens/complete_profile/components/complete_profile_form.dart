import 'package:Districap/controllers/auth_controller.dart';
import 'package:Districap/screens/sign_up/components/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:Districap/components/custom_surfix_icon.dart';
import 'package:Districap/components/default_button.dart';
import 'package:Districap/components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  CompleteProfileForm({required this.uid});
  final String uid;

  static String verify="" ;
  static String phoneNumber = "";

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState(uid: uid);
}
class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final String uid;

  _CompleteProfileFormState({required this.uid});

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? fullName;
  String? phoneNumber;
  String? address;
  static final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _fullNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  void initState()
  {
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
            buildAddressFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              color: kPrimaryColor,
              text: "continue",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  AuthController().signUpComplete(context,uid,SignUpForm.email,_fullNameController.text.trim(),_phoneController.text,_addressController.text.trim());
                }
              },
            ),
          ],
        ),
      );
    }

    TextFormField buildAddressFormField() {
      return TextFormField(
        controller: _addressController,
        onSaved: (newValue) => address = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          contentPadding: EdgeInsets.only(left:25,top:17,bottom: 20),
          labelText: "Address",
          hintText: "Enter your address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
          CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
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
          labelText: "Last Name",
          hintText: "Enter your last name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      );
    }
  }



