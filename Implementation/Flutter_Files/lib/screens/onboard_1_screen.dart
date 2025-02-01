import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/onboard_2_screen.dart';
import 'package:fyp_203/screens/signin_screen.dart';

class Onboard1Screen extends StatelessWidget {
  const Onboard1Screen({super.key});

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
                      fontWeight:FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: AppColorCode.primaryColor_500),
                ),
              ),
            ),
          ),
          //  Image SVG
          SvgPicture.asset(
            'assets/images/baby_onboard_screen_1.svg',
            width: 196,
            height: 284,
          ),
          //  Text
          SizedBox(
            width: 309,
            child: Center(
              child: Column(
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "A  Smarter Way to Care for Your ",
                          style: AppTextStyle.heading_1.copyWith(
                              color: AppColorCode.primaryColor_500, height: .8),
                        ),
                        TextSpan(
                          text: "Baby",
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
                    "Innovative features and environment monitoring make parenting easier and stress-free.",
                    style: AppTextStyle.sub_heading_1
                        .copyWith(color: AppColorCode.primaryNeutralColor_600),
                  ),
                ],
              ),
            ),
          ),
          //  Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Onboard2Screen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColorCode.secondaryColor_500,
                foregroundColor: AppColorCode.White_shade,
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 120),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: const Text("Get Started"),
          )
        ],
      ),
    );
  }
}
