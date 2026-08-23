import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/notas_credito_controller.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/ventas_providers.dart';
import '../login/login_screen.dart';
import 'nota_credito_form_screen.dart';

const _formasPago = {
  'efectivo': 'Efectivo',
  'tarjeta': 'Tarjeta',
  'cuenta_corriente': 'Cuenta corriente',
};

class VentaDetailScreen extends ConsumerStatefulWidget {
  const VentaDetailScreen({super.key, required this.ventaId});

  final String ventaId;

  @override
  ConsumerState<VentaDetailScreen> createState() => _VentaDetailScreenState();
}

class _VentaDetailScreenState extends ConsumerState<VentaDetailScreen> {
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
        title: const Text('Anular venta'),
        content: TextField(
          controller: motivoController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Motivo', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
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
      await ref.read(ventasRepositoryProvider).anular(widget.ventaId, motivo);
      ref.invalidate(ventaDetailProvider(widget.ventaId));
      ref.invalidate(ventasListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Venta anulada')));
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
    final ventaAsync = ref.watch(ventaDetailProvider(widget.ventaId));
    final user = ref.watch(authControllerProvider).value;
    final puedeAnular = user?.hasPermission('ingresar_devoluciones') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de venta'),
        actions: [
          ventaAsync.maybeWhen(
            data: (venta) => puedeAnular && !venta.estaAnulada
                ? IconButton(
                    icon: const Icon(Icons.assignment_return_outlined),
                    tooltip: 'Nota de crédito',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => NotaCreditoFormScreen(venta: venta),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
          ventaAsync.maybeWhen(
            data: (venta) => puedeAnular && !venta.estaAnulada
                ? IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    tooltip: 'Anular venta',
                    onPressed: _anulando ? null : _anular,
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: ventaAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (venta) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Venta #${venta.numero}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                if (venta.estaAnulada)
                  const Chip(
                    label: Text('Anulada', style: TextStyle(color: Colors.white)),
                    backgroundColor: AppColors.danger,
                  ),
              ],
            ),
            Text(_fecha(venta.createdAt), style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            if (venta.vendedorNombre != null) Text('Vendedor: ${venta.vendedorNombre}'),
            if (venta.clienteNombre != null) Text('Cliente: ${venta.clienteNombre}'),
            Text('Forma de pago: ${_formasPago[venta.formaPago] ?? venta.formaPago}'),
            if (venta.estaAnulada && venta.motivoAnulacion != null) ...[
              const SizedBox(height: 8),
              Text(
                'Motivo de anulación: ${venta.motivoAnulacion}',
                style: const TextStyle(color: AppColors.danger),
              ),
            ],
            const Divider(height: 32),
            Text('Artículos', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            ...?venta.items?.map(
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
            if (venta.subtotalPesos != null) _TotalRow('Subtotal', venta.subtotalPesos!),
            if (venta.descuentoPesos != null && venta.descuentoPesos! > 0)
              _TotalRow('Descuento', -venta.descuentoPesos!),
            _TotalRow('Total', venta.totalPesos, destacado: true),
            Consumer(
              builder: (context, ref, _) {
                final notasCreditoAsync = ref.watch(notasCreditoPorVentaProvider(venta.id));

                return notasCreditoAsync.maybeWhen(
                  data: (notasCredito) => notasCredito.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(height: 32),
                            Text(
                              'Notas de crédito',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            ...notasCredito.map(
                              (nc) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text('NC #${nc.numero} — ${nc.motivo}'),
                                trailing: Text('-\$${nc.totalPesos.toStringAsFixed(2)}'),
                              ),
                            ),
                          ],
                        ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
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
