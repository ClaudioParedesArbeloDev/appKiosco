import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/presupuestos_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/presupuestos_providers.dart';
import '../login/login_screen.dart';
import '../ventas/venta_detail_screen.dart';
import '../ventas/widgets/forma_pago_selector.dart';

const _estadosPresupuesto = {
  'vigente': 'Vigente',
  'convertido': 'Convertido',
  'anulado': 'Anulado',
};

class PresupuestoDetailScreen extends ConsumerStatefulWidget {
  const PresupuestoDetailScreen({super.key, required this.presupuestoId});

  final String presupuestoId;

  @override
  ConsumerState<PresupuestoDetailScreen> createState() => _PresupuestoDetailScreenState();
}

class _PresupuestoDetailScreenState extends ConsumerState<PresupuestoDetailScreen> {
  bool _procesando = false;

  String _fecha(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  Future<void> _convertirAVenta() async {
    String tipoComprobante = 'X';
    String formaPago = 'efectivo';

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('Convertir en venta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormaPagoSelector(
                value: formaPago,
                onChanged: (value) => setDialogState(() => formaPago = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );

    if (confirmado != true) return;

    setState(() => _procesando = true);
    try {
      final venta = await ref.read(presupuestosRepositoryProvider).convertirAVenta(
            widget.presupuestoId,
            tipoComprobante: tipoComprobante,
            formaPago: formaPago,
          );
      ref.invalidate(presupuestoDetailProvider(widget.presupuestoId));
      ref.invalidate(presupuestosListProvider);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => VentaDetailScreen(ventaId: venta.id)),
        );
      }
    } catch (e) {
      if (mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo convertir: $mensaje')));
      }
    } finally {
      if (mounted) setState(() => _procesando = false);
    }
  }

  Future<void> _anular() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Anular presupuesto'),
        content: const Text('¿Seguro que querés anular este presupuesto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Anular'),
          ),
        ],
      ),
    );
    if (confirmado != true) return;

    setState(() => _procesando = true);
    try {
      await ref.read(presupuestosRepositoryProvider).anular(widget.presupuestoId);
      ref.invalidate(presupuestoDetailProvider(widget.presupuestoId));
      ref.invalidate(presupuestosListProvider);
    } catch (e) {
      if (mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo anular: $mensaje')));
      }
    } finally {
      if (mounted) setState(() => _procesando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final presupuestoAsync = ref.watch(presupuestoDetailProvider(widget.presupuestoId));
    final user = ref.watch(authControllerProvider).value;
    final puedeGestionar = user?.hasPermission('ingresar_ventas') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de presupuesto')),
      body: presupuestoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (presupuesto) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Presupuesto #${presupuesto.numero}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Chip(
                  label: Text(
                    _estadosPresupuesto[presupuesto.estado] ?? presupuesto.estado,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: presupuesto.estaVigente
                      ? AppColors.accentPresupuestos
                      : presupuesto.estaConvertido
                          ? AppColors.success
                          : AppColors.danger,
                ),
              ],
            ),
            Text(_fecha(presupuesto.createdAt), style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            if (presupuesto.clienteNombre != null) Text('Cliente: ${presupuesto.clienteNombre}'),
            if (presupuesto.vendedorNombre != null)
              Text('Cargado por: ${presupuesto.vendedorNombre}'),
            const Divider(height: 32),
            Text('Artículos', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            ...?presupuesto.items?.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.articuloDescripcion),
                subtitle: Text(
                  '${item.cantidad} x \$${item.precioUnitarioPesos.toStringAsFixed(2)}',
                ),
                trailing: Text('\$${item.subtotalPesos.toStringAsFixed(2)}'),
              ),
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  '\$${presupuesto.totalPesos.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (puedeGestionar && presupuesto.estaVigente) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _procesando ? null : _convertirAVenta,
                  child: const Text('Convertir en venta'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _procesando ? null : _anular,
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger),
                  child: const Text('Anular'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
