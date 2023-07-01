import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  static DateTime? lastNotificationTime; // Store the timestamp of the last notification
  static int notificationCounter = 0; // Initialize the notification counter

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('mipmap/logo');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);

    Stream<QuerySnapshot<Map<String, dynamic>>> notificationsStream =
    FirebaseFirestore.instance.collection("Promotions").snapshots();

    notificationsStream.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }
      // Iterate through the documents and check if any new items are added
      for (var doc in event.docs) {
        Timestamp itemTimestamp = doc.get('startDate') as Timestamp; // Change this to your field name

        DateTime itemDateTime = itemTimestamp.toDate(); // Convert Timestamp to DateTime

        if (lastNotificationTime == null ||
            itemDateTime.isAfter(lastNotificationTime!)) {
          // Show a notification only if the item is newer than the last notification
          showBigTextNotification(
            title: 'New promotion',
            body:
            'View our new promotion for more details check the notifications screen!',
            fln: flutterLocalNotificationsPlugin,
          );

          lastNotificationTime = itemDateTime; // Update the last notification time
        }
      }
    });
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
      'districap_channel',
      'channel_name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );
    await fln.show(0, title, body, not);
    notificationCounter++;
  }
}

// static void showNotifications(QueryDocumentSnapshot<Map<String, dynamic>> event, FlutterLocalNotificationsPlugin fln) {
//   const AndroidNotificationDetails androidNotificationDetails =
//   AndroidNotificationDetails(
//     '001',
//     'districap_channel',
//     channelDescription: "To send local notification",
//   );
//
//   const NotificationDetails details =
//   NotificationDetails(android: androidNotificationDetails);
//   fln.show(
//     01,
//     event.get('type'),
//     event.get('discount'),
//     details, // Pass the NotificationDetails here
//     payload: event.id,
//   );
// }
// showNotifications(event.docs.first,flutterLocalNotificationsPlugin);