class PointDeviceModel {
  const PointDeviceModel({required this.id, required this.operatingMode});

  final String id;
  final String? operatingMode;

  factory PointDeviceModel.fromJson(Map<String, dynamic> json) {
    return PointDeviceModel(
      id: json['id'] as String,
      operatingMode: json['operating_mode'] as String?,
    );
  }
}
