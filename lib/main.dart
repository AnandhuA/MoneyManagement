import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management/screens/home_screen.dart';
import 'package:money_management/services/request_permissions.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_sms_listener/flutter_sms_listener.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestPermissions();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "1",
    "checkForSms",
    frequency: Duration(minutes: 1),
  );

  runApp(const MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background task executed: $task");

    // Listen for incoming SMS
    FlutterSmsListener().onSmsReceived?.listen((message) {
      String smsBody = message.body ?? "Nothing";
      String sender = message.address ?? "Unknown Sender";
      log("Received SMS from $sender: $smsBody");

      // Show SMS notification
      showSmsNotification(sender, smsBody);
    });

    return Future.value(true);
  });
}

Future<void> showSmsNotification(String sender, String messageContent) async {
  var androidDetails = AndroidNotificationDetails(
    'sms_channel_id',
    'SMS Notifications',
    channelDescription: 'This channel is used for SMS notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  var notificationDetails = NotificationDetails(android: androidDetails);
  await flutterLocalNotificationsPlugin.show(
    0,
    'New SMS from $sender',
    messageContent,
    notificationDetails,
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyManagement',
      home: HomeScreen(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
