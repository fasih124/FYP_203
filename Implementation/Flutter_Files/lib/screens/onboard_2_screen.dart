import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';

import 'onboard_3_screen.dart';

class Onboard2Screen extends StatelessWidget {
  const Onboard2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorCode.neutralColor_300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColorCode.primaryColor_500),
                ),
              ),
            ),
          ),
          //  Image SVG
          SvgPicture.asset(
            'assets/images/app_onboard_screen_2.svg',
            width: 196,
            height: 284,
          ),
          //  Text
          SizedBox(
            width: 321,
            child: Center(
              child: Column(
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Peace of Mind at Your ",
                          style: AppTextStyle.heading_1.copyWith(
                              color: AppColorCode.primaryColor_500, height: .8),
                        ),
                        TextSpan(
                          text: "Fingertips ",
                          style: AppTextStyle.heading_1
                              .copyWith(color: AppColorCode.secondaryColor_500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Easily monitor your baby’s comfort and safety and Stay updated right from your phone.",
                    style: AppTextStyle.sub_heading_1
                        .copyWith(color: AppColorCode.neutralTextColor),
                  ),
                ],
              ),
            ),
          ),
          //  Button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorCode.secondaryColor_500,
                  foregroundColor: AppColorCode.White_shade,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 120),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text("Next"),
            ),
          )
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Onboard3Screen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Start from right side
      const end = Offset.zero; // End at original position
      const curve = Curves.easeInOut; // Smooth transition

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
