import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../components/size_config.dart';
import '../../../../../constants.dart';
import '../../../../../widgets/settings_widgets/change_password.dart';
import '../../../../../widgets/settings_widgets/custom_pop_up_menu.dart';
import '../../../../../widgets/settings_widgets/custom_pop_up_menu_settings.dart';
import '../../../profile_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isNewForYouToggleOn = true;
  bool _isAccountActivityToggleOn = true;
  bool _isOpportunityToggleOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/User.svg",
                  color: kPrimaryColor,
                  width: 18,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 0.25,
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildAccountOptionRow(
                    context, "Change password", ChangePassword()),
                buildAccountOptionSettings(
                  context,
                  "Content settings",
                ),
                buildAccountOptionPolicy(
                  context,
                  "Privacy and security",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/Bell.svg",
                  color: kPrimaryColor,
                  width: 18,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Notifications",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 0.25,
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNotificationOptionRow("New for you", _isNewForYouToggleOn, (bool newValue) {
                  setState(() {
                    _isNewForYouToggleOn = newValue;
                  });
                }),
                buildNotificationOptionRow("Account activity", _isAccountActivityToggleOn, (bool newValue) {
                  setState(() {
                    _isAccountActivityToggleOn = newValue;
                  });
                }),
                buildNotificationOptionRow("Opportunity", _isOpportunityToggleOn, (bool newValue) {
                  setState(() {
                    _isOpportunityToggleOn = newValue;
                  });
                }),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(56),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white,
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, ProfileScreen.routeName);
                    },
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
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title,bool isActive,ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17.5,
            fontFamily: "Muli",
            fontWeight: FontWeight.w300,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: CupertinoSwitch(
            activeColor: kPrimaryColor,
            value: isActive, // Use the instance variable here
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, Widget myClass) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => myClass));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 17.5,
                fontFamily: "Muli",
                fontWeight: FontWeight.w300,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildAccountOptionPolicy(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17.5,
                fontFamily: "Muli",
                fontWeight: FontWeight.w300,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          const CustomPopupMenu(),
        ],
      ),
    );
  }

  Padding buildAccountOptionSettings(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17.5,
                fontFamily: "Muli",
                fontWeight: FontWeight.w300,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          const CustomPopupMenuSettings(),
        ],
      ),
    );
  }
}
