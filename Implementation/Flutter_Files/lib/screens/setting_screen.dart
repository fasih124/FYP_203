import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';

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
                      // Back button action
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text('Setting'),
              ),
            ],
          ),
        ),
          SizedBox(height: 24),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
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
          SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            child: Text('Logout'),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
