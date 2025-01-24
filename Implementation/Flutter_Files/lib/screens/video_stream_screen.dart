import 'package:flutter/material.dart';

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
                      IconButton(
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: AppColorCode.White_shade,
                          size: 32,
                        ),
                        onPressed: () {
// Settings button action
                        },
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
                  Text(
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
          Container(
            child: Expanded(child: Text('data'),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
