import 'package:flutter/material.dart';
import 'package:fyp_203/Component/text_feild_component.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';
import 'package:fyp_203/services/firebase_auth.dart';

class ConnectCradleScreen extends StatefulWidget {
  const ConnectCradleScreen({super.key});

  @override
  State<ConnectCradleScreen> createState() => _ConnectCradleScreenState();
}

class _ConnectCradleScreenState extends State<ConnectCradleScreen> {
  final TextEditingController connectController = TextEditingController();

  @override
  void dispose() {
    connectController.dispose();
    super.dispose();
  }


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
                    ' Cradle'.toUpperCase(),
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColorCode.neutralColor_50,
                border:  const Border.fromBorderSide(   BorderSide(
                    color: AppColorCode.Black_shade, width: 2 ),),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x332F2E41), // Shadow color with opacity
                    spreadRadius: 4, // How much the shadow spreads
                    blurRadius: 10, // How blurry the shadow is
                    offset: Offset(0, 4), // Shadow position (x, y)
                  ),
                ],
              ),
              margin: EdgeInsets.all(24),
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children:
                  [
                    CustomerTextField(
                      textlabel: 'Cradle ID',
                      texteditingcontroller: connectController,
                      isPassword: false,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(24),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:AppColorCode.secondaryColor_500,
                  foregroundColor: AppColorCode.warningColor_500,
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),

                ),
                child: const Text(
                  ' Connect to cradle',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: AppColorCode.White_shade,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
