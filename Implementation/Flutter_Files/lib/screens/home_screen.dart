import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_203/constants/colors_constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // Text(
  // 'HOME',
  // style: TextStyle(
  // color: Colors.blue[900],
  // fontSize: 24,
  // fontWeight: FontWeight.bold,
  // ),
  // ),

  // IconButton(
  // icon: Icon(
  // Icons.settings,
  // color: Colors.blue[900],
  // size: 32,
  // ),
  // onPressed: () {
  // // Settings button action
  // },
  // ),

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
                  offset: Offset(
                      0, 4), // Shadow offset (horizontal, vertical)
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
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: AppColorCode.primaryColor_500,
                          size: 32,
                        ),
                        onPressed: () {
                          // Settings button action
                        },
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
                            color: Colors.blue[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(
                          text: ' Modelx-FYP203',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
                    height: 16,
                  ),
                  Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[900]!,width: 2),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Baby Presence'),
                          Text(
                            'PRESENT',
                            style: TextStyle(
                              color: Color(0xFF38B6FF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: [
                _buildCard('Temperature', '95°F', Icons.thermostat),
                _buildCard('Weight', '2 KG', Icons.monitor_weight),
                _buildCard('Air Quality', '200 AQI', Icons.air),
                _buildCard('Sound', '500 DB', Icons.music_note),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {},
        backgroundColor: AppColorCode.primaryColor_500,
        selectedItemColor: AppColorCode.White_shade,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline_rounded),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Notification',
          ),
        ],
      ),
    );
  }
}

  Widget _buildCard(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[900]),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

