import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Message.dart';

class MessageStorage{

  Future<void> saveMessagesToSharedPreferences(List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = messages.map((message) => message.toJson()).toList();
    await prefs.setString('messages', jsonEncode(messagesJson));
  }

  Future<List<Message>> getMessagesFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getString('messages');
    if (messagesJson != null) {
      final messagesList = jsonDecode(messagesJson) as List<dynamic>;
      return messagesList.map((json) => Message.fromJson(json)).toList();
    }
    return [];
  }
}