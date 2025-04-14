
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/Model/MositureSensor.dart';

class MoistureSensorService  {
  static  Stream<MoistureSensorData> getMoistureSensorData() {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/cradle1/MositureSensor');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return MoistureSensorData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid or null moisture data');
      }

    });
  }
}
