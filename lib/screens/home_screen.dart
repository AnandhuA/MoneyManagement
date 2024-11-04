import 'package:flutter/material.dart';
import 'package:flutter_sms_listener/flutter_sms_listener.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_management/widgets/empty_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestPermissions();
    initializeNotifications();
    listenForSmsMessages();
  }

  Future<void> requestPermissions() async {
    var smsPermission = await Permission.sms.status;
    if (!smsPermission.isGranted) {
      await Permission.sms.request();
    }
  }

  Future<void> initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void listenForSmsMessages() {
    FlutterSmsListener().onSmsReceived?.listen((message) {
      String smsBody = message.body ?? "";
      showSmsNotification(smsBody);
    });
  }

  Future<void> showSmsNotification(String messageContent) async {
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
      'New SMS Received',
      messageContent,
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Money Management')),
      body: emptyScreen(
        context: context,
        text1: "Show",
        size1: 14,
        text2: "Nothing",
        size2: 14,
        text3: "HomeScreen",
        size3: 20,
      ),
    );
  }
}
