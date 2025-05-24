class CradleSensorData {
  final num timestamp;
  final String type;
  final String value;
  final bool enable;

  CradleSensorData({
    required this.timestamp,
    required this.type,
    required this.value,
    required this.enable,
  });

  factory CradleSensorData.fromJson(Map<String, dynamic> json) {
    return CradleSensorData(
      timestamp: json['timestamp'] ?? 0,
      type: json['type'] ?? '',
      value: json['value'] ?? '',
      enable: json['enable'] ?? false,
    );
  }

  CradleSensorData copyWith({
    num? timestamp,
    String? type,
    String? value,
    bool? enable,
  }) {
    return CradleSensorData(
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      value: value ?? this.value,
      enable: enable ?? this.enable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'type': type,
      'value': value,
      'enable': enable,
    };
  }
}

