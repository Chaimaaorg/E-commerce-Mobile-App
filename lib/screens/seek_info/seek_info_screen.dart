import 'package:Districap/screens/home/home_screen.dart';
import 'package:Districap/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../components/size_config.dart';
import '../../enums.dart';
import '../../models/Cart.dart';
import '../../providers/cart_provider.dart';
import '../../services/noti.dart';
import '../../widgets/coustom_bottom_nav_bar.dart';
import 'package:Districap/screens/seek_info/components/body.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class SeekInfoScreen extends StatefulWidget {
  static String routeName = "/supp-info";

  const SeekInfoScreen({super.key});
  @override
  State<SeekInfoScreen> createState() => _SeekInfoScreenState();
}

class _SeekInfoScreenState extends State<SeekInfoScreen> {
  @override
  void initState()
  {
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.removeExpiredItems();
    List<Cart> cartItems = cartProvider.cartItems;
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBarChat(context, cartItems.length,HomeScreen.routeName,Noti.notificationCounter),
      body: const Body(),
      bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: MenuState.message,
        height: 63.0,
      ),
    );
  }
}


