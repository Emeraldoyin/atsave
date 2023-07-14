import 'package:easysave/bloc_folder/database_bloc/database_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/controller/splash_screen/splash_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc_folder/auth_bloc/authentication_bloc.dart';
import 'config/theme/app_theme.dart';
import 'manager/local_db_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDbManager.openDb();
  //Bloc.observer = Observer();
  await Firebase.initializeApp(
      // name: Platform.isIOS ?'DEFAULT':null,
      //  options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const EasySaveApp());
}

class EasySaveApp extends StatelessWidget {
  const EasySaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme:
                  AppTheme.lightTheme, // ThemeData(primarySwatch: Colors.blue),
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
