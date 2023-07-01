import 'package:Districap/constants.dart';
import 'package:Districap/data/message_storage.dart';
import 'package:Districap/screens/seek_info/seek_info_screen.dart';
import 'package:Districap/services/noti.dart';
import 'package:Districap/theme.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/size_config.dart';
import '../../../models/Cart.dart';
import '../../../models/Message.dart';
import '../../../providers/cart_provider.dart';

class SendMessageScreen extends StatefulWidget {
  static String routeName = "/send-message";

  const SendMessageScreen({Key? key}) : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  @override
  void initState() {
    super.initState();
    MessageStorage().getMessagesFromSharedPreferences().then((storedMessages) {
      if (storedMessages.isNotEmpty) {
        setState(() {
          messages = [...storedMessages];
        });
      } else {
        setState(() {
          messages = defaultMessages;
        });
      }
    });
  }

  List<Message> defaultMessages = [
    Message(
      text: 'Start a new conversation!',
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentMe: false,
    ),
    Message(
      text: 'Seek further information about any product to ensure a delightful shopping experience!',
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentMe: false,
    ),
  ].reversed.toList();
  List<Message> messages = [];

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.removeExpiredItems();
    List<Cart> cartItems = cartProvider.cartItems;
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBarChat(context, cartItems.length,SeekInfoScreen.routeName,Noti.notificationCounter),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
                padding: const EdgeInsets.all(8),
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                elements: messages,
                groupBy: (message) => DateTime(
                      message.date.year,
                      message.date.month,
                      message.date.day,
                    ),
                groupHeaderBuilder: (Message message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: Colors.black45,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.date),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                itemBuilder: (context, Message message) => Align(
                      alignment: message.isSentMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        elevation: 0,
                        child: message.isSentMe ? TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            primary: Colors.white,
                            backgroundColor: bluePanel,
                          ),
                          onPressed: () {},
                          child: Text(
                            message.text,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color:
                                  Colors.white
                            ),
                          ),
                        ) :
                        SingleChildScrollView(
                          child: Container(
                            width: getProportionateScreenWidth(270),
                            decoration: BoxDecoration(
                              color: Colors.white, // bg color
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(1, 5), // shadow 1 to the right &  5 to the bottom
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                                primary: Colors.white,
                                backgroundColor: Colors.white,
                              ), onPressed: () {  }, child: Text(
                              message.text,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color:
                                  Colors.black
                              ),
                            ),
                            ),
                          ),
                        )),
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Couleur de l'arrière-plan du Container
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(1, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    final message = _textEditingController.text;

                    final whatsappUrl = "https://wa.me/212641974324?text=$message";
                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                      print("Could not launch WhatsApp");
                      return;
                    }
                    final newMessage = Message(
                      text: message,
                      isSentMe: true,
                      date: DateTime.now(),
                    );
                    setState(() {
                      messages.add(newMessage);
                      _textEditingController.clear();
                    });
                    // Save the new message to SharedPreferences
                    MessageStorage().saveMessagesToSharedPreferences(messages);

                    // Delay and add the auto-reply after one minute
                    Future.delayed(Duration(milliseconds: 15000), () async {
                      final autoReply = Message(
                        text: "Thank you for your message! We'll get back to you soon.",
                        isSentMe: false,
                        date: DateTime.now(),
                      );
                      setState(() {
                        messages.add(autoReply);
                      });
                      MessageStorage().saveMessagesToSharedPreferences(messages);
                    });
                  },
                  icon: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                    height: getProportionateScreenWidth(50),
                    width: getProportionateScreenWidth(50),
                    decoration: BoxDecoration(
                      color: bluePanel,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
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