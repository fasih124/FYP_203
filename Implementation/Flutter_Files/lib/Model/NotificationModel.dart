class NotificationModel {
  final num timestamp;
  final String type;
  final String message;
  final bool acknowledged;
  final String parentId;
  final String notificationId;

  NotificationModel({
    required this.timestamp,
    required this.type,
    required this.message,
    required this.acknowledged,
    required this.parentId,
    required this.notificationId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      timestamp: json['timestamp'] ?? 0,
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      acknowledged: json['acknowledged'] ?? false,
      parentId: json['parentId'] ?? '',
      notificationId: json['notificationId'] ?? '',
    );
  }

  NotificationModel copyWith({
    num? timestamp,
    String? type,
    String? message,
    bool? acknowledged,
    String? parentId,
    String? notificationId,
  }) {
    return NotificationModel(
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      message: message ?? this.message,
      acknowledged: acknowledged ?? this.acknowledged,
      parentId: parentId ?? this.parentId,
      notificationId: notificationId ?? this.notificationId,
    );
  }

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

  /// ✅ Getter to convert timestamp to DateTime
  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);

  /// ✅ Returns just the date (for grouping)
  String get dateOnly =>
      "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}
