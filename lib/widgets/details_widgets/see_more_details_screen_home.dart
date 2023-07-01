import 'dart:async';
import 'package:Districap/components/default_button.dart';
import 'package:Districap/constants.dart';
import 'package:Districap/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../../../../../../components/image_container.dart';
import '../../../../../../../components/size_config.dart';
import '../../../../../../../enums.dart';
import '../../../../../../../widgets/coustom_bottom_nav_bar.dart';
import '../home_widgets/icon_btn_with_counter.dart';

class SeeMoreDetailsScreenHome extends StatelessWidget {
  SeeMoreDetailsScreenHome({Key? key}) : super(key: key);
  static String routeName = '/discover';
  static String? _description, _features, _brand,_reference,_id,_linkVideo,_image;

  @override
  Widget build(BuildContext context) {
    final Product? args = ModalRoute.of(context)!.settings.arguments as Product;
    _description = args!.description;
    _image = args!.images[0];
    _brand =args.brand;
    _reference = args.reference;
    _features = args.features;
    _linkVideo= args.linkVideo;
    _id = args.id;
    List<String> tabs = ['Description', 'Features', 'Technical file', 'Video'];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        bottomNavigationBar:
        const CustomBottomNavBar(selectedMenu: MenuState.home, height: 56.0),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: _productPic(),
            ),
            Expanded(
              child: _ListOfTabs(tabs: tabs),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListOfTabs extends StatefulWidget {
  const _ListOfTabs({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabs;

  @override
  _ListOfTabsState createState() => _ListOfTabsState();
}

class _ListOfTabsState extends State<_ListOfTabs> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.black,
            tabs: widget.tabs
                .map(
                  (tab) => Tab(
                icon: Text(
                  tab,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
                .toList(),
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                _DescriptionTab(description: SeeMoreDetailsScreenHome._description, brand: SeeMoreDetailsScreenHome._brand, reference: SeeMoreDetailsScreenHome._reference,),
                _FeaturesTab(features: SeeMoreDetailsScreenHome._features),
                _TechnicalFileTab(pdfPath: 'pdfs/${SeeMoreDetailsScreenHome._id}/fichetechnique.pdf'),
                _VideoTab(videoId: getVideoIdFromUrl(SeeMoreDetailsScreenHome._linkVideo!), currentIndex: _selectedTabIndex,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionTab extends StatelessWidget {
  const _DescriptionTab({
    Key? key,
    required this.description, required this.brand, required this.reference,
  }) : super(key: key);
  final String? brand,reference;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLettrine(description)),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
          _buildCheckItem('Reference:', reference),
          _buildCheckItem('Brand:', brand),
          _buildCheckItem('Availability:', 'Within the limits of available stock'),
          _buildCheckItem('Delivery:', 'delivered within 2 to 5 working days'),
        ],
      ),
    );
  }

  Widget _buildLettrine(String? text) {
    if (text == null || text.isEmpty) return Container();

    final String lettrine = text[0];
    final String restOfText = text.substring(1);

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 36,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(text: lettrine),
          TextSpan(
            text: restOfText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.normal,
              fontFamily: "Muli",
            ),
          ),
        ],
      ),
      textAlign: TextAlign.justify, // Set the textAlign property here
    );
  }

  Widget _buildCheckItem(String title, String? content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
            size: 18,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  content!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _FeaturesTab extends StatelessWidget {
  const _FeaturesTab({
    Key? key,
    required this.features,
  }) : super(key: key);

  final String? features;

  @override
  Widget build(BuildContext context) {
    if (features == null) {
      return Center(child: Text('No features available'));
    }

    // Replace '\n' with actual line breaks
    final formattedFeatures = features!.replaceAll('\\n', '\n');

    // Split the features string into separate lines
    final featureLines =
    formattedFeatures.split('\n').map((line) => line.trim()).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var feature in featureLines)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}



class _TechnicalFileTab extends StatelessWidget {
  const _TechnicalFileTab({
    Key? key,
    required this.pdfPath,
  }) : super(key: key);

  final String? pdfPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:50),
        child: Column(
          children: [
            Text("Click here",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Icon(Icons.keyboard_double_arrow_down_sharp,color: kTextColor,size:35,),
            const SizedBox(height: 10,),
            Container(
              width: getProportionateScreenWidth(200),
              child: DefaultButton(
                press: () => _viewPdf(context),
                text: 'View Technical File',
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _viewPdf(BuildContext context) async {
    if (pdfPath == null || pdfPath!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No technical file available')),
      );
      return;
    }

    final pdfUrl = await _getPdfUrlFromStorage();

    if (pdfUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get the PDF URL')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _PdfViewerScreen(pdfUrl:pdfUrl),
      ),
    );
  }

  Future<String?> _getPdfUrlFromStorage() async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(pdfPath!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting PDF URL from Firebase Storage: $e');
      return null;
    }
  }
}
class _PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  _PdfViewerScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(padding: EdgeInsets.only(left: 70),child: Text('Technical File')),
      ),
      body: PDF(
        swipeHorizontal: true,
      ).cachedFromUrl(pdfUrl),
    );
  }
}


class _VideoTab extends StatefulWidget {
  final String videoId;
  final int currentIndex;

  _VideoTab({required this.videoId, required this.currentIndex});

  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<_VideoTab> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false, // Set autoPlay to false initially
        mute: false,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _VideoTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the currentIndex is the same as the widget's index
    // If it is, play the video, otherwise, pause it.
    if (widget.currentIndex == 3) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          progressColors: ProgressBarColors(
            playedColor: Colors.blueAccent,
            handleColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
class _productPic extends StatelessWidget {
  const _productPic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.30,
      width: double.infinity,
      padding: const EdgeInsets.only(
          top: 0.0, left: 20.0, right: 20.0, bottom: 20.0),
      imageUrl: SeeMoreDetailsScreenHome._image ?? "https://th.bing.com/th/id/OIP.ODF68Yqk4FnO3-Kcbie-3AHaFl?pid=ImgDet&rs=1",
      networkImage: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: getProportionateScreenHeight(90),
            width: getProportionateScreenWidth(90),
          ),
        ],
      ),
    );
  }
}

String getVideoIdFromUrl(String url) {
  if (url.isEmpty) return '';

  // Check if the URL starts with 'https://www.youtube.com/watch?v='
  if (url.startsWith('https://www.youtube.com/watch?v=')) {
    // Extract the videoId from the URL
    return url.substring('https://www.youtube.com/watch?v='.length);
  }

  // If the URL starts with 'https://youtu.be/', extract the videoId accordingly
  if (url.startsWith('https://youtu.be/')) {
    return url.substring('https://youtu.be/'.length);
  }

  // If the URL is not in a recognized format, return an empty string
  return '';
}

