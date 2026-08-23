import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/articulos_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../providers/articulos_providers.dart';
import '../login/login_screen.dart';
import 'articulo_form_screen.dart';
import 'widgets/ajustar_stock_dialog.dart';
import 'widgets/movimiento_stock_item.dart';

class ArticuloDetailScreen extends ConsumerWidget {
  const ArticuloDetailScreen({super.key, required this.articuloId});

  final String articuloId;

  String _formatFecha(DateTime fecha) =>
      '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';

  Future<void> _ajustarStock(BuildContext context, WidgetRef ref) async {
    final resultado = await showDialog<({int cantidad, String nota})>(
      context: context,
      builder: (_) => const AjustarStockDialog(),
    );

    if (resultado == null) return;

    try {
      await ref
          .read(articulosRepositoryProvider)
          .ajustarStock(articuloId, resultado.cantidad, resultado.nota);

      ref.invalidate(articuloDetailProvider(articuloId));
      ref.invalidate(articuloMovimientosProvider(articuloId));
      ref.invalidate(articulosListProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Stock ajustado')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al ajustar stock: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articuloAsync = ref.watch(articuloDetailProvider(articuloId));
    final movimientosAsync = ref.watch(articuloMovimientosProvider(articuloId));
    final user = ref.watch(authControllerProvider).value;
    final puedeEditar = user?.hasPermission('modificar_articulos') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del artículo'),
        actions: [
          if (puedeEditar)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                final articulo = articuloAsync.value;
                if (articulo == null) return;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ArticuloFormScreen(articulo: articulo)),
                );
              },
            ),
        ],
      ),
      floatingActionButton: puedeEditar
          ? FloatingActionButton.extended(
              onPressed: () => _ajustarStock(context, ref),
              icon: const Icon(Icons.tune),
              label: const Text('Ajustar stock'),
            )
          : null,
      body: articuloAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (articulo) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (articulo.imagenUrl != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    articulo.imagenUrl!,
                    height: 160,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ),
            Text(articulo.descripcion, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Stock actual: ${articulo.stockActual ?? '-'}'),
            Text('Precio de costo: \$${articulo.precioCostoPesos.toStringAsFixed(2)}'),
            Text('Precio de venta: \$${articulo.precioVentaPesos.toStringAsFixed(2)}'),
            if (articulo.promocionVigente)
              Text(
                'Precio promocional vigente: \$${articulo.precioPromocionalPesos.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            else if (articulo.precioPromocional != null)
              Text(
                'Promoción programada: \$${articulo.precioPromocionalPesos.toStringAsFixed(2)}'
                '${articulo.promocionDesde != null ? ' desde ${_formatFecha(articulo.promocionDesde!)}' : ''}'
                '${articulo.promocionHasta != null ? ' hasta ${_formatFecha(articulo.promocionHasta!)}' : ''}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            if (articulo.marca != null) Text('Marca: ${articulo.marca}'),
            if (articulo.rubro != null) Text('Rubro: ${articulo.rubro}'),
            if (articulo.codigoBarras != null) Text('Código de barras: ${articulo.codigoBarras}'),
            const Divider(height: 32),
            Text('Historial de movimientos', style: Theme.of(context).textTheme.titleMedium),
            movimientosAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Text('Error al cargar movimientos: $error'),
              data: (movimientos) => movimientos.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Todavía no hay movimientos.'),
                    )
                  : Column(
                      children: movimientos
                          .map((m) => MovimientoStockItem(movimiento: m))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
