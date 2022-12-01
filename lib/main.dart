import 'package:env_flutter/env_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/src/screens/hero_details.dart';
import 'package:marvel_app/src/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  //print('Hero ID: ${message.data["heroId"]}');
  const androidInitialization = AndroidInitializationSettings('@mipmap/ic_launcher');
  const settings = InitializationSettings(android: androidInitialization,);
  flutterLocalNotificationsPlugin.initialize(settings,);
  RemoteNotification? notification  = message.notification;
  AndroidNotification? android  = message.notification?.android;

  if (notification  != null && android  != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id ,
            channel.name ,
            channelDescription: channel.description,
            icon: android.smallIcon,
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            // other properties...
          ),
        ));
  }


}


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,

  );
  /*const AndroidNotificationChannel channel  = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,

  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin  =
  FlutterLocalNotificationsPlugin();


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);



 FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("onMessageOpenedApp: $message");
    navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => HeroDetails(
          heroId: int.parse(message.data['heroId']),
        )));


  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification  = message.notification;
    AndroidNotification? android  = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification  != null && android  != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id ,
              channel.name ,
              channelDescription: channel.description,
              icon: android.smallIcon,
              // other properties...
            ),
          ));
    }
  });*/
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

@override
  void initState() {
    super.initState();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {

      navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => HeroDetails(
            heroId: int.parse(message.data['heroId']),
          )));
  });
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Marvel heroes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   const HomePage(),
    );
  }
}
