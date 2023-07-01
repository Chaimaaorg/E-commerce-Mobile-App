import 'package:Districap/constants.dart';
import 'package:Districap/screens/seek_info/components/send_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/image_container.dart';
import '../../../components/size_config.dart';
import '../../../models/Brand.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brand brand = Brand.Brands[0];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(padding: EdgeInsets.zero, children: [
        const SizedBox(
          height: 4,
        ),
        _AboutSection(brand: brand),
        const ExpansionSection(),

      ]),
    );
  }
}


class _AboutSection extends StatelessWidget {
  const _AboutSection({
    Key? key,
    required this.brand,
  }) : super(key: key);

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: getProportionateScreenHeight(330),
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      imageUrl: brand.imageUrl,
      networkImage: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: getProportionateScreenHeight(90),
            width: getProportionateScreenWidth(90),
          ),
          const SizedBox(height: 10),
          Text(
            'DISTRICAP is a Moroccan company distributing low-current equipment, leading the import and distribution of electronic security solutions for professionals and businesses in Morocco. Exclusive distributor of NF and NE certified FINSECUR products, prioritizing quality and technological advancements.',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () async {
              const url = 'https://districap.net/societe-districap.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                // Handle error if the URL can't be opened.
                print('Could not launch $url');
              }
            },
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Row(
              children: [
                Text(
                  'Learn More',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.mytext,
    required this.routeName,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  String mytext;
  String routeName;
  bool isExpanded;
}

class ExpansionSection extends StatefulWidget {
  const ExpansionSection({Key? key}) : super(key: key);

  @override
  State<ExpansionSection> createState() => _ExpansionSectionState();
}

class _ExpansionSectionState extends State<ExpansionSection> {
  final List<Item> _data = [
    Item(
      expandedValue: "Can't find the information you need?",
      headerValue: "Ask a question",
      mytext: 'Ask any questions you have or seek further information about any product to ensure a delightful shopping experience.',
      routeName: SendMessageScreen.routeName, // Replace with actual route name
    ),
    Item(
      expandedValue: "Your feedback is highly appreciated",
      headerValue: "Rate a product",
      mytext: 'Please take a moment to share your rating and review for the product.',
      routeName: SendMessageScreen.routeName, // Replace with actual route name
    ),
    Item(
      expandedValue: "Request additional information",
      headerValue: "Seek for further information",
      mytext: "Seek further information about any product to ensure a delightful shopping experience.",
      routeName: SendMessageScreen.routeName, // Replace with actual route name
    ),
    // ... other items
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(5, 5), // shadow 1 to the right &  5 to the bottom
                ),
              ],
            ),
            // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: _buildPanel(),
          ),
          SizedBox(height: 25,),
          SizedBox(
            width: getProportionateScreenWidth(200),
            height: getProportionateScreenHeight(58),
            child: TextButton(
              style: TextButton.styleFrom(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                primary: Colors.white,
                backgroundColor: bluePanel,
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, SendMessageScreen.routeName),
              child: Text(
                "Let's get started !",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValue,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          body: Container(
            color: bluePanel.withOpacity(0.1),
            height: 115,
            child: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text(item.mytext),
              // trailing: Icon(Icons.double_arrow),
              // onTap: () => Navigator.pushReplacementNamed(context, item.routeName)
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}


