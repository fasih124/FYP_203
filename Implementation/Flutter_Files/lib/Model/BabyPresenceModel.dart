class BabyPresenceSensorData {
  final bool isPresent;

  BabyPresenceSensorData({required this.isPresent});

  factory BabyPresenceSensorData.fromJson(Map<String, dynamic> json) {
    return BabyPresenceSensorData(
      isPresent: json['ispresent'] ?? false,
    );
  }

  BabyPresenceSensorData copyWith({bool? isPresent}) {
    return BabyPresenceSensorData(
      isPresent: isPresent ?? this.isPresent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ispresent': isPresent,
    };
  }
}
