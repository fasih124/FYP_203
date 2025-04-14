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

import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ).copyWith(scaffoldBackgroundColor: AppColorCode.neutralColor_500),
      debugShowCheckedModeBanner: false,
      home: const AuthChecker() ,
    );
  }
}


class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const BottomNavigationScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}

