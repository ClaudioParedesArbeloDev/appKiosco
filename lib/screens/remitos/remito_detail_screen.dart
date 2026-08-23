import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/remitos_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/remitos_providers.dart';
import '../login/login_screen.dart';
import '../ventas/venta_detail_screen.dart';
import '../ventas/widgets/forma_pago_selector.dart';

const _estadosRemito = {
  'vigente': 'Vigente',
  'convertido': 'Convertido',
  'anulado': 'Anulado',
};

class RemitoDetailScreen extends ConsumerStatefulWidget {
  const RemitoDetailScreen({super.key, required this.remitoId});

  final String remitoId;

  @override
  ConsumerState<RemitoDetailScreen> createState() => _RemitoDetailScreenState();
}

class _RemitoDetailScreenState extends ConsumerState<RemitoDetailScreen> {
  bool _procesando = false;

  String _fecha(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  Future<void> _convertirAVenta() async {
    String formaPago = 'efectivo';

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('Convertir en venta'),
          content: FormaPagoSelector(
            value: formaPago,
            onChanged: (value) => setDialogState(() => formaPago = value),
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
      final venta = await ref.read(remitosRepositoryProvider).convertirAVenta(
            widget.remitoId,
            tipoComprobante: 'X',
            formaPago: formaPago,
          );
      ref.invalidate(remitoDetailProvider(widget.remitoId));
      ref.invalidate(remitosListProvider);

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
    final motivoController = TextEditingController();

    final motivo = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Anular remito'),
        content: TextField(
          controller: motivoController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Motivo', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(motivoController.text.trim()),
            child: const Text('Anular'),
          ),
        ],
      ),
    );

    if (motivo == null || motivo.isEmpty) return;

    setState(() => _procesando = true);
    try {
      await ref.read(remitosRepositoryProvider).anular(widget.remitoId, motivo);
      ref.invalidate(remitoDetailProvider(widget.remitoId));
      ref.invalidate(remitosListProvider);
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
    final remitoAsync = ref.watch(remitoDetailProvider(widget.remitoId));
    final user = ref.watch(authControllerProvider).value;
    final puedeGestionar = user?.hasPermission('ingresar_ventas') ?? false;
    final puedeAnular = user?.hasPermission('ingresar_devoluciones') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de remito')),
      body: remitoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (remito) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Remito #${remito.numero}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Chip(
                  label: Text(
                    _estadosRemito[remito.estado] ?? remito.estado,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: remito.estaVigente
                      ? AppColors.accentRemitos
                      : remito.estaConvertido
                          ? AppColors.success
                          : AppColors.danger,
                ),
              ],
            ),
            Text(_fecha(remito.createdAt), style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            if (remito.clienteNombre != null) Text('Cliente: ${remito.clienteNombre}'),
            if (remito.vendedorNombre != null) Text('Cargado por: ${remito.vendedorNombre}'),
            if (remito.estaAnulado && remito.motivoAnulacion != null) ...[
              const SizedBox(height: 8),
              Text(
                'Motivo de anulación: ${remito.motivoAnulacion}',
                style: const TextStyle(color: AppColors.danger),
              ),
            ],
            const Divider(height: 32),
            Text('Artículos', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            ...?remito.items?.map(
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
                  '\$${remito.totalPesos.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (remito.estaVigente) ...[
              if (puedeGestionar) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _procesando ? null : _convertirAVenta,
                    child: const Text('Convertir en venta'),
                  ),
                ),
              ],
              if (puedeAnular) ...[
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
          ],
        ),
      ),
    );
  }
}
