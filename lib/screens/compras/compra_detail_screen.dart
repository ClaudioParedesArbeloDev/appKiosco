import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/compras_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/compras_providers.dart';
import '../login/login_screen.dart';

const _formasPagoCompra = {
  'efectivo': 'Efectivo',
  'tarjeta': 'Tarjeta',
  'cuenta_corriente': 'Cuenta corriente',
};

class CompraDetailScreen extends ConsumerStatefulWidget {
  const CompraDetailScreen({super.key, required this.compraId});

  final String compraId;

  @override
  ConsumerState<CompraDetailScreen> createState() => _CompraDetailScreenState();
}

class _CompraDetailScreenState extends ConsumerState<CompraDetailScreen> {
  bool _anulando = false;

  String _fecha(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _anular() async {
    final motivoController = TextEditingController();

    final motivo = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Anular compra'),
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

    setState(() => _anulando = true);
    try {
      await ref.read(comprasRepositoryProvider).anular(widget.compraId, motivo);
      ref.invalidate(compraDetailProvider(widget.compraId));
      ref.invalidate(comprasListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Compra anulada')));
      }
    } catch (e) {
      final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo anular: $mensaje')));
      }
    } finally {
      if (mounted) setState(() => _anulando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final compraAsync = ref.watch(compraDetailProvider(widget.compraId));
    final user = ref.watch(authControllerProvider).value;
    final puedeAnular = user?.hasPermission('ingresar_compras') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de compra'),
        actions: [
          compraAsync.maybeWhen(
            data: (compra) => puedeAnular && !compra.estaAnulada
                ? IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    tooltip: 'Anular compra',
                    onPressed: _anulando ? null : _anular,
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: compraAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (compra) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    compra.proveedorNombre ?? 'Compra',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                if (compra.estaAnulada)
                  const Chip(
                    label: Text('Anulada', style: TextStyle(color: Colors.white)),
                    backgroundColor: AppColors.danger,
                  ),
              ],
            ),
            Text(_fecha(compra.createdAt), style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            if (compra.usuarioNombre != null) Text('Cargada por: ${compra.usuarioNombre}'),
            if (compra.numeroFactura != null) Text('Factura: ${compra.numeroFactura}'),
            Text('Forma de pago: ${_formasPagoCompra[compra.formaPago] ?? compra.formaPago}'),
            if (compra.estaAnulada && compra.motivoAnulacion != null) ...[
              const SizedBox(height: 8),
              Text(
                'Motivo de anulación: ${compra.motivoAnulacion}',
                style: const TextStyle(color: AppColors.danger),
              ),
            ],
            const Divider(height: 32),
            Text('Artículos', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            ...?compra.items?.map(
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
            _TotalRow('Total', compra.totalPesos, destacado: true),
          ],
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow(this.label, this.monto, {this.destacado = false});

  final String label;
  final double monto;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
      fontSize: destacado ? 18 : 14,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('\$${monto.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}
