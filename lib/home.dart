import 'package:flutter/material.dart';
import 'package:notification_app/notification_handler.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Home'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  NotificationHandler()
                      .showCustomLocalNotification('messenger');
                },
                child: Text('Messenger Notification')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  NotificationHandler().showCustomLocalNotification('reminder');
                },
                child: Text('Reminder Notification')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  NotificationHandler()
                      .showCustomLocalNotification('notification');
                },
                child: Text('FCM Notification')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  NotificationHandler().scheduleNotification();
                },
                child: Text('schedueled Notification'))
          ],
        ),
      ),
    );
  }
}
