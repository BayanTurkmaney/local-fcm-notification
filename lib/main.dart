import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notification_app/firebase_service.dart';
import 'package:notification_app/home.dart';
import 'package:notification_app/notification_details.dart';
import 'package:notification_app/notification_handler.dart';
import 'firebase_options.dart';
 import 'package:timezone/data/latest.dart' as tz;

final navigatorKey= GlobalKey<NavigatorState>();
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseService().initNtifications();
  await NotificationHandler().initialize();
 tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: HomeScreen(),
      routes: {
        
        NotificationDetails.route:(context) => NotificationDetails()
      },
    );
  }
}
