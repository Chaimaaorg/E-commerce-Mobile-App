import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/sign_in_provider.dart';
import '../../../providers/theme_provider.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: sp.getProfileImageProvider(),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color:  context
                        .watch<ThemeProvider>()
                        .themeData.scaffoldBackgroundColor == Colors.grey.shade900 ? Color(0xFF424242) :Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: context
                      .watch<ThemeProvider>()
                      .themeData.scaffoldBackgroundColor == Colors.grey.shade900 ? Color(0xFF424242) :Color(0xFFF5F6F9),
                ),
                onPressed: () async {
                  File? pickedImage = await sp.pickImage();
                  if (pickedImage != null) {
                    // Update the pickedImage in the SignInProvider
                    sp.updatePickedImage(pickedImage);
                  }
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
