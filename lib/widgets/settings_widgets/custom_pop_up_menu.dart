import 'package:Districap/widgets/settings_widgets/terms_and_policy.dart';
import 'package:flutter/material.dart';

class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({super.key});

  @override
  _CustomPopupMenuState createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Privacy and policy',
          child: Text('Privacy and policy'),
        ),
        const PopupMenuItem<String>(
          value: 'Terms and conditions',
          child: Text('Terms and conditions'),
        ),
      ],
      onSelected: (value) {
        if (value == 'Privacy and policy') {
          _showDialog1(context);
        } else if (value == 'Terms and conditions') {
          _showDialog2(context);
        }
      },
      child: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    );
  }
  void _showDialog1(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return TermsAndPolicy(
          mdFileName: 'privacy_policy.md',
        );
      },
    );
  }
  void _showDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return TermsAndPolicy(
          mdFileName: 'terms_and_conditions.md',
        );
      },
    );
  }


}