import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/point_device_model.dart';
import '../../../providers/mercado_pago_providers.dart';
import '../../../services/mercado_pago_repository.dart';

/// Diálogo que arma la orden de cobro en un terminal Point y espera a que
/// el cliente pase la tarjeta, mostrando el estado en vivo. Devuelve `true`
/// por Navigator.pop si el pago se aprobó, o `false`/null si se canceló o
/// falló — quien lo abre decide qué hacer con la venta según eso.
///
/// Nota: los strings de estado que devuelve Mercado Pago para un intento de
/// pago no están 100% documentados con una lista cerrada — la detección de
/// aprobado/fallido en `MercadoPagoRepository.consultarEstado` es una
/// heurística por palabras clave, pendiente de confirmar contra una cuenta
/// y un Point reales.
class PointChargeDialog extends ConsumerStatefulWidget {
  const PointChargeDialog({super.key, required this.montoCentavos});

  final int montoCentavos;

  @override
  ConsumerState<PointChargeDialog> createState() => _PointChargeDialogState();
}

enum _Etapa { cargandoDispositivos, eligiendoDispositivo, esperandoPago, aprobado, error }

class _PointChargeDialogState extends ConsumerState<PointChargeDialog> {
  _Etapa _etapa = _Etapa.cargandoDispositivos;
  List<PointDeviceModel> _dispositivos = [];
  String? _error;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _cargarDispositivos();
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _cargarDispositivos() async {
    try {
      final dispositivos = await ref.read(mercadoPagoRepositoryProvider).listarDispositivos();

      if (!mounted) return;

      if (dispositivos.isEmpty) {
        setState(() {
          _etapa = _Etapa.error;
          _error = 'No encontramos ninguna terminal Point conectada a tu cuenta.';
        });
        return;
      }

      if (dispositivos.length == 1) {
        _iniciarCobro(dispositivos.first);
        return;
      }

      setState(() {
        _dispositivos = dispositivos;
        _etapa = _Etapa.eligiendoDispositivo;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _etapa = _Etapa.error;
        _error = 'No pudimos consultar tus terminales Point: $e';
      });
    }
  }

  Future<void> _iniciarCobro(PointDeviceModel dispositivo) async {
    setState(() => _etapa = _Etapa.esperandoPago);

    try {
      final repositorio = ref.read(mercadoPagoRepositoryProvider);
      final paymentIntentId = await repositorio.crearCobro(
        deviceId: dispositivo.id,
        montoCentavos: widget.montoCentavos,
      );

      _poll = Timer.periodic(const Duration(seconds: 2), (_) async {
        final estado = await repositorio.consultarEstado(paymentIntentId);

        if (!mounted) return;

        if (estado == PointPaymentEstado.aprobado) {
          _poll?.cancel();
          setState(() => _etapa = _Etapa.aprobado);
          await Future.delayed(const Duration(milliseconds: 600));
          if (mounted) Navigator.of(context).pop(true);
        } else if (estado == PointPaymentEstado.fallido) {
          _poll?.cancel();
          setState(() {
            _etapa = _Etapa.error;
            _error = 'El pago no se pudo completar en el Point.';
          });
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _etapa = _Etapa.error;
        _error = 'No pudimos iniciar el cobro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cobrar con Point'),
      content: SizedBox(
        width: 320,
        child: switch (_etapa) {
          _Etapa.cargandoDispositivos => const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
          _Etapa.eligiendoDispositivo => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Elegí la terminal:'),
                const SizedBox(height: 12),
                ..._dispositivos.map(
                  (d) => ListTile(
                    leading: const Icon(Icons.point_of_sale),
                    title: Text(d.id),
                    onTap: () => _iniciarCobro(d),
                  ),
                ),
              ],
            ),
          _Etapa.esperandoPago => const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Esperando que el cliente pase la tarjeta en el Point...',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          _Etapa.aprobado => const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: AppColors.success, size: 48),
                SizedBox(height: 12),
                Text('¡Pago aprobado!'),
              ],
            ),
          _Etapa.error => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: AppColors.danger, size: 40),
                const SizedBox(height: 12),
                Text(_error ?? 'Ocurrió un error.', textAlign: TextAlign.center),
              ],
            ),
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(_etapa == _Etapa.esperandoPago ? 'Cancelar' : 'Cerrar'),
        ),
      ],
    );
  }
}
