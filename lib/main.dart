import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/app_provider.dart';
import 'package:todo_list/provider/auth_user_Provider.dart';
import 'package:todo_list/provider/list_provider.dart';
import 'package:todo_list/splash_screen.dart';
import 'package:todo_list/task_list/edit_task_screen.dart';
import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';
import 'firebase_options.dart';
import 'home/home_screen.dart';
import 'home/my_theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  await FirebaseFirestore.instance.clearPersistence();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListProvider()),
        ChangeNotifierProvider(create: (context) => AuthUserProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider(),)

      ],
  child: MyApp()
  )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) =>  HomeScreen(),
        SplashScreen.routeName: (_) =>  SplashScreen(),
        RegisterScreen.routeName : (_) => RegisterScreen(),
        LoginScreen.routeName : (_) => LoginScreen(),
        EditTaskScreen.routeName : (_) => EditTaskScreen(),
      },
      locale: Locale(provider.appLanguage),
      theme: MyThemeData.lightTheme,
      themeMode: provider.appTheme,
      darkTheme: MyThemeData.darkTheme,
      initialRoute: SplashScreen.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // locale: Locale(provider.appLanguage),
    );
  }
}