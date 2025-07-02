import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/Component/notification_tile_widget.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/setting_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../Model/NotificationModel.dart';
import '../Model/CardelModel.dart';
import '../services/firebase_sensordata.dart';
import 'option_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fyp_203/services/notification_service.dart';

Future<List<NotificationModel>> getNotificationsForParent(
    String parentId) async {
  final database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  final snapshot = await database.ref("notifications").get();
  // final snapshot =





  if (!snapshot.exists) return [];

  final raw = Map<String, dynamic>.from(snapshot.value as Map);

  final filtered = raw.entries
      .map(
          (e) => NotificationModel.fromJson(Map<String, dynamic>.from(e.value)))
      .where((notif) => notif.parentId == parentId)
      .toList();

  filtered.sort((a, b) => b.timestamp.compareTo(a.timestamp)); // latest first
  return filtered;
}



class NotificationScreen extends StatefulWidget {
  final String parentId; // e.g., 'parent1'
  const NotificationScreen({super.key, required this.parentId});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _notificationFuture;

  @override
  void initState() {
    super.initState();
    _notificationFuture = getNotificationsForParent(widget.parentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            decoration: const BoxDecoration(
              color: AppColorCode.primaryColor_500,
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
                        'Notification',
                        style: TextStyle(
                          color: AppColorCode.White_shade,
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
                          'assets/icons_img/gear_2_icon.png',
                          width: 25,
                          height: 23,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                      color: AppColorCode.White_shade, // Line color
                      thickness: 1, // Line thickness
                      indent: 0, // Start padding
                      endIndent: 0 // End padding
                      ),
                  const SizedBox(
                    height: 6,
                  ),
                  // const Text(
                  //   'Cradle : Modelx-FYP203',
                  //   style: TextStyle(
                  //     color: AppColorCode.White_shade,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  StreamBuilder<CradleModelData>(
                    stream: CradleModelService.getCradleModel(),
                    builder: (context, snapshot) {
                      String modelName = '...';
                      if (snapshot.hasData) {
                        modelName = snapshot.data!.model;
                      } else if (snapshot.hasError) {
                        modelName = 'Error';
                      }

                      return Text(
                        'Cradle : $modelName',
                        style: const TextStyle(
                          color: AppColorCode.White_shade,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<List<NotificationModel>>(
                        future: _notificationFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No notifications yet.'));
                          }

                          final notifications = snapshot.data!;

                          return ListView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), // to allow full scroll by outer SingleChildScrollView
                            shrinkWrap: true,
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              // final notif = notifications[index];
                              // final time = DateFormat('MMM dd, yyyy – hh:mm a').format(notif.dateTime);

                              final notif = notifications[index];
                              final formattedTime =
                                  DateFormat('MMM dd, yyyy – hh:mm a')
                                      .format(notif.dateTime);
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade600, //Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  //  tileColor: Colors.red,
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors
                                          .red.shade300, //Colors.red.shade300,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/icons_img/temp_Icon.png', //'assets/icons_img/temp_Icon.png',
                                        width: 25,
                                        height: 23,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    formattedTime,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      // decoration: TextDecoration.underline,
                                      // decorationColor: Colors.white,
                                      color: Colors.white,
                                      // decorationThickness: 2
                                    ),
                                  ),
                                  title: Text(
                                    notif.message,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      color: Colors.white,
                                      decorationThickness: 1
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
