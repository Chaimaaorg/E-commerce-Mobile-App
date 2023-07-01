import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class CustomPopupMenuSettings extends StatefulWidget {
  const CustomPopupMenuSettings({super.key});

  @override
  _CustomPopupMenuSettingsState createState() => _CustomPopupMenuSettingsState();
}

class _CustomPopupMenuSettingsState extends State<CustomPopupMenuSettings> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Light Mode',
          child: Text('Light Mode'),
        ),
        const PopupMenuItem<String>(
          value: 'Dark Mode',
          child: Text('Dark Mode'),
        ),
      ],
      onSelected: (value) {
        _updateThemeMode(value);

      },
      child: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    );
  }
  void _updateThemeMode(String value) {
    final themeProvider = context.read<ThemeProvider>();

    if (value == 'Dark Mode') {
      themeProvider.updateThemeMode(
        ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade900,
          primaryColor: Colors.black,
          colorScheme: const ColorScheme.dark(),
          iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
        ),
      );
    } else {
      themeProvider.updateThemeMode(
        ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white,
          colorScheme: const ColorScheme.light(),
          iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
        ),
      );
    }
  }

}