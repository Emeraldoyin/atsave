import 'package:easysave/controller/onboarding/onboarding_controller.dart';
import 'package:easysave/controller/signin/signin_controller.dart';
import 'package:easysave/view/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/utils/helpers/session_manager.dart';
import '../home/home_controller.dart';

///implementing controller for splash screen
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashController createState() => SplashController();
}

///controller class for splash screen
class SplashController extends State<Splash> {
//initializing local settings to acess device settings
  SessionManager manager = SessionManager();

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    isLoading();
    requestPermission();
    saveToken();
    retrieveToken();
    initInfo();
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SplashScreen(this);


//delaying the splash screen to process all necessary actions
  isLoading() async {
    Future.delayed(const Duration(seconds: 8), () async {
      
      bool? hasUserSeenOnboardingPage = await manager.seenOnboardingScreen();
      bool? loggedIn = await manager.isUserLoggedIn();
      if (hasUserSeenOnboardingPage != null &&
          hasUserSeenOnboardingPage &&
          loggedIn != true) {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      } else if (hasUserSeenOnboardingPage != null &&
          hasUserSeenOnboardingPage &&
          loggedIn != null &&
          loggedIn) {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Onboarding()));
      }
    });
  }


//get the device token from shared preferences
  retrieveToken() async {
    var token = await manager.retrieveMessagingToken();
    print(token);
  }


  /// handles getting permission from user for app to acces device notification
  void requestPermission() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await message.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission'); //when the user accepts the prompt
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional authorization');
    } else {
      print('User declined');
    }
  }

// hanldes getting the device toe\ken from the device and saving the token in shared preferences
  void saveToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      manager.saveMessagingToken(value!);
    });
  }

  void initInfo() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        try {} catch (e) {}
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('User tapped on the notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    });

    // Handle the initial notification when the app is launched from a terminated state
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print('App launched from a terminated state:');
      print('Title: ${initialMessage.notification?.title}');
      print('Body: ${initialMessage.notification?.body}');
    }
  }

  /// displays the notificstion even when the app is in foreground
  Future<void> displayNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }
}
