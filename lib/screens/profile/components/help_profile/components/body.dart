import 'dart:async';

import 'package:Districap/components/size_config.dart';
import 'package:Districap/models/Brand.dart';
import 'package:Districap/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../components/image_container.dart';
import '../../../../../components/socal_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brand brand = Brand.Brands[0];
    List<Brand> remainingBrands = Brand.Brands.sublist(1);
    return Theme(
      data: context.watch<ThemeProvider>().themeData,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ListView(padding: EdgeInsets.zero, children: [
          _AboutSection(brand: brand),
          _BrandSection(brands: remainingBrands),
          _ContactSection(),
          _HourSection(),
        ]),
      ),
    );
  }
}


class _BrandSection extends StatefulWidget {
  const _BrandSection({
    Key? key,
    required this.brands,
  }) : super(key: key);

  final List<Brand> brands;

  @override
  _BrandSectionState createState() => _BrandSectionState();
}

class _BrandSectionState extends State<_BrandSection> {
  late ScrollController _scrollController;
  late Timer _scrollTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollTimer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_currentIndex < widget.brands.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollToBrand(_currentIndex);
    });
  }

  @override
  void dispose() {
    _scrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBrand(int index) {
    _scrollController.animateTo(
      index * getProportionateScreenWidth(188),
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Brands',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 140,
            child: ListView.builder(
              controller:_scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.brands.length,
              itemBuilder: (context, index) {
                return Container(
                  width: getProportionateScreenWidth(188),
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                          borderRadius: 0,
                          width: getProportionateScreenWidth(188),
                          imageUrl: widget.brands[index].imageUrl, networkImage: false,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
      height: MediaQuery.of(context).size.height * 0.45,
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
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact us',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              children: [
                Row(
                  children: [
                    SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () async {
                          const url =
                              'https://www.facebook.com/DistricapMaroc/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            // Handle error if the URL can't be opened.
                            print('Could not launch $url');
                          }
                        }),
                    SocalCard(
                        icon: "assets/icons/instagram.svg",
                        press: () async {
                          const url = 'https://www.instagram.com/districap_2/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            // Handle error if the URL can't be opened.
                            print('Could not launch $url');
                          }
                        }),
                    SocalCard(
                        icon: "assets/icons/linkedin.svg",
                        press: () async {
                          const url =
                              'https://www.linkedin.com/in/districap-technologie-26675a140';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            // Handle error if the URL can't be opened.
                            print('Could not launch $url');
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SocalCard(icon: "assets/icons/phoneC.svg", press: () {
                      _launchPhone('+212522341075');
                    }),
                    Center(child: Text("+212 (0) 5 22 34 10 75"))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SocalCard(
                      icon: "assets/icons/phoneC.svg",
                      press: () {
                        _launchPhone('+212522663935');
                      },
                    ),
                    Center(child: Text(" +212 (0) 5 22 66 39 35"))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SocalCard(
                        icon: "assets/icons/printer.svg",
                        press: () {
                          _launchPhone('+212522341075');
                        }),
                    Center(child: Text("+212 (0) 5 22 34 10 71"))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {
                          _sendEmailToCommercial();
                        }),
                    Center(
                        child: GestureDetector(
                            child: Text("commercial@districap.ma"),
                            onTap: () => _sendEmailToCommercial()))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _sendEmailToCommercial() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'commercial@districap.ma',
      queryParameters: {'subject': 'How can we help you?'},
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      print('Could not launch email app');
    }
  }
}

class _HourSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hours',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              children: [
                Row(
                  children: [
                    SocalCard(icon: "assets/icons/calendar.svg", press: () {}),
                    Center(
                        child: Text(
                      "Monday > Friday:\n"
                      "08:30 AM to 12:30 PM \n02:00 PM to 06:30 PM",
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SocalCard(
                      icon: "assets/icons/calendar.svg",
                      press: () {},
                    ),
                    Center(child: Text("Saturday: 08:30 AM to 12:30 PM"))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
