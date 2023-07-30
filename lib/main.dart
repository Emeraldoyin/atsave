import 'dart:developer';

import 'package:easysave/bloc_folder/database_bloc/database_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/controller/splash_screen/splash_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc_folder/auth_bloc/authentication_bloc.dart';
import 'config/theme/app_theme.dart';
import 'firebase_options.dart';
import 'manager/local_db_manager.dart';

//this is the root of the application
void main() async {
  //initialising the databases(firebase and isar)
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDbManager.openDb();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Request permission for notifications when the app starts for the first time
  await FirebaseMessaging.instance.requestPermission();
  Bloc.observer = MyObserver();
  // Get the initial message if it exists
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // This can happen if the user taps on a notification that launches the app
    // while the app is terminated or in the background.
    // Process the initial message here
    processMessage(initialMessage);
  }
  // await FirebaseMessaging.instance.getInitialMessage();
  runApp(const EasySaveApp());
}

void processMessage(RemoteMessage message) {
  // Handling the initial message by showing a dialog with the message notification
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: const Text('New Message'),
      content: Text(message.notification?.body ?? 'No message body'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///EASYSAVE Application(a.k.a ATSave) is a mobile application that enables users
///to create and manage their savings goals, save money and monitor their savings
///and expenses likewise.
class EasySaveApp extends StatelessWidget {
  const EasySaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //specifying the available state management(bloc) providers used in ATSave App
        MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(),
        ),
        BlocProvider<DatabaseBloc>(
          create: (BuildContext context) => DatabaseBloc(),
        ),
        BlocProvider<ConnectivityBloc>(
          create: (BuildContext context) => ConnectivityBloc(),
        ),
      ],
      child:
          //applying a package that helps with app responsiveness on various platforms
          ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ATSave App',
              navigatorKey: navigatorKey,
              theme: AppTheme.lightTheme,
              // darkTheme:
              //    AppTheme.darkTheme, // ThemeData(primarySwatch: Colors.blue),
              themeMode: ThemeMode.light,
              //themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: child);
        },
        child: const Splash(),
      ),
    );
  }
}

class MyObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(
      change.toString(),
      name: bloc.toString(),
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(event.toString(), name: bloc.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log("${transition.currentState}=>${transition.nextState}",
        name: bloc.toString());
  }
}
