import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/comision_empleado_model.dart';
import '../../providers/empleados_providers.dart';

const _nombresMes = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
];

class ComisionesScreen extends ConsumerWidget {
  const ComisionesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reporteAsync = ref.watch(comisionesReporteProvider);
    final mes = ref.watch(comisionesMesProvider);

    return AppScaffold(
      title: 'Comisiones',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => ref
                      .read(comisionesMesProvider.notifier)
                      .irAMes(DateTime(mes.year, mes.month - 1, 1)),
                ),
                Text(
                  '${_nombresMes[mes.month - 1]} ${mes.year}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => ref
                      .read(comisionesMesProvider.notifier)
                      .irAMes(DateTime(mes.year, mes.month + 1, 1)),
                ),
              ],
            ),
          ),
          Expanded(
            child: reporteAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (reporte) => reporte.empleados.isEmpty
                  ? const Center(child: Text('No hay empleados cargados'))
                  : ListView.separated(
                      itemCount: reporte.empleados.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) =>
                          _ComisionTile(comision: reporte.empleados[index]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComisionTile extends StatelessWidget {
  const _ComisionTile({required this.comision});

  final ComisionEmpleadoModel comision;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comision.name),
      subtitle: Text(
        comision.comisionPorcentaje == null
            ? 'Sin comisión configurada'
            : '${comision.comisionPorcentaje}% · ${comision.cantidadVentas} venta${comision.cantidadVentas == 1 ? '' : 's'} · '
                '\$${comision.totalVendidoPesos.toStringAsFixed(2)} vendidos',
      ),
      trailing: Text(
        '\$${comision.comisionCalculadaPesos.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
