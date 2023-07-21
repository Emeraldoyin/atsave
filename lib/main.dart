import 'package:easysave/bloc_folder/database_bloc/database_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/controller/splash_screen/splash_controller.dart';
import 'package:firebase_core/firebase_core.dart';
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
  runApp(const EasySaveApp());
}

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
              title: 'Flutter Demo',
              theme:
                  AppTheme.lightTheme, 
              darkTheme:
                  AppTheme.darkTheme, // ThemeData(primarySwatch: Colors.blue),
              //themeMode: ThemeMode.dark,
              //themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: child);
        },
        child: const Splash(),
      ),
    );
  }
}
