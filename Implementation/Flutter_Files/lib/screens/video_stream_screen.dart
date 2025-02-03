import 'package:flutter/material.dart';
import 'package:fyp_203/screens/setting_screen.dart';

import '../constants/colors_constant.dart';

class VideoStreamScreen extends StatefulWidget {
  const VideoStreamScreen({super.key});

  @override
  State<VideoStreamScreen> createState() => _VideoStreamScreenState();
}

class _VideoStreamScreenState extends State<VideoStreamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColorCode.primaryColor_500,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25), // Rounded bottom-left corner
                bottomRight: Radius.circular(25), // Rounded bottom-right corner
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x402E5077), // Shadow color
                  blurRadius: 10, // Softness of the shadow
                  spreadRadius: 2, // Spread of the shadow
                  offset: Offset(0, 4), // Shadow offset (horizontal, vertical)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Live Stream',
                        style: TextStyle(
                          color: AppColorCode.White_shade,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const SettingScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons_img/gear_2_icon.png',
                          width: 25,
                          height: 23,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                      color: AppColorCode.White_shade, // Line color
                      thickness: 1, // Line thickness
                      indent: 0, // Start padding
                      endIndent: 0 // End padding
                      ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    'Cradle : Modelx-FYP203',
                    style: TextStyle(
                      color: AppColorCode.White_shade,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          Container(
            width: 345,
            height: 165,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFF2F2E41),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x992F2E41), // Shadow color with opacity
                  spreadRadius: 4, // How much the shadow spreads
                  blurRadius: 10, // How blurry the shadow is
                  offset: Offset(0, 4), // Shadow position (x, y)
                ),
              ],
            ),
            child: Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33FFFFFF), // Shadow color with opacity
                          spreadRadius: 4, // How much the shadow spreads
                          blurRadius: 10, // How blurry the shadow is
                          offset: Offset(0, 0), // Shadow position (x, y)
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/icons_img/play_button.png',
                        width: 95,
                        height: 89,
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
