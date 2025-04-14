class MoistureSensorData {
  final num timestamp;
  final String type;
  final String value;

  MoistureSensorData({
    required this.timestamp,
    required this.type,
    required this.value,
  });

  factory MoistureSensorData.fromJson(Map<String, dynamic> json) {
    return MoistureSensorData(
      timestamp: json['timestamp'] ?? 0,
      type: json['type'] ?? '',
      value: json['value'] ?? '',
    );
  }

  MoistureSensorData copyWith({
    num? timestamp,
    String? type,
    String? value,
  }) {
    return MoistureSensorData(
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'type': type,
      'value': value,
    };
  }
}

