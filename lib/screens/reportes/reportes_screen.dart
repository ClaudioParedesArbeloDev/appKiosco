import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/navigation/app_section.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/reporte_fila_model.dart';
import '../../providers/reportes_providers.dart';
import '../../services/reportes_api_service.dart';

const _nombresMes = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
];

const _nombresTipo = {
  TipoReporte.rubro: 'Por rubro',
  TipoReporte.marca: 'Por marca',
  TipoReporte.zona: 'Por zona',
  TipoReporte.vendedor: 'Por vendedor',
};

class ReportesScreen extends ConsumerWidget {
  const ReportesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reporteAsync = ref.watch(reporteDataProvider);
    final mes = ref.watch(reporteMesProvider);
    final tipo = ref.watch(reporteTipoProvider);

    return AppScaffold(
      title: 'Reportes',
      section: AppSection.reportes,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<TipoReporte>(
              segments: _nombresTipo.entries
                  .map((e) => ButtonSegment(value: e.key, label: Text(e.value)))
                  .toList(),
              selected: {tipo},
              onSelectionChanged: (selected) =>
                  ref.read(reporteTipoProvider.notifier).elegir(selected.first),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => ref
                    .read(reporteMesProvider.notifier)
                    .irAMes(DateTime(mes.year, mes.month - 1, 1)),
              ),
              Text(
                '${_nombresMes[mes.month - 1]} ${mes.year}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => ref
                    .read(reporteMesProvider.notifier)
                    .irAMes(DateTime(mes.year, mes.month + 1, 1)),
              ),
            ],
          ),
          Expanded(
            child: reporteAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (filas) => filas.isEmpty
                  ? const Center(child: Text('No hay ventas en este período'))
                  : ListView.separated(
                      itemCount: filas.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) => _ReporteTile(fila: filas[index]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReporteTile extends StatelessWidget {
  const _ReporteTile({required this.fila});

  final ReporteFilaModel fila;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fila.etiqueta),
      subtitle: Text(
        '${fila.cantidad} venta${fila.cantidad == 1 ? '' : 's'}'
        '${fila.gananciaPesos != null ? ' · Ganancia: \$${fila.gananciaPesos!.toStringAsFixed(2)}' : ''}',
      ),
      trailing: Text(
        '\$${fila.totalVendidoPesos.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
