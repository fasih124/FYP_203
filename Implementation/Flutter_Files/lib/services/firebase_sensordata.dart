
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/Model/MositureSensor.dart';

class MoistureSensorService  {
  static  Stream<MoistureSensorData> getMoistureSensorData() {
    final DatabaseReference _dbRef =
        FirebaseDatabase.instance.ref('sensors/cradle1/MositureSensor');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return MoistureSensorData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid or null moisture data');
      }
      // final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      // return MoistureSensorData.fromJson(data);
    });
  }
}


