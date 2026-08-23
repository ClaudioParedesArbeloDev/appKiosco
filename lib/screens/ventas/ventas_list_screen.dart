import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/estadistica_mensual_model.dart';
import '../../models/venta_estadisticas_model.dart';
import '../../providers/ventas_providers.dart';
import '../clientes/widgets/venta_historial_item.dart';
import '../login/login_screen.dart';
import 'venta_detail_screen.dart';

const _filtros = {
  null: 'Todas',
  'completada': 'Completadas',
  'anulada': 'Anuladas',
};

const _periodosRanking = {'dia': 'Hoy', 'mes': 'Este mes', 'anio': 'Este año'};

/// En desktop se aprovecha el ancho con 4 cuadrantes (ventas / productos /
/// operaciones / uno libre por ahora); en mobile no entra de costado, así
/// que se apilan uno debajo del otro.
class VentasListScreen extends ConsumerWidget {
  const VentasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    final isDesktop = MediaQuery.of(context).size.width > 900;

    return AppScaffold(
      title: 'Ventas',
      section: AppSection.ventas,
      body: isDesktop ? const _QuadrantLayout() : const _StackedLayout(),
    );
  }
}

class _QuadrantLayout extends StatelessWidget {
  const _QuadrantLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _Panel(
                  title: 'Estadísticas de ventas',
                  child: SingleChildScrollView(child: _EstadisticasContent()),
                ),
              ),
              const Expanded(
                child: _Panel(
                  title: 'Productos más vendidos',
                  child: _ProductosContent(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: const [
              Expanded(
                child: _Panel(title: 'Operaciones', child: _OperacionesContent()),
              ),
              Expanded(
                child: _Panel(title: 'Últimos 6 meses', child: _TendenciaMensualContent()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _StackedLayout extends StatelessWidget {
  const _StackedLayout();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const _SectionHeader('Estadísticas de ventas'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: _EstadisticasContent(),
        ),
        const _SectionHeader('Productos más vendidos'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(height: 320, child: _ProductosContent()),
        ),
        const _SectionHeader('Operaciones'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: const _OperacionesContent(),
        ),
        const _SectionHeader('Últimos 6 meses'),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(height: 220, child: _TendenciaMensualContent()),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _OperacionesContent extends ConsumerWidget {
  const _OperacionesContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ventasAsync = ref.watch(ventasListProvider);
    final filtro = ref.watch(ventaFiltroEstadoProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: _filtros.entries.map((entry) {
            return ChoiceChip(
              label: Text(entry.value),
              selected: filtro == entry.key,
              onSelected: (_) => ref.read(ventaFiltroEstadoProvider.notifier).update(entry.key),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(ventasListProvider);
              ref.invalidate(ventasEstadisticasProvider);
              ref.invalidate(productosMasVendidosProvider);
              ref.invalidate(ventasEstadisticasMensualesProvider);
            },
            child: ventasAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ListView(
                children: const [
                  SizedBox(height: 80),
                  Center(child: Text('No pudimos cargar las ventas.')),
                ],
              ),
              data: (result) {
                if (result.data.isEmpty) {
                  return ListView(
                    children: const [
                      SizedBox(height: 80),
                      Center(child: Text('No hay ventas para mostrar.')),
                    ],
                  );
                }

                return ListView.separated(
                  itemCount: result.data.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final venta = result.data[index];
                    return VentaHistorialItem(
                      venta: venta,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => VentaDetailScreen(ventaId: venta.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _EstadisticasContent extends ConsumerWidget {
  const _EstadisticasContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadisticasAsync = ref.watch(ventasEstadisticasProvider);

    return estadisticasAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (stats) {
        return Column(
          children: [
            _EstadisticaCard(label: 'Hoy', periodo: stats.hoy),
            const SizedBox(height: 8),
            _EstadisticaCard(label: 'Esta semana', periodo: stats.semana),
            const SizedBox(height: 8),
            _EstadisticaCard(label: 'Este mes', periodo: stats.mes),
            const SizedBox(height: 8),
            _EstadisticaCard(label: 'Este año', periodo: stats.anio),
          ],
        );
      },
    );
  }
}

class _ProductosContent extends ConsumerWidget {
  const _ProductosContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(productosMasVendidosProvider);
    final periodo = ref.watch(productoRankingPeriodoProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          children: _periodosRanking.entries.map((entry) {
            return ChoiceChip(
              label: Text(entry.value),
              selected: periodo == entry.key,
              onSelected: (_) =>
                  ref.read(productoRankingPeriodoProvider.notifier).update(entry.key),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: productosAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const Center(child: Text('No pudimos cargar el ranking.')),
            data: (productos) {
              if (productos.isEmpty) {
                return const Center(child: Text('Todavía no hay ventas en este período.'));
              }

              return ListView.separated(
                itemCount: productos.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.accentHistorial,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    title: Text(producto.descripcion),
                    subtitle: Text('${producto.cantidadVendida} vendidos'),
                    trailing: Text(
                      '\$${producto.totalVendidoPesos.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Un solo mes de datos → un solo color de marca (más oscuro/opaco el mes
/// actual para que resalte), sin necesidad de leyenda: el título del panel
/// ya dice qué se está mostrando.
class _TendenciaMensualContent extends ConsumerWidget {
  const _TendenciaMensualContent();

  static const _alturaBarras = 110.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mesesAsync = ref.watch(ventasEstadisticasMensualesProvider);

    return mesesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => const Center(child: Text('No pudimos cargar la tendencia.')),
      data: (meses) {
        if (meses.isEmpty) return const SizedBox.shrink();

        final maxTotal = meses.map((m) => m.total).reduce((a, b) => a > b ? a : b);
        final ahora = DateTime.now();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: _alturaBarras,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: meses.map((mes) {
                  final esActual = mes.anio == ahora.year && mes.mes == ahora.month;
                  final fraccion =
                      maxTotal == 0 ? 0.02 : (mes.total / maxTotal).clamp(0.02, 1.0);

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        children: [
                          Text(
                            mes.total == 0 ? '' : '\$${mes.totalPesos.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey.shade700,
                              fontWeight: esActual ? FontWeight.bold : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: FractionallySizedBox(
                              heightFactor: fraccion,
                              widthFactor: 1,
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                constraints: const BoxConstraints(minHeight: 3),
                                decoration: BoxDecoration(
                                  color: esActual
                                      ? AppColors.accentHistorial
                                      : AppColors.accentHistorial.withValues(alpha: 0.4),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 6),
            Row(
              children: meses.map((mes) {
                final esActual = mes.anio == DateTime.now().year && mes.mes == DateTime.now().month;
                return Expanded(
                  child: Text(
                    nombresMesesCortos[mes.mes],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: esActual ? AppColors.accentHistorial : Colors.grey.shade600,
                      fontWeight: esActual ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _EstadisticaCard extends StatelessWidget {
  const _EstadisticaCard({required this.label, required this.periodo});

  final String label;
  final VentaResumenPeriodo periodo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accentHistorial.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accentHistorial.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                const SizedBox(height: 2),
                Text(
                  '\$${periodo.totalPesos.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${periodo.cantidad} venta${periodo.cantidad == 1 ? '' : 's'}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(width: 1, height: 40, color: AppColors.accentHistorial.withValues(alpha: 0.2)),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(
              spacing: 20,
              runSpacing: 4,
              children: [
                _DesgloseFormaPago(label: 'Efectivo', monto: periodo.efectivoPesos),
                _DesgloseFormaPago(label: 'Tarjeta', monto: periodo.tarjetaPesos),
                _DesgloseFormaPago(label: 'Cta. cte.', monto: periodo.cuentaCorrientePesos),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesgloseFormaPago extends StatelessWidget {
  const _DesgloseFormaPago({required this.label, required this.monto});

  final String label;
  final double monto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        Text(
          '\$${monto.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
