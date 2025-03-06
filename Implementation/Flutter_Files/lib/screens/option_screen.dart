import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';
import 'package:fyp_203/services/firebase_auth.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
   bool isPlaying = false;
  bool getTemp = false;
  bool getWeight = false;
  bool getSound = false;
  bool getAQI = false;

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
                    'Options'.toUpperCase(),
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
                            });
                          }),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/weight_icon.png',
                        width: 25,
                        height: 23,
                        color: AppColorCode.Black_shade,
                      ),
                      title: Text('Weight'),
                      trailing:Switch(
                          value: getWeight,
                          activeColor: AppColorCode.play_500,
                          activeTrackColor:  Colors.grey.shade400,
                          inactiveThumbColor: AppColorCode.stop_500,
                          inactiveTrackColor:  Colors.grey.shade400,
                          onChanged: (value) {
                            setState(() {
                              getWeight = value;
                            });
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
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(24),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    if(!isPlaying){
                      isPlaying=true;
                    }else{
                      isPlaying=false;
                    }

                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isPlaying ? AppColorCode.stop_500 : AppColorCode.play_500,
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
                      color: AppColorCode.Black_shade, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons_img/sound_icon.png',
                      width: 25,
                      height: 23,
                      color: AppColorCode.Black_shade,
                    ),
                    const Text(
                      'Play / Pause lullaby',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: AppColorCode.Black_shade,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
