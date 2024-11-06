import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  log("permistion");
  var smsStatus = await Permission.sms.status;
  var notificationStatus = await Permission.notification.status;

  if (!smsStatus.isGranted) {
    await Permission.sms.request();
  }

  if (!notificationStatus.isGranted) {
    await Permission.notification.request();
  }

  log("is smsStatus granted ::::${smsStatus.isGranted}");
  log("is notification granted ::::${smsStatus.isGranted}");
}
