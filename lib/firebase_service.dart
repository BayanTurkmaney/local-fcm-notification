import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_app/notification_details.dart';
import 'package:notification_app/notification_handler.dart';
import 'main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('background state ....');
  
  NotificationHandler().display(message!);
  navigatorKey.currentState
        ?.pushNamed(NotificationDetails.route, );
}

class FirebaseService {
  final FirebaseMessaging _firbaseMessagng = FirebaseMessaging.instance;
  
  void subscripeToAdmin(){
    _firbaseMessagng.subscribeToTopic('Admin');
  }
  void handleTerminatedMessage(RemoteMessage? message) {
    if (message == null) return;
     NotificationHandler().display(message);
    navigatorKey.currentState
        ?.pushNamed(NotificationDetails.route, );
  }
 void handleForegroundMessage (RemoteMessage? message){
   print(' foreground state ...');
  NotificationHandler().display(message!);
  print('End foreground state ...');
//   if (message.data['click_action'] != null) {
//     print('clicked ....');
// navigatorKey.currentState
//         ?.pushNamed(NotificationDetails.route, );  }
//         else{
//           print(message.notification!.android!.clickAction);

//         }
  
 }
  Future<void> initNtifications() async {
    await _firbaseMessagng.requestPermission();
    final fCMtoke = await _firbaseMessagng.getToken();
    print('token is $fCMtoke');
    subscripeToAdmin();
    await initPushNotifications();
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleTerminatedMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleTerminatedMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
  }
}
