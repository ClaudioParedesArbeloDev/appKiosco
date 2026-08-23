import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/subscription_model.dart';

class SubscriptionStatusCard extends StatelessWidget {
  const SubscriptionStatusCard({super.key, required this.subscription});

  final SubscriptionModel subscription;

  ({String label, Color color, String message}) get _statusInfo {
    final days = subscription.daysRemaining;

    return switch (subscription.status) {
      'trialing' => (
          label: 'Período de prueba',
          color: AppColors.primary,
          message: days == null
              ? 'Estás en el período de prueba gratis.'
              : 'Te quedan $days días de prueba gratis.',
        ),
      'active' => (
          label: 'Activa',
          color: AppColors.success,
          message: days == null
              ? 'Tu suscripción está activa.'
              : 'Próximo pago en $days días.',
        ),
      'past_due' => (
          label: 'Pago pendiente',
          color: AppColors.warning,
          message: days == null
              ? 'Tenés unos días de gracia antes de que se corte el acceso.'
              : 'Tenés $days días de gracia antes de que se corte el acceso.',
        ),
      'expired' => (
          label: 'Vencida',
          color: AppColors.danger,
          message: 'Tu suscripción está vencida. Pagá para reactivar el acceso.',
        ),
      'canceled' => (
          label: 'Cancelada',
          color: AppColors.danger,
          message: 'Tu suscripción fue cancelada.',
        ),
      _ => (label: subscription.status, color: AppColors.primaryLight, message: ''),
    };
  }

  @override
  Widget build(BuildContext context) {
    final info = _statusInfo;

    return Card(
      color: AppColors.backgroundDark,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: info.color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(
                  info.label,
                  style: TextStyle(color: info.color, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Plan ${subscription.planName}',
              style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${subscription.monthlyPriceInPesos.toStringAsFixed(2)} / mes',
              style: const TextStyle(color: AppColors.primaryLight),
            ),
            const SizedBox(height: 16),
            Text(info.message, style: const TextStyle(color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}
