import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_203/comstants/colors_constant.dart';

class Onboard1Screen extends StatelessWidget {
  const Onboard1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorCode.neutralColor_300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Skip",style: TextStyle( decoration: TextDecoration.underline,color: AppColorCode.primaryColor_500),),
              ),
              alignment: AlignmentDirectional.topEnd,
            ),
          ),
          //  Image SVG
          Container(
            child: SvgPicture.asset(
              'assets/images/baby_onboard_screen_1.svg',
              width: 200,
              height: 300,
            ),
          ),
          //  Text
          Container(
            child: Column(
              children: [
                Text("Heading"),
                Text("Sub-heading"),
                Text("status"),
              ],
            ),
          ),
          //  Button
          ElevatedButton(
            onPressed: () {},
            child: Text("Get Started"),
          )
        ],
      ),
    );
  }
}
