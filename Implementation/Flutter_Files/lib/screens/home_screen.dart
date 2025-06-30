import 'package:flutter/material.dart';
import 'package:fyp_203/Model/CradleSensorModel.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/connect_cradle_screen.dart';
import 'package:fyp_203/screens/option_screen.dart';
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
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 20.0),
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
                              builder: (builder) => const OptionScreen(),
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
                              color: Colors.black54,
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
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const ConnectCradleScreen();
                      // }));
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
          Expanded(
            child: ListView(
              children: [
                StreamBuilder<CradleSensorData>(
                  stream: TemperatureSensorService.getTemperatureSensorData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      if (!data.enable) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color: AppColorCode
                                .primaryColor_600, //Colors.blue[50],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                'Enabled it in setting',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Baby body temperature',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing:
                                  Image.asset('assets/icons_img/temp_Icon.png'),
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              data.value.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby body temperature',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/temp_Icon.png')
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Error in loading ",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby body temperature',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/temp_Icon.png'),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              'Loading Data',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby body temperature',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing:
                                Image.asset('assets/icons_img/temp_Icon.png'),
                          ),
                        ),
                      );
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color:
                            AppColorCode.primaryColor_600,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                'Enabled it in setting',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Baby Diaper Moisture',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing: Image.asset(
                                  'assets/icons_img/Droplet.png'),
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                              AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              data.value.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby Diaper Moisture',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/Droplet.png')
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');


                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_600,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              'Error in loading',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby Diaper Moisture',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Image.asset(
                                'assets/icons_img/Droplet.png'),
                          ),
                        ),
                      );


                    } else {

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_600,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              'Loading Data',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby Diaper Moisture',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Image.asset(
                                'assets/icons_img/Droplet.png'),
                          ),
                        ),
                      );

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

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color:
                            AppColorCode.primaryColor_600, //Colors.blue[50],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                "Enabled it in Setting",
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Air Quality',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing: Image.asset(
                                  'assets/icons_img/aqi_icon.png'),
                            ),
                          ),
                        );

                      }
                      // Sensor is enabled, show value

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              data.value.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Air Quality',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/aqi_icon.png')
                            ),
                          ),
                        ),
                      );

                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Error in Loading",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Air Quality',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Image.asset(
                                'assets/icons_img/aqi_icon.png'),
                          ),
                        ),
                      );

                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Loading Data",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Air Quality',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Image.asset(
                                'assets/icons_img/aqi_icon.png'),
                          ),
                        ),
                      );
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Card(
                            color:
                            AppColorCode.primaryColor_600, //Colors.blue[50],
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              title: Text(
                                "Enabled it in setting",
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Baby is crying or not',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                              trailing: Image.asset(
                                  'assets/icons_img/sound_icon.png'),
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_500, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              data.value.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby is crying or not',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColorCode.secondaryColor_500,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icons_img/sound_icon.png')
                            ),
                          ),
                        ),
                      );

                    } else if (snapshot.hasError) {
                      print('Stream error: ${snapshot.error}');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Error in Loading",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby is crying or not',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Image.asset(
                                'assets/icons_img/sound_icon.png'),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Card(
                          color:
                          AppColorCode.primaryColor_600, //Colors.blue[50],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              "Loading Data",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Baby is crying or not',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                              ),
                            ),
                            trailing: Image.asset(
                                'assets/icons_img/sound_icon.png'),
                          ),
                        ),
                      );
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
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: AppColorCode.neutralColor_50,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColorCode.primaryColor_500,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                topLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
                topRight: Radius.circular(14),
                // Radius.circular(4),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Image.asset(
                path,
                width: 30,
                height: 30,
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       path,
              //       width: 35,
              //       height: 33,
              //     ), // Icon(icon, color: AppColorCode.White_shade),
              //     // Text(
              //     //   title,
              //     //   style: const TextStyle(
              //     //     color: AppColorCode.White_shade,
              //     //     fontSize: 16,
              //     //     fontWeight: FontWeight.bold,
              //     //   ),
              //     // ),
              //     // const SizedBox(width: 30),
              //   ],
              // ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   title,
              //   style: const TextStyle(
              //     color: Colors.black87,
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              sensorText,
            ],
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    ),
  );
}
