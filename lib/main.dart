import 'package:env_flutter/env_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/src/screens/hero_details.dart';
import 'package:marvel_app/src/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'firebase_options.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> firebaseMessagingInitialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
}


final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  await dotenv.load();
  firebaseMessagingInitialize();
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

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      scaffoldKey.currentState?.showSnackBar(showSnackBar(message));
    });
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
      scaffoldMessengerKey: scaffoldKey,
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
SnackBar showSnackBar(RemoteMessage message){
  return SnackBar(
    content:  Text('Show hero: \n${message.notification?.body}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    duration: const Duration(seconds: 10),
    backgroundColor: Colors.redAccent,
    action: SnackBarAction(
      label:'Check',
      onPressed: () {
        navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => HeroDetails(
              heroId: int.parse(message.data['heroId']),
            )));
      },
      textColor: Colors.black,
      disabledTextColor: Colors.grey,
    ),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    behavior: SnackBarBehavior.floating,

    margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
  );
}