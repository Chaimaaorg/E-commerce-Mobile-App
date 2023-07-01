import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/Menu.dart';
import '../screens/category/category_screen.dart';
import '../size_config.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<Menu> data = [];

  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      width: getProportionateScreenWidth(290),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(35),
        ),
        child: Drawer(
          backgroundColor: Color(0xFFfee6ea),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 0),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _buildDrawerHeader(context, data[index]);
              }
              return _buildMenuList(data[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1,
              thickness: 2,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildDrawerHeader(BuildContext context, Menu headItem) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 3,
    ),
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Image.asset(
            headItem.logo,
            height: 100,
            width: 190, // Adjust the height as needed
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context); // Close the drawer
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
            size: 30,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMenuList(Menu menuItem) {
  double lp = 0; // left padding
  double fontSize = 20;
  if (menuItem.level == 1) {
    lp = 20;
    fontSize = 16;
  }
  if (menuItem.level == 2) {
    lp = 30;
    fontSize = 14;
  }
  return Builder(
    builder: (context) => Padding(
      padding: EdgeInsets.only(left: lp),
      child: GestureDetector(
        onTap: () {
          // Close the drawer
          Navigator.pop(context);
          // Then navigate to the corresponding screen based on the menuItem
          Navigator.pushNamed(context, CategoryScreen.routeName, arguments: menuItem.title);
        },
        child: ListTile(
          leading: Icon(menuItem.icon),
          title: Text(
            menuItem.title,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: "Mulish",
              color: kTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    ),
  );
}



// Menu data list
List dataList = [
  // Menu data item
  {
    "level": 0,
    "icon": Icons.category_outlined,
    "title": "Categories",
  },
  //A/V distributor
  {
    "level": 0,
    "icon": Icons.developer_board,
    "title": "A/V distributor",
    // "children": [
    //   {"level": 1, "icon": Icons.developer_board, "title": "A/V Matrix"},
    //   {
    //     "level": 1,
    //     "icon": Icons.horizontal_distribute_outlined,
    //     "title": "Splitter / distibutor"
    //   },
    //   {"level": 1, "icon": Icons.devices, "title": "Switch"},
    //   {"level": 1, "icon": Icons.extension, "title": "Extender"},
    //   {"level": 1, "icon": Icons.control_camera, "title": "Control system"},
    //   {
    //     "level": 1,
    //     "icon": Icons.important_devices,
    //     "title": "Video converter/Adaptators"
    //   },
    // ]
  },
  //Video projection
  {
    "level": 0,
    "icon": Icons.video_camera_front_outlined,
    "title": "Video projection",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.video_camera_back_outlined,
    //     "title": "Projectors"
    //   },
    //   {"level": 1, "icon": Icons.video_label, "title": "Projection screens"},
    //   {"level": 1, "icon": Icons.tv, "title": "Projector mounts"},
    //   {
    //     "level": 1,
    //     "icon": Icons.delete_forever,
    //     "title": "Wireless projection system"
    //   },
    //   {"level": 1, "icon": Icons.delete_forever, "title": "Doctuments viewers"},
    //   {"level": 1, "icon": Icons.hourglass_empty, "title": "3D glasses"},
    // ]
  },
  //Interactive display
  {
    "level": 0,
    "icon": Icons.screenshot_monitor,
    "title": "Interactive display",
    // "children": [
    //   {"level": 1, "icon": Icons.tv, "title": "Interactive screens"},
    //   {
    //     "level": 1,
    //     "icon": Icons.video_label_rounded,
    //     "title": "interactive whiteboards"
    //   },
    // ]
  },
  //Streaming
  {
    "level": 0,
    "icon": Icons.stream_rounded,
    "title": "Streaming",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.streetview,
    //     "title": "Capture and streaming systems"
    //   },
    //   {"level": 1, "icon": Icons.devices_other, "title": "A/V mixers"},
    // ]
  },
  //KVM
  {
    "level": 0,
    "icon": Icons.devices,
    "title": "KVM",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.switch_access_shortcut_add_outlined,
    //     "title": "KVM Switch"
    //   },
    //   {"level": 1, "icon": Icons.cable, "title": "KVM Cables"},
    //   {
    //     "level": 1,
    //     "icon": Icons.switch_camera_outlined,
    //     "title": "KVM Extender"
    //   },
    //   {"level": 1, "icon": Icons.cable_rounded, "title": "KVM Accessories"},
    // ]
  },
  //Video conference
  {
    "level": 0,
    "icon": Icons.video_camera_front_outlined,
    "title": "Video conference",
    // "children": [
    //   {"level": 1, "icon": Icons.camera, "title": "Pro Webcams"},
    //   {
    //     "level": 1,
    //     "icon": Icons.video_camera_front,
    //     "title": "Video Conference Cameras"
    //   },
    //   {"level": 1, "icon": Icons.camera_alt_outlined, "title": "Camera mounts"},
    // ]
  },
  //Sono
  {
    "level": 0,
    "icon": Icons.surround_sound,
    "title": "Sonorisation",
    // "children": [
    //   {"level": 1, "icon": Icons.speaker_phone, "title": "Speakers"},
    //   {"level": 1, "icon": Icons.surround_sound, "title": "Mixers"},
    //   {"level": 1, "icon": Icons.mic, "title": "Wired microphones"},
    //   {"level": 1, "icon": Icons.mic, "title": "Wireless microphones"},
    //   {
    //     "level": 1,
    //     "icon": Icons.amp_stories_outlined,
    //     "title": "Mixers/Amplifiers"
    //   },
    //   {"level": 1, "icon": Icons.podcasts, "title": "Sono Accessories"},
    // ]
  },

  // Audio Conferencing
  {
    "level": 0,
    "icon": Icons.spatial_audio,
    "title": "Audio Conferencing",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.nest_cam_wired_stand,
    //     "title": "Wired conferencing system"
    //   },
    //   {"level": 1, "icon": Icons.wifi, "title": "Wireless conferencing system"},
    //   {
    //     "level": 1,
    //     "icon": Icons.settings_system_daydream,
    //     "title": "Multimedia conferencing system"
    //   },
    // ]
  },

  // Video surveillance
  {
    "level": 0,
    "icon": Icons.video_camera_back,
    "title": "Video surveillance",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.switch_access_shortcut,
    //     "title": "Switch",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.credit_card,
    //     "title": "Hard disk",
    //   },
    //   {"level": 1, "icon": Icons.camera, "title": "Analog camera"},
    //   {"level": 1, "icon": Icons.camera_alt, "title": "IP Camera"},
    //   {"level": 1, "icon": Icons.network_cell, "title": "NVR"}
    // ]
  },

  // Cable distribution
  {
    "level": 0,
    "icon": Icons.cable_sharp,
    "title": "Cable distribution",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.electric_bolt,
    //     "title": "Alimentation",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.view_module,
    //     "title": "Transmodulator / Modulator",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.lens_blur,
    //     "title": "Antennas /LNB",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.amp_stories,
    //     "title": "Preamp / Amplifiers",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.tv_outlined,
    //     "title": "Diversion / Dispatchers",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.switch_access_shortcut,
    //     "title": "Multi-switch",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.cable,
    //     "title": "TV Cables",
    //   },
    // ]
  },

  // Gaming
  {
    "level": 0,
    "icon": Icons.games,
    "title": "Gaming",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.mouse,
    //     "title": "Mouses",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.padding,
    //     "title": "Mouses pad",
    //   },
    //   {"level": 1, "icon": Icons.keyboard, "title": "Keyboard"},
    //   {"level": 1, "icon": Icons.monitor, "title": "Monitor"},
    //   {"level": 1, "icon": Icons.headphones, "title": "Headphones"}
    // ]
  },

  // Pre-cabling & IT
  {
    "level": 0,
    "icon": Icons.cable_sharp,
    "title": "Pre-cabling & IT",
    // "children": [
    //   {
    //     "level": 1,
    //     "icon": Icons.cable,
    //     "title": "Computer pre-cabling ",
    //   },
    //   {
    //     "level": 1,
    //     "icon": Icons.inventory,
    //     "title": "Power inverter",
    //   },
    // ]
  },
  // Accessories
  {
    "level": 0,
    "icon": Icons.headphones_outlined,
    "title": "Accessories",
    // "children": [
    //   {"level": 1, "icon": Icons.headphones, "title": "Headphones"},
    //   {
    //     "level": 1,
    //     "icon": Icons.receipt,
    //     "title": "Multiport receiving stations"
    //   },
    //   {"level": 1, "icon": Icons.cable_sharp, "title": "Video cables"},
    //   {"level": 1, "icon": Icons.audio_file, "title": "Audio cables"},
    //   {"level": 1, "icon": Icons.bolt, "title": "Floor box"},
    //   {
    //     "level": 1,
    //     "icon": Icons.speaker_phone_sharp,
    //     "title": "Speakers cables"
    //   },
    //   {"level": 1, "icon": Icons.audio_file, "title": "Connectors / Sockets"},
    //   {"level": 1, "icon": Icons.support_rounded, "title": "Mounts"},
    // ]
  },
];
