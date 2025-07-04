import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/firebase_options.dart';
import 'package:fyp_203/screens/bottom_navigation_screen.dart';
import 'package:fyp_203/screens/splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fyp_203/services/firebase_notification_listener.dart';
import 'package:fyp_203/services/notification_service.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Check if Firebase is already initialized
//   try {
//     if (Firebase.apps.isEmpty) {
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );
//       // print('✅ Firebase initialized with: ${DefaultFirebaseOptions.currentPlatform}');
//     }
//   } catch (e) {
//     print('Firebase init error: $e');
//   }
//
//   // ✅ Local Notifications Init
//   const AndroidInitializationSettings androidInitSettings =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   final InitializationSettings initSettings = InitializationSettings(
//     android: androidInitSettings,
//   );
//
//
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  Firebase Init
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print('Firebase init error: $e');
  }


  await NotificationService.init();

  // await  FirebaseNotificationListener.startListening();
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
          // FirebaseNotificationListener.startListening();
          return const BottomNavigationScreen();
        } else {
          print('User is not logged in');
          return const SplashScreen();
        }
      },
    );
  }
}

