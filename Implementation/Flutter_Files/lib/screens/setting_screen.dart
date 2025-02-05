import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      fontSize: 24,
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
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/profile_icon.png',
                        width: 25,
                        height: 23,
                      ),
                      title: Text('Profile'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/small_gear_icon.png',
                        width: 25,
                        height: 23,
                      ),
                      title: Text('Notification'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/connect_icon.png',
                        width: 25,
                        height: 23,
                      ),
                      title: Text('Connect Cradle'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    Divider(
                      color: Colors.grey.shade300, // Line color
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        'assets/icons_img/about_icon.png',
                        width: 25,
                        height: 23,
                      ),
                      title: Text('About Us'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const SignInScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColorCode.warningColor_500,
                   padding: EdgeInsets.symmetric(vertical: 16,),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
