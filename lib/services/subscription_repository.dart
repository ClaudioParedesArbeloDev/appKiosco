import '../models/subscription_model.dart';
import 'subscription_api_service.dart';

class SubscriptionRepository {
  SubscriptionRepository(this._api);

  final SubscriptionApiService _api;

  Future<SubscriptionModel?> current() async {
    final response = await _api.show();
    final data = response.data['subscription'];

    return data == null ? null : SubscriptionModel.fromJson(data);
  }

  /// Devuelve el link de pago de Mercado Pago para abrir en el navegador.
  Future<String> checkout() async {
    final response = await _api.checkout();
    return response.data['init_point'] as String;
  }
}
