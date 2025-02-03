import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
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
                    height: 6,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {},
                  child: const Align(child: Text('Clear All')),
                ),
              ),
            ],
          ),
          Container(
            child: const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                    Text('1111'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
