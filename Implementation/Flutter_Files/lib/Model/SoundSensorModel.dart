class SoundSensorData {
  final num timestamp;
  final String type;
  final String value;
  final bool enable;
  final bool isplaying;

  SoundSensorData({
    required this.timestamp,
    required this.type,
    required this.value,
    required this.enable,
    required this.isplaying,
  });

  factory SoundSensorData.fromJson(Map<String, dynamic> json) {
    return SoundSensorData(
      timestamp: json['timestamp'] ?? 0,
      type: json['type'] ?? '',
      value: json['value']?.toString() ?? '',
      enable: json['enable'] ?? false,
      isplaying: json['isplaying'] ?? false,
    );
  }

  SoundSensorData copyWith({
    num? timestamp,
    String? type,
    String? value,
    bool? enable,
    bool? isplaying,
  }) {
    return SoundSensorData(
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      value: value ?? this.value,
      enable: enable ?? this.enable,
      isplaying: isplaying ?? this.isplaying,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'type': type,
      'value': value,
      'enable': enable,
      'isplaying': isplaying,
    };
  }
}

