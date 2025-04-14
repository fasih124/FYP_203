import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/firebase_options.dart';
import 'package:fyp_203/screens/bottom_navigation_screen.dart';
import 'package:fyp_203/screens/splash_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if Firebase is already initialized
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print('Firebase init error: $e');
  }

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
      home:const AuthChecker() ,// const BottomNavigationScreen(),// const AuthChecker() ,
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
          print('Waiting for auth...');
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          print('User is logged in');
          return const BottomNavigationScreen();
        } else {
          print('User is not logged in');
          return const SplashScreen();
        }
      },
    );
  }
}

