class CradleModelData {
  final String model;

  CradleModelData({required this.model});

  factory CradleModelData.fromJson(Map<String, dynamic> json) {
    return CradleModelData(
      model: json['Model'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Model': model,
    };
  }
}
