import 'package:flutter/material.dart';
import 'package:fyp_203/comstants/colors_constant.dart';
import 'package:fyp_203/screens/onboard_1_screen.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Onboard1Screen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorCode.primaryColor_500,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'CareNest',
              style: TextStyle(
                  fontSize: 34,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                color: AppColorCode.White_shade
              ),
            ),
          ),
          Center(
            child: Text(
              'Where Love Meets Technology',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                  color: AppColorCode.White_shade
              ),
            ),
          ),
        ],
      ),
    );
  }
}
