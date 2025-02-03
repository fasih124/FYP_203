import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColorCode.neutralColor_500,
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
                        'HOME',
                        style: TextStyle(
                          color: AppColorCode.primaryColor_500,
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
                          'assets/icons_img/gear_icon.png',
                          width: 25,
                          height: 23,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                      color: AppColorCode.secondaryColor_500, // Line color
                      thickness: 1, // Line thickness
                      indent: 0, // Start padding
                      endIndent: 0 // End padding
                      ),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Cradle :',
                          style: TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'),
                        ),
                        const TextSpan(
                          text: ' Modelx-FYP203',
                          style: TextStyle(
                              color: AppColorCode.primaryNeutralColor_800,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Connected button action
                    },
                    icon: const Icon(Icons.arrow_forward,
                        color: Colors.white, size: 18),
                    label: const Text(
                      'Connected',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorCode.secondaryColor_500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColorCode.primaryColor_500, width: 4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Baby Presence',
                            style: TextStyle(
                              color: AppColorCode.primaryColor_800,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'PRESENT',
                            style: TextStyle(
                              color: AppColorCode.secondaryColor_500,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: [
                _buildCard('Temperature', '95°F', 'assets/icons_img/temp_Icon.png'),
                _buildCard('Weight', '2 KG', 'assets/icons_img/weight_icon.png'),
                _buildCard('Air Quality', '200 AQI','assets/icons_img/aqi_icon.png' ),
                _buildCard('Sound', '500 DB','assets/icons_img/sound_icon.png' ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCard(String title, String value, String path) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColorCode.primaryColor_500,
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    path,
                    width: 25,
                    height: 23,
                  ),// Icon(icon, color: AppColorCode.White_shade),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColorCode.White_shade,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              value,
              style: TextStyle(
                color: AppColorCode.primaryColor_500,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
