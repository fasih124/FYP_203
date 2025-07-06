import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/services/notification_service.dart';

class FirebaseNotificationListener {
  static final Set<String> _notifiedIds = {};
  static bool _isListening = false;

  static Future<void> startListening() async {
    if (_isListening) return;
    _isListening = true;

    print("👂 Firebase listener starting...");

    // ✅ Wait until Firebase is ready
    final app = await Firebase.app();
    print("🌐 Firebase App initialized with name: ${app.name}");

    final db = FirebaseDatabase.instanceFor(
      app: app,
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );
    final ref = db.ref("notifications");

    ref.onChildAdded.listen((event) {
      print("📥 New child added to /notifications");

      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data == null) {
        print("⚠️ Data is null");
        return;
      }

      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      print("🔐 Current user UID: $currentUserId");

      if (currentUserId == null) {
        print("🚫 No user logged in");
        return;
      }

      if (data["parentId"] != currentUserId) {
        print("⛔ Notification ignored: not for this user");
        return;
      }

      final String notifId = data["notificationId"] ?? event.snapshot.key!;
      if (_notifiedIds.contains(notifId)) {
        print("🔁 Duplicate notification: $notifId");
        return;
      }

      _notifiedIds.add(notifId);

      final String title = "CareNest Alert";
      final String body = data["message"] ?? "New cradle alert";
      final int id = data["timestamp"] ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;

      print("🔔 Showing local notification: $title | $body");

      NotificationService.showNotification(
        id: id,
        title: title,
        body: body,
      );
    });
  }


// static Future<void> startListening() async {
  //   if (_isListening) return; // Prevent duplicate listeners
  //   _isListening = true;
  //
  //   print("👂 Firebase listener starting...");
  //
  //   // ✅ Ensure Firebase is initialized
  //   final app = Firebase.app();
  //
  //   final db = FirebaseDatabase.instanceFor(
  //     app: app,
  //     databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
  //   );
  //   final ref = db.ref("notifications");
  //
  //   ref.onChildAdded.listen((event) {
  //     print("📥 New child added to /notifications");
  //
  //     final data = event.snapshot.value as Map<dynamic, dynamic>?;
  //
  //     if (data == null) {
  //       print("⚠️ Data is null");
  //       return;
  //     }
  //
  //     final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  //     print("🔐 Current user UID: $currentUserId");
  //
  //     if (currentUserId == null) {
  //       print("🚫 No user logged in");
  //       return;
  //     }
  //
  //     if (data["parentId"] != currentUserId) {
  //       print("⛔ Notification ignored: not for this user");
  //       return;
  //     }
  //
  //     final String notifId = data["notificationId"] ?? event.snapshot.key!;
  //     if (_notifiedIds.contains(notifId)) {
  //       print("🔁 Duplicate notification: $notifId");
  //       return;
  //     }
  //
  //     _notifiedIds.add(notifId);
  //
  //     final String title = "CareNest Alert";
  //     final String body = data["message"] ?? "New cradle alert";
  //     final int id = data["timestamp"] ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //
  //     print("🔔 Showing local notification: $title | $body");
  //
  //     NotificationService.showNotification(
  //       id: id,
  //       title: title,
  //       body: body,
  //     );
  //   });
  // }
}


//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:fyp_203/services/notification_service.dart';
//
// class FirebaseNotificationListener {
//   static final _db = FirebaseDatabase.instanceFor(
//     app: Firebase.app(),
//     databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
//   );
//   static final _ref = _db.ref("notifications");
//   static final Set<String> _notifiedIds = {};
//
//   static void startListening() {
//     print("👂 Firebase listener started...");
//
//     _ref.onChildAdded.listen((event) {
//       print("📥 New child added to /notifications");
//
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;
//
//       if (data == null) {
//         print("⚠️ Data is null");
//         return;
//       }
//
//       final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//       print("🔐 Current user UID: $currentUserId");
//
//       if (currentUserId == null) {
//         print("🚫 No user logged in");
//         return;
//       }
//
//       if (data["parentId"] != currentUserId) {
//         print("⛔ Notification ignored: not for this user");
//         return;
//       }
//
//       final String notifId = data["notificationId"] ?? event.snapshot.key!;
//       if (_notifiedIds.contains(notifId)) {
//         print("🔁 Duplicate notification: $notifId");
//         return;
//       }
//
//       _notifiedIds.add(notifId);
//
//       final String title = "CareNest Alert";
//       final String body = data["message"] ?? "New cradle alert";
//       final int id = data["timestamp"] ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
//
//       print("🔔 Showing local notification: $title | $body");
//
//       NotificationService.showNotification(
//         id: id,
//         title: title,
//         body: body,
//       );
//     });
//   }
// }



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:fyp_203/services/notification_service.dart';
//
// class FirebaseNotificationListener {
//
//   final database = FirebaseDatabase.instanceFor(
//     databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
//   );
//   final _ref = database.ref("notifications");
//
//   // static final DatabaseReference _ref =
//
//
//   static Set<String> _notifiedIds = {};
//
//   static void startListening() {
//     print("👂 Firebase listener started...");
//
//     _ref.onChildAdded.listen((event) {
//       print("📥 New child added to /notifications");
//
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;
//
//       if (data == null) {
//         print("⚠️ Data is null");
//         return;
//       }
//
//       final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//       print("🔐 Current user UID: $currentUserId");
//
//       if (currentUserId == null) {
//         print("🚫 No user logged in");
//         return;
//       }
//
//       if (data["parentId"] != currentUserId) {
//         print("⛔ Notification ignored: not for this user");
//         return;
//       }
//
//       final String notifId = data["notificationId"] ?? event.snapshot.key!;
//       if (_notifiedIds.contains(notifId)) {
//         print("🔁 Duplicate notification: $notifId");
//         return;
//       }
//
//       _notifiedIds.add(notifId);
//
//       final String title = "CareNest Alert";
//       final String body = data["message"] ?? "New cradle alert";
//       final int id = data["timestamp"] ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
//
//       print("🔔 Showing local notification: $title | $body");
//
//       NotificationService.showNotification(
//         id: id,
//         title: title,
//         body: body,
//       );
//     });
//   }
// }

//   static final DatabaseReference _ref =
//
//
//   static Set<String> _notifiedIds = {}; // Prevent duplicates
//
//   static void startListening() {
//     _ref.onChildAdded.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;
//
//       if (data == null) return;
//
//       // Extract current user ID
//       final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//       if (currentUserId == null) return;
//
//       // Filter by parentId match
//       if (data["parentId"] != currentUserId) return;
//
//       // Prevent duplicate alerts
//       final String notifId = data["notificationId"] ?? event.snapshot.key!;
//       if (_notifiedIds.contains(notifId)) return;
//
//       // Mark as notified
//       _notifiedIds.add(notifId);
//
//       // Get content
//       final String title = "Alert from CareNest";
//       final String body = data["message"] ?? "New cradle alert";
//
//       // Use timestamp or generate ID
//       final int id = data["timestamp"] ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
