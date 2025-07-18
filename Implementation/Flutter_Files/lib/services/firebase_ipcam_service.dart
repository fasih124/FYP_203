import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/firebase_options.dart'; // <- make sure this exists

class FirebaseIpcamService {
  static Future<String?> getIpcamUrl() async {
    try {
      final db = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app/",// <-- put your actual DB URL here
      );

      final ref = db.ref('camlink');
      final snapshot = await ref.get().timeout(const Duration(seconds: 5));

      if (snapshot.exists) {
        return snapshot.value.toString();
      } else {
        print("❌ Camera URL not found in database.");
        return null;
      }
    } on TimeoutException {
      print("❌ Timeout while fetching IP camera URL.");
      return null;
    } catch (e) {
      print("❌ Error fetching ipcam: $e");
      return null;
    }
  }
}

//
// class FirebaseIpcamService {
//   static Future<String?> getIpcamUrl() async {
//     try {
//       final DatabaseReference ref = FirebaseDatabase.instance.ref('camlink');
//
//       final snapshot = await ref.get().timeout(const Duration(seconds: 5)); // <-- timeout here
//
//       if (snapshot.exists) {
//         return snapshot.value.toString();
//       } else {
//         print("Camera URL not found in database.");
//         return null;
//       }
//     } on TimeoutException catch (_) {
//       print("❌ Timeout while fetching IP camera URL.");
//       return null;
//     } catch (e) {
//       print("❌ Error fetching ipcam: $e");
//       return null;
//     }
//   }
// }

// class FirebaseIpcamService {
//   static Future<String?> getIpcamUrl() async {
//     try {
//       final DatabaseReference ref = FirebaseDatabase.instance.ref('camlink');
//       final snapshot = await ref.get();
//
//       if (snapshot.exists) {
//         return snapshot.value.toString();
//       } else {
//         print("Camera URL not found in database.");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching ipcam: $e");
//       return null;
//     }
//   }
// }

//
// class FirebaseIpcamService {
//   static Future<String?> getIpcamUrl() async {
//     try {
//       final ref = FirebaseDatabase.instance.ref('camlink');
//       final snapshot = await ref.get();
//       if (snapshot.exists) {
//         return snapshot.value.toString();
//       }
//     } catch (e) {
//       print('Error fetching ipcam: $e');
//     }
//     return null;
//   }
// }

