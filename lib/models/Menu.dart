import 'package:flutter/material.dart';

class Menu {
  int level = 0;
  IconData icon = Icons.drive_file_rename_outline;
  String title = "";
  String logo ="assets/images/menuLogo.png";
  // List<Menu> children = [];
  // Default constructor
  Menu(this.level, this.logo,this.icon, this.title);

  // One method for JSON data
  Menu.fromJson(Map<String, dynamic> json) {
    // Level
    if (json["level"] != null) {
      level = json["level"];
    }
    if(json['logo']!=null){
      logo = json['logo'];
    }
    // Icon
    if (json["icon"] != null) {
      icon = json["icon"];
    }
    // Title
    title = json['title'];
    // Children
    // if (json['children'] != null) {
    //   children.clear();
    //   // For each entry from json children add to the Node children
    //   json['children'].forEach((v) {
    //     children.add(Menu.fromJson(v));
    //   });
    // }
  }
}
