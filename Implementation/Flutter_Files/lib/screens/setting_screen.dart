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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    backgroundColor: AppColorCode.neutralColor_50,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text('Setting'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications_active),
                    title: Text('Notification'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  ListTile(
                    leading: Icon(Icons.signal_wifi_4_bar_rounded),
                    title: Text('Connect Cradle'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('About Us'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => const SignInScreen(),
                ),
              );
            },
            child: const Text('Logout'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
