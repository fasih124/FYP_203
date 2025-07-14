import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/screens/home_screen.dart';
import 'package:fyp_203/screens/notification_screen.dart';
import 'package:fyp_203/screens/video_stream_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fyp_203/main.dart'; // To access global `flutterLocalNotificationsPlugin`

int _unreadCount = 0;
DatabaseReference? _notifRef;
Stream<DatabaseEvent>? _notifStream;


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override

  void _listenToNotifications(String parentId) {
    // print('Firebase UID: $parentId');
    // _notifRef = FirebaseDatabase.instance.ref("notifications");
    _notifRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    ).ref("notifications");

    _notifStream = _notifRef!.onChildAdded;

    _notifStream!.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      if (data['parentId'] == parentId && data['acknowledged'] == false) {
        _unreadCount++;
        _showLocalNotification(data['message']);
        setState(() {});
      }
    });


  }

  void _showLocalNotification(String message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'care_nest_channel',
      'CareNest Alerts',
      channelDescription: 'Alerts from the CareNest cradle',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'CareNest Notification',
      message,
      notificationDetails,
    );
  }


  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      _listenToNotifications(uid);
    }

  }

  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final List<Widget> _screens = [
  //   HomeScreen(),
  //   VideoStreamScreen(),
  //   NotificationScreen(parentId: 'F6hVlGjbukP96l0hWAgi2RkjcFE2',),
  // ];


  Widget build(BuildContext context) {

    // ✅ Get current user UID as parentId
    final user = FirebaseAuth.instance.currentUser;
    final parentId = user?.uid ?? ''; // fallback if user is null

    // ✅ Use it in the screen list dynamically
    final List<Widget> _screens = [
      HomeScreen(),
      VideoStreamScreen(),
      NotificationScreen(parentId: parentId),
    ];


    return  Scaffold(
      backgroundColor: AppColorCode.neutralColor_500,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColorCode.primaryColor_600,
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
          // BottomNavigationBarItem(
          //   icon: Stack(
          //     children: [
          //       const Icon(Icons.notifications_none),
          //       Positioned(
          //         right: 0,
          //         child: Container(
          //           padding: const EdgeInsets.all(4),
          //           decoration: const BoxDecoration(
          //             color: Colors.red,
          //             shape: BoxShape.circle,
          //           ),
          //           child: const Text(
          //             '3',
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 12,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          //   label: 'Notification',
          // ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none),
                if (_unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10, // Size of the red dot
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
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
