import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/firebase_options.dart';
import 'package:fyp_203/screens/about-us-screen.dart';
import 'package:fyp_203/screens/bottom_navigation_screen.dart';
import 'package:fyp_203/screens/connect_cradle_screen.dart';

import 'package:fyp_203/screens/home_screen.dart';
import 'package:fyp_203/screens/notification_screen.dart';
import 'package:fyp_203/screens/option_screen.dart';
import 'package:fyp_203/screens/signin_screen.dart';
import 'package:fyp_203/screens/splash_screen.dart';
import 'package:fyp_203/screens/video_stream_screen.dart';
import 'package:fyp_203/services/firebase_auth.dart';
import 'screens/onboard_1_screen.dart';
import 'screens/onboard_2_screen.dart';

import 'screens/onboard_3_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        useMaterial3: true,
        fontFamily: 'Poppins',
      ).copyWith(scaffoldBackgroundColor: AppColorCode.neutralColor_500),
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream:
          FirebaseAuth.instance.authStateChanges(), // Listen to auth changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading
        }
        if (snapshot.hasData) {
          return const BottomNavigationScreen(); // User is logged in
        } else {
          return const SplashScreen(); // User is not logged in
        }
      },
    );
  }
}
