import 'package:Districap/components/size_config.dart';
import 'package:Districap/constants.dart';
import 'package:Districap/models/User.dart' as MyUser;
import 'package:Districap/screens/profile/components/edit_profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../components/default_button.dart';
import '../../../../../providers/sign_in_provider.dart';
import '../../../profile_screen.dart';
import '../../profile_pic.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {

  final _formKey = GlobalKey<FormState>();
  // Declare TextEditingController for each text field
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final sp = context.read<SignInProvider>();
    // Fetch data from Firebase before building the UI
    sp.getUserDataFromFirestore(sp.uid);
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    // Initialize the text field controllers with provider data
    _nameController.text = sp.name ?? "";
    _emailController.text = sp.email ?? "";
    _phoneNumberController.text = sp.phoneNumber ?? "";
    _addressController.text = sp.address ?? "";
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, top: 0, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 15),
              ProfilePic(),
                SizedBox(height: getProportionateScreenHeight(35)),
                buildTextField("Full Name", sp.name ?? "Add your name", 'assets/icons/User.svg',_nameController),
                buildTextField("E-mail", sp.email ?? "Add your email", 'assets/icons/Mail.svg',_emailController),
                buildTextField("Phone", sp.phoneNumber ?? "Add your phone number", 'assets/icons/Phone.svg',_phoneNumberController),
                buildTextField("Location", sp.address ?? "Add your address", 'assets/icons/Location point.svg', _addressController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: getProportionateScreenWidth(170),
                      height: getProportionateScreenWidth(42),
                      child: SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(56),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: (){Navigator.pushReplacementNamed(context, ProfileScreen.routeName);},
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: getProportionateScreenWidth(170),
                      height: getProportionateScreenWidth(42),
                      child: DefaultButton(
                        text: "Save",
                        color: kPrimaryColor,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _onSavePressed(sp);
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSavePressed(SignInProvider sp) async {
    MyUser.User updatedUser = MyUser.User(
      fullName: _nameController.text,
      email: _emailController.text,
      phone: _phoneNumberController.text,
      address: _addressController.text,
      // Set other fields if needed
    );

    await sp.updateUserProfile(updatedUser,context,EditProfileScreen.routeName);


    // Show a success message or perform any other actions after a successful update.
  }







  Widget buildTextField(String labelText, String placeholder, String linkSvg,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(36),
            ),
            suffixIcon: (IconButton(
              icon: SvgPicture.asset(linkSvg),
              color: Colors.grey,
              onPressed: () {},
            )),
            contentPadding: EdgeInsets.only(left: 25,top:17,bottom: 17),
            labelText: labelText,
            labelStyle: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.normal),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            )),
      ),
    );
  }
}