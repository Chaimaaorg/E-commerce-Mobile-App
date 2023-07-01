import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Districap/screens/home/components/body.dart';
import 'package:Districap/size_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../models/Cart.dart';
import '../../providers/cart_provider.dart';
import '../../services/noti.dart';
import '../../theme.dart';
import '../../widgets/coustom_bottom_nav_bar.dart';
import '../../widgets/custom_drawer.dart';
import '../../enums.dart';
import '../../providers/sign_in_provider.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future getData() async {
    final sp = context.read<SignInProvider>();
    User? user = FirebaseAuth.instance.currentUser;
    sp.getUserDataFromFirestore(user?.uid);
  }

  @override
  void initState() {
    super.initState();
    getData();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.removeExpiredItems(); // This will remove expired items if any
    List<Cart> cartItems = cartProvider.cartItems;
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context,cartItems.length,Noti.notificationCounter),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
      drawer: CustomDrawer(title: "My menu"),
    );
  }
}
