import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';
import 'package:fyp_203/services/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fyp_203/screens/about-us-screen.dart';
import 'package:fyp_203/screens/connect_cradle_screen.dart';
import 'package:fyp_203/screens/option_screen.dart';


class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {

  @override
  void initState() {
    super.initState();
    fetchInitialSensorValues();
  }

  void fetchInitialSensorValues() async {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app/',
    );

    try {
      final tempSnapshot = await database.ref('sensors/cradle1/TempSensor/enable').once();
      final moistSnapshot = await database.ref('sensors/cradle1/MositureSensor/enable').once();
      final soundSnapshot = await database.ref('sensors/cradle1/SoundSensor/enable').once();
      final aqiSnapshot = await database.ref('sensors/cradle1/AQISensor/enable').once();
      final soundplayingSnapshot = await database.ref('sensors/cradle1/SoundSensor/isplaying').once();

      setState(() {
        getTemp = tempSnapshot.snapshot.value as bool? ?? false;
        getMoisture = moistSnapshot.snapshot.value as bool? ?? false;
        getSound = soundSnapshot.snapshot.value as bool? ?? false;
        getAQI = aqiSnapshot.snapshot.value as bool? ?? false;
        isPlaying = soundplayingSnapshot.snapshot.value as bool? ?? false;
      });
    } catch (e) {
      print('Error fetching initial sensor values: $e');
    }
  }








  bool isPlaying = false;
  bool getTemp = true;
  bool getMoisture = true;
  bool getSound = true;
  bool getAQI = true;
   // updateSensorStatus('TempSensor', value);
   void updateSensorStatus(String sensorType, bool status) {
     final ref = FirebaseDatabase.instanceFor(
       app: Firebase.app(),
       databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app/',
     ).ref('sensors/cradle1/$sensorType');
     ref.update({'enable': status});
   }




   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColorCode.primaryNeutralColor_600,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    'Setting'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  )
                ],
              ),
            ),
            // const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColorCode.neutralColor_50,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x332F2E41), // Shadow color with opacity
                    spreadRadius: 4, // How much the shadow spreads
                    blurRadius: 10, // How blurry the shadow is
                    offset: Offset(0, 4), // Shadow position (x, y)
                  ),
                ],
              ),
              margin: EdgeInsets.all(24),
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  children:
                  [
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/temp_Icon.png',
                        width: 25,
                        height: 23,
                        color: AppColorCode.Black_shade,
                      ),
                      title: Text('Temperature'),
                      trailing:   Switch(
                          value: getTemp,
                          activeColor: AppColorCode.play_500,
                          activeTrackColor:  Colors.grey.shade400,
                          inactiveThumbColor: AppColorCode.stop_500,
                          inactiveTrackColor:  Colors.grey.shade400,
                          onChanged: (value) {
                            setState(() {
                              getTemp = value;
                              // print(value);
                            });
                            updateSensorStatus('TempSensor', value); // 🔥 Firebase update
                          }),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/Droplet.png',
                        width: 25,
                        height: 23,
                        color: AppColorCode.Black_shade,
                      ),
                      title: Text('moisture'),
                      trailing:Switch(
                          value: getMoisture,
                          activeColor: AppColorCode.play_500,
                          activeTrackColor:  Colors.grey.shade400,
                          inactiveThumbColor: AppColorCode.stop_500,
                          inactiveTrackColor:  Colors.grey.shade400,
                          onChanged: (value) {
                            setState(() {
                              getMoisture = value;
                            });
                            updateSensorStatus('MositureSensor', value); // 🔥 Firebase update
                          }),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/sound_icon.png',
                        width: 25,
                        height: 23,
                        color: AppColorCode.Black_shade,
                      ),
                      title: Text('Sound'),
                      trailing:Switch(
                          value: getSound,
                          activeColor: AppColorCode.play_500,
                          activeTrackColor:  Colors.grey.shade400,
                          inactiveThumbColor: AppColorCode.stop_500,
                          inactiveTrackColor:  Colors.grey.shade400,
                          onChanged: (value) {
                            setState(() {
                              getSound = value;
                            });
                            updateSensorStatus('SoundSensor', value); // 🔥 Firebase update
                          }),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/aqi_icon.png',
                        width: 25,
                        height: 23,
                        color: AppColorCode.Black_shade,
                      ),
                      title: Text('Air Quality'),
                      trailing: Switch(
                          value: getAQI,
                          activeColor: AppColorCode.play_500,
                          activeTrackColor:  Colors.grey.shade400,
                          inactiveThumbColor: AppColorCode.stop_500,
                          inactiveTrackColor:  Colors.grey.shade400,
                          onChanged: (value) {
                            setState(() {
                              getAQI = value;
                            });
                            updateSensorStatus('AQISensor', value); // 🔥 Firebase update
                          }),
                    ),
                    Divider(
                    color: Colors.grey.shade300, // Line color
                    thickness: 1,
                  ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const AboutUsScreen();
                            }));
                      },
                      leading: Image.asset(
                        'assets/icons_img/about_icon.png',
                        width: 25,
                        height: 23,
                      ),
                      title: Text('About Us'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      margin: EdgeInsets.all(24),
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          await AuthService().signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const SignInScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColorCode.warningColor_500,
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          side: const BorderSide(
                              color: AppColorCode.warningColor_500, width: 2),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColorCode.warningColor_500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.all(24),
            //   width: double.infinity,
            //   child: OutlinedButton(
            //     onPressed: () {
            //       setState(() {
            //         final ref = FirebaseDatabase.instanceFor(
            //           app: Firebase.app(),
            //           databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app/',
            //         ).ref('sensors/cradle1/SoundSensor');
            //
            //
            //         if(!isPlaying){
            //           isPlaying=true;
            //           ref.update({'isplaying': true});
            //         }else{
            //           isPlaying=false;
            //           ref.update({'isplaying': false});
            //         }
            //
            //       });
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor:
            //           isPlaying ? AppColorCode.stop_500 : AppColorCode.play_500,
            //       foregroundColor: AppColorCode.warningColor_500,
            //       padding: EdgeInsets.symmetric(
            //         vertical: 16,
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(
            //           12,
            //         ),
            //       ),
            //       side: const BorderSide(
            //           color: AppColorCode.Black_shade, width: 2),
            //     ),
            //     // child: Row(
            //     //   mainAxisAlignment: MainAxisAlignment.center,
            //     //   children: [
            //     //     Image.asset(
            //     //       'assets/icons_img/sound_icon.png',
            //     //       width: 25,
            //     //       height: 23,
            //     //       color: AppColorCode.Black_shade,
            //     //     ),
            //     //      Text(
            //     //       isPlaying ?'  Pause Lullaby':'  Play Lullaby',
            //     //       style: TextStyle(
            //     //         fontWeight: FontWeight.w500,
            //     //         fontFamily: 'Poppins',
            //     //         fontSize: 20,
            //     //         color: AppColorCode.Black_shade,
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.all(24),
            //   width: double.infinity,
            //   child: OutlinedButton(
            //     onPressed: () async {
            //       await AuthService().signOut();
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (builder) => const SignInScreen(),
            //         ),
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       foregroundColor: AppColorCode.warningColor_500,
            //       padding: EdgeInsets.symmetric(
            //         vertical: 16,
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(
            //           12,
            //         ),
            //       ),
            //       side: const BorderSide(
            //           color: AppColorCode.warningColor_500, width: 2),
            //     ),
            //     child: const Text(
            //       'Logout',
            //       style: TextStyle(
            //         fontWeight: FontWeight.w700,
            //         fontFamily: 'Poppins',
            //         fontSize: 20,
            //         decoration: TextDecoration.underline,
            //         decorationColor: AppColorCode.warningColor_500,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
