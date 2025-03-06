import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';
import 'package:fyp_203/services/firebase_auth.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColorCode.primaryNeutralColor_600,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    'About us'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  )
                ],
              ),
            ),
            // const SizedBox(height: 24),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
                child: Text(
                  textAlign: TextAlign.justify,
                    "CareNest – Smart Cradle Baby Monitoring System: Ensuring Comfort, Safety, and Peace of Mind for Parents\n"
                        "\nthis app is Develop as a part FYP Group 203 project at National Textile University, Faisalabad",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)
              ,)
          ],
        ),
      ),
    );
  }
}
