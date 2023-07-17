import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_app/main.dart';
import 'package:notification_app/notification_details.dart' as ntd;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void handleLocalBackgroundMessage(NotificationResponse notificationResponse) {
  navigatorKey.currentState!.pushNamed(ntd.NotificationDetails.route);
  // handle action
}
class NotificationHandler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
   


  Future<void> initialize() async {

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      print('local foreground notification ...');
      print(details);
      navigatorKey.currentState
        ?.pushNamed(ntd.NotificationDetails.route, );
    },
  onDidReceiveBackgroundNotificationResponse: handleLocalBackgroundMessage,

   
    );
  }
  AndroidNotificationDetails _messangerNotification =
       
          AndroidNotificationDetails(
          'msg_channel1',
          'MSG_Channel',
          channelDescription:  'Channel for MSG notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          enableLights: true,
          visibility: NotificationVisibility.private,
          color: Colors.red,
          sound: RawResourceAndroidNotificationSound('messenger'),
          ticker: 'ticker',
        
      );
        AndroidNotificationDetails _reminderNotification =
       
          AndroidNotificationDetails(
          'reminder_channel1',
          'REM_Channel',
          channelDescription:  'Channel for REM notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
           enableLights: true,
          playSound: true,
           color: Colors.green,
           colorized: true,
           visibility: NotificationVisibility.public,
           enableVibration: true,
          sound: RawResourceAndroidNotificationSound('reminder'),
          ticker: 'ticker',
        
      );
      AndroidNotificationDetails _fcmNotificationsDetails =  AndroidNotificationDetails(
          'fcm_channel',
          'FCM Channel',
          channelDescription:  'Channel for FCM notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
           enableLights: true,
           color: Colors.blue,
           visibility: NotificationVisibility.secret,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification'),
          ticker: 'ticker',
        );

  void display(RemoteMessage message) async {
    // Display a local notification
    print('******************************************');
    await flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'fcm_channel',
          'FCM Channel',
          channelDescription:  'Channel for FCM notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          ticker: 'ticker',
        ),
      ),
      payload: message.data.toString(),

    );
  }

  void showCustomLocalNotification(String type) async {
    // Display a local notification
    print('******************************************');
    await flutterLocalNotificationsPlugin.show(
      1,
     type == 'messenger'?'messenger':type=='reminder'? 'reminder':'fcm' ,
      'custom body' ,
      NotificationDetails(
        android: type == 'messenger'? _messangerNotification: type=='reminder'? _reminderNotification:_fcmNotificationsDetails

      ),
      // payload: message.data.toString(),
      
    );
  }

  Future<void> scheduleNotification() async {
    print('*************************');
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'sch_channel_id', 'sch_channel_name',channelDescription:  'sch_channel_description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Scheduled Notification Title',
        'Scheduled Notification Body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)), // instead of _nextInstanceOfTenAM(),
        
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
              
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    // if (scheduledDate.isBefore(now)) {
    //   scheduledDate = scheduledDate.add(const Duration(days: 1));
    // }
    return scheduledDate;
  }



}
