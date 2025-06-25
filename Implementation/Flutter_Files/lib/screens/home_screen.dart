import 'package:flutter/material.dart';
import 'package:fyp_203/Model/CradleSensorModel.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/connect_cradle_screen.dart';
import 'package:fyp_203/screens/setting_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/services/firebase_sensordata.dart';

import '../Model/SoundSensorModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16.0),
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
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Cradle :',
                          style: TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'),
                        ),
                        TextSpan(
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ConnectCradleScreen();
                      }));
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
                            'Baby Presence :',
                            style: TextStyle(
                              color: AppColorCode.Black_shade,
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
              childAspectRatio: 1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: [




                // temperature
                // _buildCard('Temperature', '95°F', 'assets/icons_img/temp_Icon.png'),
                StreamBuilder<CradleSensorData>(
                  stream: TemperatureSensorService.getTemperatureSensorData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      if (!data.enable) {
                        // Sensor is turned off
                        return _buildCard(
                          'Temperature',
                          Text(
                            'Tuned Off',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/temp_Icon.png',
                        );
                      }

                      return _buildCard(
                          'Temperature',
                          Text(
                            data.value.toUpperCase(),
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/temp_Icon.png');
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return _buildCard(
                          'Temperature',
                          Text(
                            'Error',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/temp_Icon.png');
                    } else {
                      return _buildCard(
                          'Temperature',
                          Text(
                            'Loading',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/temp_Icon.png');
                    }
                  },
                ),






                // _buildCard('Moisture', 'DRY', 'assets/icons_img/Droplet.png'),
                StreamBuilder<CradleSensorData>(
                  stream: MoistureSensorService.getMoistureSensorData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;

                      if (!data.enable) {
                        // Sensor is turned off
                        return _buildCard(
                          'Moisture',
                          Text(
                            'Tuned Off',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/Droplet.png',
                        );
                      }

                      return _buildCard(
                          'Moisture',
                          Text(
                            data.value.toUpperCase(),
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/Droplet.png');
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return _buildCard(
                          'Moisture',
                          Text(
                            'Error',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/Droplet.png');
                    } else {
                      return _buildCard(
                          'Moisture',
                          Text(
                            'Loading',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/Droplet.png');
                    }
                  },
                ),







                // _buildCard('Air Quality', '200 AQI','assets/icons_img/aqi_icon.png' ),
                // AQI
                StreamBuilder<CradleSensorData>(
                  stream: AQISensorService.getAQISensorData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;

                      if (!data.enable) {
                        // Sensor is turned off
                        return _buildCard(
                          'Air Quality',
                          Text(
                            'Tuned Off',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/aqi_icon.png',
                        );
                      }
                      // Sensor is enabled, show value
                      return _buildCard(
                        'Air Quality',
                        Text(
                          data.value.toUpperCase(),
                          style: const TextStyle(
                            color: AppColorCode.primaryColor_500,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        'assets/icons_img/aqi_icon.png',
                      );

                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return _buildCard(
                          'Air Quality',
                          Text(
                            'Error',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/aqi_icon.png');
                    } else {
                      return _buildCard(
                          'Air Quality',
                          Text(
                            'Loading',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/aqi_icon.png');
                    }
                  },
                ),







                // _buildCard('Sound', '500 DB','assets/icons_img/sound_icon.png' ),
                // sound
                StreamBuilder<SoundSensorData>(
                  stream: SoundSensorService.getSoundSensorData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;

                      if (!data.enable) {
                        // Sensor is turned off
                      return _buildCard(
                          'Sound',
                          Text(
                            'Tuned Off',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/sound_icon.png');
                      }
                      print( 'Sound is playing. this is : ${data.isplaying} ');
                      return _buildCard(
                          'Sound',
                          Text(
                            data.value.toUpperCase(),
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/sound_icon.png');


                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return _buildCard(
                          'Sound',
                          Text(
                            'Error',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/sound_icon.png');
                    } else {
                      return _buildCard(
                          'Sound',
                          Text(
                            'Loading',
                            style: const TextStyle(
                              color: AppColorCode.primaryColor_500,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          'assets/icons_img/sound_icon.png');
                    }
                  },
                ),



              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCard(String title, Text sensorText, String path) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColorCode.primaryColor_500,
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    path,
                    width: 25,
                    height: 23,
                  ), // Icon(icon, color: AppColorCode.White_shade),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColorCode.White_shade,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          Center(
            child: sensorText,
            // Text(
            //   value,
            //   style: const TextStyle(
            //     color: AppColorCode.primaryColor_500,
            //     fontSize: 36,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    ),
  );
}
