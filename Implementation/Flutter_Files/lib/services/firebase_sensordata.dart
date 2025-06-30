
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/Model/CradleSensorModel.dart';

import '../Model/BabyPresenceModel.dart';
import '../Model/CardelModel.dart';
import '../Model/SoundSensorModel.dart';

class MoistureSensorService  {
  static  Stream<CradleSensorData> getMoistureSensorData() {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/cradle1/MositureSensor');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return CradleSensorData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid or null moisture data');
      }

    });
  }
}


class TemperatureSensorService  {
  static  Stream<CradleSensorData> getTemperatureSensorData() {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/cradle1/TempSensor');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return CradleSensorData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid or null moisture data');
      }

    });
  }
}


class AQISensorService  {
  static  Stream<CradleSensorData> getAQISensorData() {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/cradle1/AQISensor');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return CradleSensorData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid or null moisture data');
      }

    });
  }
}

class SoundSensorService  {
  static  Stream<SoundSensorData> getSoundSensorData() {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/cradle1/SoundSensor');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return SoundSensorData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid or null moisture data');
      }

    });
  }
}


class BabyPresenceSensorService {
  static Stream<BabyPresenceSensorData> getBabyPresenceSensorData() {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/cradle1/babyPresence');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return BabyPresenceSensorData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid or null baby presence data');
      }
    });
  }
}


class CradleModelService {
  static Stream<CradleModelData> getCradleModel() {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('cradles');

    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return CradleModelData.fromJson(Map<String, dynamic>.from(data));
      } else {
        throw Exception('Invalid cradle model data');
      }
    });
  }
}