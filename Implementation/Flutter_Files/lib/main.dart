import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';

import 'package:fyp_203/screens/home_screen.dart';
import 'package:fyp_203/screens/signin_screen.dart';
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
      theme: ThemeData(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: AppColorCode.neutralColor_500
      ),
      debugShowCheckedModeBanner: false,
      home: const SignInScreen()//HomeScreen()//SignUpScreen(),//SplashScreen()
    );
  }
}




