import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/caja_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/caja_model.dart';
import '../dispositivos/dispositivos_list_screen.dart';
import 'caja_historial_screen.dart';
import 'widgets/abrir_caja_dialog.dart';
import 'widgets/cerrar_caja_dialog.dart';
import 'widgets/movimiento_dialog.dart';

class CajaScreen extends ConsumerStatefulWidget {
  const CajaScreen({super.key});

  @override
  ConsumerState<CajaScreen> createState() => _CajaScreenState();
}

class _CajaScreenState extends ConsumerState<CajaScreen> {
  bool _procesando = false;

  void _mostrarError(Object error) {
    final mensaje =
        error is DioException ? ValidationErrors.fromDioException(error).message : '$error';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> _abrirCaja() async {
    final resultado = await showDialog<({int montoInicial, String? nombreDispositivo})>(
      context: context,
      builder: (_) => const AbrirCajaDialog(),
    );
    if (resultado == null) return;

    setState(() => _procesando = true);
    try {
      await ref.read(cajaControllerProvider.notifier).abrir(resultado.montoInicial);
    } catch (e) {
      if (mounted) _mostrarError(e);
    } finally {
      if (mounted) setState(() => _procesando = false);
    }
  }

  Future<void> _registrarMovimiento() async {
    final resultado = await showDialog<({String tipo, int monto, String nota})>(
      context: context,
      builder: (_) => const MovimientoDialog(),
    );
    if (resultado == null) return;

    setState(() => _procesando = true);
    try {
      await ref.read(cajaControllerProvider.notifier).registrarMovimiento(
            tipo: resultado.tipo,
            monto: resultado.monto,
            nota: resultado.nota,
          );
    } catch (e) {
      if (mounted) _mostrarError(e);
    } finally {
      if (mounted) setState(() => _procesando = false);
    }
  }

  Future<void> _cerrarCaja(CajaModel caja) async {
    final montoFinal = await showDialog<int>(
      context: context,
      builder: (_) => CerrarCajaDialog(resumen: caja.resumen),
    );
    if (montoFinal == null) return;

    setState(() => _procesando = true);
    try {
      final cajaCerrada = await ref.read(cajaControllerProvider.notifier).cerrar(montoFinal);
      if (mounted) _mostrarResultadoCierre(cajaCerrada);
    } catch (e) {
      if (mounted) _mostrarError(e);
    } finally {
      if (mounted) setState(() => _procesando = false);
    }
  }

  void _mostrarResultadoCierre(CajaModel caja) {
    if (caja.pendienteSync) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Caja cerrada sin conexión'),
          content: Text(
            'Declarado: \$${caja.montoFinalDeclaradoPesos.toStringAsFixed(2)}\n'
            'El total calculado y la diferencia se van a ver una vez que sincronice.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      return;
    }

    final diferencia = caja.diferencia ?? 0;
    final color = diferencia == 0
        ? AppColors.success
        : (diferencia > 0 ? AppColors.warning : AppColors.danger);
    final etiqueta = diferencia == 0
        ? 'La caja cerró sin diferencia.'
        : diferencia > 0
            ? 'Sobran \$${(diferencia / 100).abs().toStringAsFixed(2)}'
            : 'Faltan \$${(diferencia / 100).abs().toStringAsFixed(2)}';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Caja cerrada'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calculado: \$${caja.montoFinalCalculadoPesos.toStringAsFixed(2)}'),
            Text('Declarado: \$${caja.montoFinalDeclaradoPesos.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(etiqueta, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cajaAsync = ref.watch(cajaControllerProvider);
    final user = ref.watch(authControllerProvider).value;
    final puedeAbrir = user?.hasPermission('abrir_caja') ?? false;
    final puedeActualizar = user?.hasPermission('actualizar_caja') ?? false;

    return AppScaffold(
      title: 'Caja',
      section: AppSection.caja,
      actions: [
        if (user?.isAdminComercio ?? false)
          IconButton(
            icon: const Icon(Icons.devices, color: AppColors.white),
            tooltip: 'Dispositivos',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DispositivosListScreen()),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.history, color: AppColors.white),
          tooltip: 'Historial',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CajaHistorialScreen()),
          ),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () => ref.read(cajaControllerProvider.notifier).refresh(),
        child: cajaAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: const [
              SizedBox(height: 80),
              Center(child: Text('No pudimos cargar el estado de la caja.')),
            ],
          ),
          data: (caja) {
            if (caja == null || !caja.estaAbierta) {
              return ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const SizedBox(height: 40),
                  const Icon(Icons.point_of_sale_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No hay una caja abierta.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  if (puedeAbrir)
                    FilledButton(
                      onPressed: _procesando ? null : _abrirCaja,
                      child: const Text('Abrir caja'),
                    ),
                ],
              );
            }

            final resumen = caja.resumen;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (caja.pendienteSync)
                  Card(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.sync_problem, color: AppColors.warning),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text('Caja abierta sin conexión — se sincroniza sola.'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (caja.pendienteSync) const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          caja.nombreDispositivo == null
                              ? 'Resumen'
                              : 'Resumen — ${caja.nombreDispositivo}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Divider(height: 24),
                        if (resumen == null)
                          const Text(
                            'Sin conexión: el resumen se actualiza al sincronizar.',
                            style: TextStyle(color: Colors.grey),
                          )
                        else ...[
                          _ResumenRow('Monto inicial', resumen.montoInicialPesos),
                          _ResumenRow('Ventas', resumen.ventasPesos),
                          _ResumenRow('Ingresos', resumen.ingresosPesos),
                          _ResumenRow('Retiros', resumen.retirosPesos),
                          const Divider(height: 24),
                          _ResumenRow('Total efectivo', resumen.totalEfectivoPesos,
                              destacado: true),
                          _ResumenRow('Total tarjeta', resumen.totalTarjetaPesos, destacado: true),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (puedeActualizar) ...[
                  OutlinedButton.icon(
                    onPressed: _procesando ? null : _registrarMovimiento,
                    icon: const Icon(Icons.swap_vert),
                    label: const Text('Registrar movimiento'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _procesando ? null : () => _cerrarCaja(caja),
                    icon: const Icon(Icons.lock_outline),
                    label: const Text('Cerrar caja'),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ResumenRow extends StatelessWidget {
  const _ResumenRow(this.label, this.monto, {this.destacado = false});

  final String label;
  final double monto;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
      fontSize: destacado ? 16 : 14,
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
