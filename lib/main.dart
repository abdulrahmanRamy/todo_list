import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/list_provider.dart';
import 'package:todo_list/splash_screen.dart';
import 'firebase_options.dart';
import 'home/home_screen.dart';
import 'home/my_theme_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.clearPersistence();
  runApp( ChangeNotifierProvider(
      create : (context) => ListProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      routes: {
        HomeScreen.routeName: (_) =>  HomeScreen(),
        SplashScreen.routeName: (_) =>  SplashScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}