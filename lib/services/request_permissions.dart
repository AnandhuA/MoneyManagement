import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  var smsStatus = await Permission.sms.status;
  var notificationStatus = await Permission.notification.status;

  if (!smsStatus.isGranted) {
    await Permission.sms.request();
  }

  if (!notificationStatus.isGranted) {
    await Permission.notification.request();
  }
}
