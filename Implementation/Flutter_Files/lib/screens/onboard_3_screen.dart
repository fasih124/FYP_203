
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';

class Onboard3Screen extends StatelessWidget {
  const Onboard3Screen({super.key});

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
            'assets/images/alert_onboard_screen_3.svg',
            width: 196,
            height: 284,
          ),
          //  Text
          SizedBox(
            width: 339 ,
            child: Center(
              child: Column(
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Seamless Baby Care, Anytime, ",
                          style: AppTextStyle.heading_1
                              .copyWith(color: AppColorCode.primaryColor_500,
                              height: .8),
                        ),
                        TextSpan(
                          text: "Anywhere",
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
                    "Keep track of your baby’s well-being effortlessly. get updates and alerts instantly through your app.",
                    style: AppTextStyle.sub_heading_1.copyWith(color: AppColorCode.primaryNeutralColor_600),
                  ),
                ],
              ),
            ),
          ),
          //  Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
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


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
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
