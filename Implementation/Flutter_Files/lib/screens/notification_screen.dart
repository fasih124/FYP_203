import 'package:flutter/material.dart';
import 'package:fyp_203/Component/notification_tile_widget.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/setting_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16.0),
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
                        'Notification',
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
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    AppColorCode.primaryNeutralColor_800,
                                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(
                                    color: AppColorCode.primaryNeutralColor_800,
                                    width: 2),
                              ),
                              onPressed: () {},
                              child: const Align(child: Text('Clear All')),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'today: '.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColorCode.primaryNeutralColor_800,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/temp_Icon.png',
                        mainColor: Colors.redAccent,
                        secondaryColor: Colors.redAccent.shade100,
                        titleText: 'Temperature',
                        descriptionText: "Temperature exceed ",
                        textValue: "20F",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/weight_icon.png',
                        mainColor: Colors.teal,
                        secondaryColor: Colors.teal.shade300,
                        titleText: 'Weight',
                        descriptionText: "Baby detected ",
                        textValue: "1KG",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/temp_Icon.png',
                        mainColor: Colors.redAccent,
                        secondaryColor: Colors.redAccent.shade100,
                        titleText: 'Temperature',
                        descriptionText: "Temperature exceed ",
                        textValue: "20F",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/weight_icon.png',
                        mainColor: Colors.teal,
                        secondaryColor: Colors.teal.shade300,
                        titleText: 'Weight',
                        descriptionText: "Baby detected ",
                        textValue: "1KG",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/temp_Icon.png',
                        mainColor: Colors.redAccent,
                        secondaryColor: Colors.redAccent.shade100,
                        titleText: 'Temperature',
                        descriptionText: "Temperature exceed ",
                        textValue: "20F",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'previous: '.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColorCode.primaryNeutralColor_800,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/weight_icon.png',
                        mainColor: Colors.teal,
                        secondaryColor: Colors.teal.shade300,
                        titleText: 'Weight',
                        descriptionText: "Baby detected ",
                        textValue: "1KG",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/temp_Icon.png',
                        mainColor: Colors.redAccent,
                        secondaryColor: Colors.redAccent.shade100,
                        titleText: 'Temperature',
                        descriptionText: "Temperature exceed ",
                        textValue: "20F",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/weight_icon.png',
                        mainColor: Colors.teal,
                        secondaryColor: Colors.teal.shade300,
                        titleText: 'Weight',
                        descriptionText: "Baby detected ",
                        textValue: "1KG",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/temp_Icon.png',
                        mainColor: Colors.redAccent,
                        secondaryColor: Colors.redAccent.shade100,
                        titleText: 'Temperature',
                        descriptionText: "Temperature exceed ",
                        textValue: "20F",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/weight_icon.png',
                        mainColor: Colors.teal,
                        secondaryColor: Colors.teal.shade300,
                        titleText: 'Weight',
                        descriptionText: "Baby detected ",
                        textValue: "1KG",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/temp_Icon.png',
                        mainColor: Colors.redAccent,
                        secondaryColor: Colors.redAccent.shade100,
                        titleText: 'Temperature',
                        descriptionText: "Temperature exceed ",
                        textValue: "20F",
                      ),
                      NotificationTile(
                        iconPath: 'assets/icons_img/weight_icon.png',
                        mainColor: Colors.teal,
                        secondaryColor: Colors.teal.shade300,
                        titleText: 'Weight',
                        descriptionText: "Baby detected ",
                        textValue: "1KG",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
