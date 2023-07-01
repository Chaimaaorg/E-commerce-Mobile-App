import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../google_maps/google_maps_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../components/size_config.dart';
import '../../components/utils.dart';
import '../../constants.dart';
import '../../controllers/cart_controller.dart';
import '../../enums.dart';
import '../../models/Cart.dart';
import '../../models/CartDetailsArguments.dart';

import '../../providers/sign_in_provider.dart';
import '../../theme.dart';
import '../../widgets/coustom_bottom_nav_bar.dart';
import '../cart/cart_screen.dart';
import 'components/error_screen.dart';
import 'components/order_summary.dart';
import '../../models/Order.dart' as MyOrder;
import 'package:Districap/models/User.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'components/success_screen.dart';

class CheckOutScreen extends StatefulWidget {
  static String routeName = '/checkout';

  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final CartController _cartController = CartController();

  Future<void> _selectAddress(
      BuildContext context, TextEditingController addressController) async {
    final String address = addressController.text;

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle permission denied scenario
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Location Permission Denied"),
          content: Text(
              "You have denied location permission. Please enter your address manually."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    // Permission granted or restricted, proceed with getting the location
    LatLng selectedLatLng;
    if (address.isNotEmpty) {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        selectedLatLng = LatLng(location.latitude, location.longitude);
      } else {
        Position currentPosition = await _getCurrentPosition();
        selectedLatLng =
            LatLng(currentPosition.latitude, currentPosition.longitude);
      }
    } else {
      Position currentPosition = await _getCurrentPosition();
      selectedLatLng =
          LatLng(currentPosition.latitude, currentPosition.longitude);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoogleMapsScreen(
            selectedLatLng: selectedLatLng,
            addressController: addressController),
      ),
    );
  }

  Future<Position> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<String> addNewOrderToFirestore(
      MyOrder.Order order, SignInProvider sp) async {
    try {
      try {
        MyUser.User updatedUser = MyUser.User(
          fullName: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          address: addressController.text,
          company: companyController.text,
          ice: iceController.text,
          // Set other fields if needed
        );
        await sp.updateUserProfile(
            updatedUser, context, SuccessScreen.routeName);
      } catch (e) {
        Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
        print("Error updating adding the user's info! $e");
      }
      DocumentReference orderRef = await FirebaseFirestore.instance
          .collection('Orders')
          .add(order.toJson());
      String orderId = orderRef.id;
      print('Order added to Firestore. Order ID: $orderId');
      Navigator.pushReplacementNamed(context, SuccessScreen.routeName);
      return orderId;
    } catch (e) {
      Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
      print('Error adding order to Firestore: $e');
      return '';
    }
  }

  Future<void> _saveOrderProcess(SignInProvider sp) async {
    final String orderId;
    final args =
        ModalRoute.of(context)!.settings.arguments as CartDetailsArguments;
    double total = args.total;

    // Create a copy of cartItems before modifying the original list
    List<Cart> cartItemsCopy = List.from(args.cartItems);

    Map<String, dynamic> prodQte = {};
    for (var cartItem in cartItemsCopy) {
      prodQte["PQ${cartItem.product.id}"] = {
        'prodId': cartItem.product.id,
        'qty': cartItem.numOfItem,
      };

      // Fetch current availability
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .doc(cartItem.product.id)
          .get();

      int currentAvailability = productSnapshot['availability'];
      int updatedAvailability = currentAvailability - cartItem.numOfItem;

      // Update product availability
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(cartItem.product.id)
          .update({'availability': updatedAvailability});
    }

    // Add a new order entry
    MyOrder.Order newOrder = MyOrder.Order(
      uid: FirebaseAuth.instance.currentUser!.uid,
      status: 'pending',
      prodQte: prodQte,
      amount: total + 53.0,
      creationDate: DateTime.now(),
    );

    try {
      orderId = await addNewOrderToFirestore(newOrder, sp);
      // Send the email with PDF attachment
      await sendPdfAsEmail(
          context,
          CartDetailsArguments(cartItems: cartItemsCopy, total: args.total),
          orderId);
      // Clear the cart or perform any other necessary actions
      for (var cartItem in cartItemsCopy) {
        _cartController.removeFromCart(cartItem, context);
      }
    } catch (e) {
      print('Error adding order to Firestore or in email sending: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();

  // Declare TextEditingController for each text field
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController iceController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final sp = context.read<SignInProvider>();
    // Fetch data from Firebase before building the UI
    sp.getUserDataFromFirestore(sp.uid);
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    // Initialize the text field controllers with provider data
    emailController.text = sp.email ?? "";
    nameController.text = sp.name ?? "";
    phoneController.text = sp.phoneNumber ?? "";
    addressController.text = sp.address ?? "";
    companyController.text = sp.company ?? "";
    iceController.text = sp.ice ?? "";
    final CartDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as CartDetailsArguments;
    double? total = args.total;
    return Scaffold(
      appBar: buildAverageAppBar(context, CartScreen.routeName),
      bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: MenuState.cart,
      ),
      body: SingleChildScrollView(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 6.0, right: 20.0, left: 15.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CUSTOMER INFORMATION',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: bluePanel),
              ),
              _buildTextFormField(emailController, context, 'Email'),
              _buildTextFormField(nameController, context, 'Full Name'),
              _buildPhoneFormField(phoneController, context, 'Phone'),
              _buildTextFormField(companyController, context, 'Company'),
              _buildTextFormField(iceController, context, 'ICE'),
              const SizedBox(height: 10),
              Text(
                'DELIVERY INFORMATION',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: bluePanel),
              ),
              _buildAddressFormField(addressController, context, 'Address'),
              const SizedBox(height: 20),
              Text(
                'ORDER SUMMARY',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: bluePanel),
              ),
              OrderSummary(total: total),
              Padding(
                padding: const EdgeInsets.only(top: 7, left: 170),
                child: GestureDetector(
                  onTap: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: 'Are you sure you want to place this order?',
                      confirmBtnText: 'Yes',
                      onConfirmBtnTap:()=> _saveOrderProcess(sp),
                      cancelBtnText: 'No',
                      confirmBtnColor: const Color(0xFF32cdbb),
                      backgroundColor: Colors.white,
                      confirmBtnTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      titleColor: Colors.black,
                      textColor: Colors.black,
                    );
                  },
                  child: Row(
                    children: [
                      Text("CONTINUE",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFdd0729),
                                  fontSize: 18)),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    TextEditingController controller,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, right: 5.0, bottom: 10.0, left: 1),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                // labelText: labelText,
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildPhoneFormField(TextEditingController controller,
      BuildContext context, String labelText) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
      child: Column(
        // Use a Column to provide constraints
        children: [
          Row(
            children: [
              SizedBox(
                width: 75,
                child: Text(
                  labelText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 10),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    primary: Colors.white,
                    backgroundColor: kPrimaryColor,
                  ),
                  onPressed: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      text: 'Please double-check the provided phone number!',
                      backgroundColor: Colors.white,
                      confirmBtnColor: Color(0xFF007d81),
                      confirmBtnTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      titleColor: Colors.black,
                      textColor: Colors.black,
                    );
                  },
                  child: Text("Verify",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white)),
                ),
              ),
              // Additional text as needed
            ],
          ),
        ],
      ),
    );
  }

  _buildAddressFormField(
    TextEditingController controller,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, right: 5.0, bottom: 5.0, left: 1),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height: getProportionateScreenHeight(40),
            width: getProportionateScreenWidth(40),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                primary: Colors.white,
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () {
                _selectAddress(context, controller);
              },
              child: SvgPicture.asset(
                "assets/icons/Search Icon.svg",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
