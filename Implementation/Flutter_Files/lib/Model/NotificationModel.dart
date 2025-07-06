// class NotificationModel {
//   final num timestamp;
//   final String type;
//   final String message;
//   final bool acknowledged;
//   final String parentId;
//   final String notificationId;
//
//   NotificationModel({
//     required this.timestamp,
//     required this.type,
//     required this.message,
//     required this.acknowledged,
//     required this.parentId,
//     required this.notificationId,
//   });
//
//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       timestamp: json['timestamp'] ?? 0,
//       type: json['type'] ?? '',
//       message: json['message'] ?? '',
//       acknowledged: json['acknowledged'] ?? false,
//       parentId: json['parentId'] ?? '',
//       notificationId: json['notificationId'] ?? '',
//     );
//   }
//
//   NotificationModel copyWith({
//     num? timestamp,
//     String? type,
//     String? message,
//     bool? acknowledged,
//     String? parentId,
//     String? notificationId,
//   }) {
//     return NotificationModel(
//       timestamp: timestamp ?? this.timestamp,
//       type: type ?? this.type,
//       message: message ?? this.message,
//       acknowledged: acknowledged ?? this.acknowledged,
//       parentId: parentId ?? this.parentId,
//       notificationId: notificationId ?? this.notificationId,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'timestamp': timestamp,
//       'type': type,
//       'message': message,
//       'acknowledged': acknowledged,
//       'parentId': parentId,
//       'notificationId': notificationId,
//     };
//   }
//
//   /// ✅ Getter to convert timestamp to DateTime
//   DateTime get dateTime =>
//       DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
//
//   /// ✅ Returns just the date (for grouping)
//   String get dateOnly =>
//       "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
// }


class NotificationModel {
  final String firebaseKey; // 🔴 Used for deletion from Firebase
  final num timestamp;
  final String type;
  final String message;
  final bool acknowledged;
  final String parentId;
  final String notificationId;

  NotificationModel({
    required this.firebaseKey,
    required this.timestamp,
    required this.type,
    required this.message,
    required this.acknowledged,
    required this.parentId,
    required this.notificationId,
  });

  /// 🔁 Factory constructor accepts Firebase key separately
  factory NotificationModel.fromJson(Map<String, dynamic> json, String key) {
    return NotificationModel(
      firebaseKey: key,
      timestamp: json['timestamp'] ?? 0,
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      acknowledged: json['acknowledged'] ?? false,
      parentId: json['parentId'] ?? '',
      notificationId: json['notificationId'] ?? '',
    );
  }

  /// 🧱 Convert to JSON (Firebase key not included here)
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'type': type,
      'message': message,
      'acknowledged': acknowledged,
      'parentId': parentId,
      'notificationId': notificationId,
    };
  }

  /// 🪄 Copy with optional overrides
  NotificationModel copyWith({
    String? firebaseKey,
    num? timestamp,
    String? type,
    String? message,
    bool? acknowledged,
    String? parentId,
    String? notificationId,
  }) {
    return NotificationModel(
      firebaseKey: firebaseKey ?? this.firebaseKey,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      message: message ?? this.message,
      acknowledged: acknowledged ?? this.acknowledged,
      parentId: parentId ?? this.parentId,
      notificationId: notificationId ?? this.notificationId,
    );
  }

  /// 📆 Get DateTime from timestamp
  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);

  /// 📅 Date string for grouping
  String get dateOnly =>
      "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}
