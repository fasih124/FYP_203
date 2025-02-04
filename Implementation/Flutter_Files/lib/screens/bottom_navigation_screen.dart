import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/home_screen.dart';
import 'package:fyp_203/screens/notification_screen.dart';
import 'package:fyp_203/screens/video_stream_screen.dart';



class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    VideoStreamScreen(),
    NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: AppColorCode.primaryColor_500,
          selectedItemColor: AppColorCode.White_shade,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
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
      ),
    );
  }
}
