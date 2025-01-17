import 'package:flutter/material.dart';
import 'package:fyp_203/screens/home_screen.dart';
import 'package:fyp_203/screens/splash_screen.dart';

import 'screens/onboard_1_screen.dart';
import 'screens/onboard_2_screen.dart';
import 'screens/onboard_3_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen()//SignUpScreen(),//SplashScreen()
    );
  }
}




