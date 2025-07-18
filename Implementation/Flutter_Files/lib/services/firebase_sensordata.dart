
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp_203/Model/CradleSensorModel.dart';

import '../Model/BabyPresenceModel.dart';
import '../Model/CardelModel.dart';
import '../Model/SoundSensorModel.dart';

class MoistureSensorService  {
  static  Stream<CradleSensorData> getMoistureSensorData(String cradleModel) {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/$cradleModel/MositureSensor');

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
  static  Stream<CradleSensorData> getTemperatureSensorData(String cradleModel) {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/$cradleModel/TempSensor');

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
  static  Stream<CradleSensorData> getAQISensorData(String cradleModel) {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/$cradleModel/AQISensor');

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
  static  Stream<SoundSensorData> getSoundSensorData(String cradleModel) {

    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/$cradleModel/SoundSensor');

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
  static Stream<BabyPresenceSensorData> getBabyPresenceSensorData(String cradleModel) {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final DatabaseReference _dbRef = database.ref('sensors/$cradleModel/babyPresence');

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


class CradleService {
  static Future<String?> getModelNameForCradle(String cradleKey) async {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final modelRef = database.ref("cradles/$cradleKey/model");
    final snapshot = await modelRef.get();

    if (snapshot.exists && snapshot.value is String) {
      return snapshot.value as String;
    }
    return null;
  }


  static Future<String?> getCradleModelForUser(String userId) async {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
    );

    final cradlesRef = database.ref("cradles");

    final snapshot = await cradlesRef.get();

    if (snapshot.exists && snapshot.value is Map) {
      final cradleMap = Map<String, dynamic>.from(snapshot.value as Map);

      for (var entry in cradleMap.entries) {
        final cradleData = Map<String, dynamic>.from(entry.value);

        if (cradleData["parentId"] == userId) {
          return entry.key; // This is the cradle model name (e.g., "cradle1")
        }
      }
    }

    return null;
  }
}
