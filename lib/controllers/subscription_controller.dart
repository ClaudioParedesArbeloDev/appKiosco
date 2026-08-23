import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subscription_model.dart';
import '../providers/subscription_providers.dart';

class SubscriptionController extends AsyncNotifier<SubscriptionModel?> {
  @override
  Future<SubscriptionModel?> build() {
    return ref.read(subscriptionRepositoryProvider).current();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(subscriptionRepositoryProvider).current());
  }

  /// No toca el estado de la suscripción: solo pide el link de pago para
  /// que la pantalla lo abra en el navegador.
  Future<String> startCheckout() {
    return ref.read(subscriptionRepositoryProvider).checkout();
  }
}

final subscriptionControllerProvider =
    AsyncNotifierProvider<SubscriptionController, SubscriptionModel?>(
  SubscriptionController.new,
);
