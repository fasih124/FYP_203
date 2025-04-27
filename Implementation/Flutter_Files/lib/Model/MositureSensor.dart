class CradleSensorData {
  final num timestamp;
  final String type;
  final String value;

  CradleSensorData({
    required this.timestamp,
    required this.type,
    required this.value,
  });

  factory CradleSensorData.fromJson(Map<String, dynamic> json) {
    return CradleSensorData(
      timestamp: json['timestamp'] ?? 0,
      type: json['type'] ?? '',
      value: json['value'] ?? '',
    );
  }

  CradleSensorData copyWith({
    num? timestamp,
    String? type,
    String? value,
  }) {
    return CradleSensorData(
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

