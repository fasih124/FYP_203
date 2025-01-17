
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';

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
                onTap: () {},
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
            width: 321 ,
            child: Center(
              child: Column(
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Peace of Mind at Your ",
                          style: AppTextStyle.heading_1
                              .copyWith(color: AppColorCode.primaryColor_500,
                              height: .8),
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
                    style: AppTextStyle.sub_heading_1.copyWith(color: AppColorCode.primaryNeutralColor_600),
                  ),
                ],
              ),
            ),
          ),
          //  Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColorCode.secondaryColor_500,
                foregroundColor: AppColorCode.White_shade,
                padding: EdgeInsets.symmetric(vertical: 18,horizontal:120 ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                )
            ),
            child: const Text("Next"),
          )
        ],
      ),
    );
  }
}
