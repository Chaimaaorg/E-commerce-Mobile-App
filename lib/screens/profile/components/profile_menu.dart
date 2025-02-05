import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../providers/theme_provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press, required this.notif,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;
  final bool notif;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: context
              .watch<ThemeProvider>()
              .themeData.scaffoldBackgroundColor == Colors.grey.shade900 ? Color(0xFF424242) : Color(0xFFF5F6F9)
        ),
        onPressed: press,
        child: Row(
          children: [
            notif
                ? SvgPicture.asset(
                    icon,
                    color: kPrimaryColor,
                    width: 18,
                  )
                : SvgPicture.asset(
                    icon,
                    color: kPrimaryColor,
                    width: 22,
                  ),
            SizedBox(width: 20),
            Expanded(child: Text(text,style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 16),)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
