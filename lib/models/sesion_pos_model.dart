class SesionPosModel {
  const SesionPosModel({required this.id, required this.pairingToken});

  final String id;
  final String pairingToken;

  factory SesionPosModel.fromJson(Map<String, dynamic> json) {
    return SesionPosModel(
      id: json['id'] as String,
      pairingToken: json['pairing_token'] as String,
    );
  }
}
