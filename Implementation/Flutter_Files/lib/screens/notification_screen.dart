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
      .map((e) =>
          NotificationModel.fromJson(Map<String, dynamic>.from(e.value), e.key))
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
  String? cradleModel;
  bool isModelLoading = true;

  Future<void> loadCradleModel() async {
    final model = await CradleService.getCradleModelForUser(widget.parentId);
    setState(() {
      cradleModel = model;
      isModelLoading = false;
    });
  }



  @override
  void initState() {
    super.initState();
    _notificationFuture = getNotificationsForParent(widget.parentId);
    loadCradleModel(); // ← add thi
  }

  Future<void> deleteNotification(String firebaseKey) async {
    final ref = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    ).ref('notifications/$firebaseKey');

    await ref.remove();
    setState(() {
      _notificationFuture = getNotificationsForParent(widget.parentId);
    });
  }

  Future<void> deleteOldNotifications(int keepCount) async {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final snapshot = await database.ref("notifications").get();

    if (!snapshot.exists) return;

    final raw = Map<String, dynamic>.from(snapshot.value as Map);

    // Convert all entries to NotificationModel and include firebaseKey
    final notifications = raw.entries
        .map((e) => NotificationModel.fromJson(Map<String, dynamic>.from(e.value), e.key))
        .toList();

    // Sort by timestamp DESC (latest first)
    notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // Keep only latest `keepCount` notifications
    final toDelete = notifications.skip(keepCount);

    // Delete each from Firebase
    for (var notif in toDelete) {
      await database.ref("notifications/${notif.firebaseKey}").remove();
    }

    // Refresh screen
    setState(() {
      _notificationFuture = getNotificationsForParent(widget.parentId);
    });
  }



  final Map<String, String> notificationIconMap = {
    'temperature_alert': 'assets/icons_img/temp_Icon.png',
    'moisture_alert': 'assets/icons_img/Droplet.png',
    'aqi_alert': 'assets/icons_img/aqi_icon.png',
    'baby_absent_alert': 'assets/icons_img/weight_icon.png',
    'crying_alert': 'assets/icons_img/sound_icon.png',
  };

  final Map<String, Color> notificationColorMap = {
    'temperature_alert': Colors.red,
    'baby_absent_alert': Colors.green,
    'aqi_alert': Colors.orange,
    'moisture_alert': Colors.indigo,
    'crying_alert': Colors.purple,
  };

  final Map<String, Color> notificationShadeMap = {
    'temperature_alert': Colors.redAccent.shade100,
    'baby_absent_alert': Colors.green.shade300,
    'aqi_alert': Colors.orangeAccent.shade100,
    'moisture_alert': Colors.indigoAccent.shade200,
    'crying_alert': Colors.purpleAccent.shade100,
  };

  String getNotificationIcon(String type) {
    return notificationIconMap[type] ?? 'assets/icons_img/default_icon.png';
  }

  Color getNotificationColor(String type) {
    return notificationColorMap[type] ?? Colors.grey.shade600;
  }

  Color getNotificationShade(String type) {
    return notificationShadeMap[type] ?? Colors.grey.shade300;
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
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [

                      isModelLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        'Cradle : ${cradleModel ?? "Not Found"}',
                        style: const TextStyle(
                          color: AppColorCode.White_shade,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColorCode.neutralColor_600, width: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon:  const Icon(Icons.delete_sweep, color: AppColorCode.neutralColor_600),
                          label: const Text(
                            "Clear",
                            style: TextStyle(color: AppColorCode.neutralColor_600),
                          ),
                          // tooltip: 'Clear old notifications',
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Clear Old Notifications"),
                                content: const Text(
                                  "This will Delete all but keep the latest 10 notifications?",
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () => Navigator.of(context).pop(false),
                                  ),
                                  TextButton(
                                    child: const Text("Delete"),
                                    onPressed: () => Navigator.of(context).pop(true),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await deleteOldNotifications(10); // ✅ keep 10 latest
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Old notifications deleted")),
                              );
                            }
                          },
                        ),
                      ),
                    ],
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
          const SizedBox(
            height: 15,
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
                                  // color: Colors.red.shade600, //Colors.red,
                                  color: getNotificationColor(notif.type),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: getNotificationColor(notif.type).withOpacity(0.6),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  //  tileColor: Colors.red,
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: getNotificationShade(notif.type),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        getNotificationIcon(notif
                                            .type), //'assets/icons_img/temp_Icon.png',
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
                                      color: Colors.white,
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
                                        decorationThickness: 1),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                                    onPressed: () {
                                      deleteNotification(notif.firebaseKey); //
                                    },
                                    hoverColor: Colors.white60,
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
