import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/articulos_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../providers/articulos_providers.dart';
import '../login/login_screen.dart';
import 'articulo_detail_screen.dart';
import 'articulo_form_screen.dart';
import 'widgets/actualizar_precios_masivo_dialog.dart';
import 'widgets/articulo_list_item.dart';

class ArticulosListScreen extends ConsumerWidget {
  const ArticulosListScreen({super.key});

  Future<void> _actualizarPreciosMasivo(BuildContext context, WidgetRef ref) async {
    final resultado = await showDialog<
        ({String? marca, String? rubro, String campo, String tipo, int valor})>(
      context: context,
      builder: (_) => const ActualizarPreciosMasivoDialog(),
    );
    if (resultado == null) return;

    try {
      final actualizados = await ref.read(articulosRepositoryProvider).actualizarPreciosMasivo(
            marca: resultado.marca,
            rubro: resultado.rubro,
            campo: resultado.campo,
            tipo: resultado.tipo,
            valor: resultado.valor,
          );
      ref.invalidate(articulosListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$actualizados artículos actualizados')));
      }
    } catch (e) {
      if (context.mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo actualizar: $mensaje')));
      }
    }
  }

  Future<void> _exportar(BuildContext context, WidgetRef ref) async {
    try {
      final bytes = await ref.read(articulosRepositoryProvider).exportar();
      final ruta = await FilePicker.saveFile(
        dialogTitle: 'Guardar catálogo',
        fileName: 'articulos.csv',
        bytes: Uint8List.fromList(bytes),
      );
      if (context.mounted && ruta != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Guardado en $ruta')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo exportar: $e')));
      }
    }
  }

  Future<void> _importar(BuildContext context, WidgetRef ref) async {
    final resultado = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );
    final archivo = resultado?.files.singleOrNull;
    final bytes = archivo?.bytes;
    if (archivo == null || bytes == null) return;

    try {
      final importado =
          await ref.read(articulosRepositoryProvider).importar(bytes, archivo.name);
      ref.invalidate(articulosListProvider);
      if (context.mounted) {
        final mensaje = importado.noEncontrados.isEmpty
            ? '${importado.actualizados} artículos actualizados'
            : '${importado.actualizados} actualizados · ${importado.noEncontrados.length} '
                'no encontrados: ${importado.noEncontrados.join(', ')}';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
      }
    } catch (e) {
      if (context.mounted) {
        final mensaje = e is DioException ? ValidationErrors.fromDioException(e).message : '$e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo importar: $mensaje')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articulosAsync = ref.watch(articulosListProvider);
    final user = ref.watch(authControllerProvider).value;
    final puedeEditar = user?.hasPermission('modificar_articulos') ?? false;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return AppScaffold(
      title: 'Artículos',
      section: AppSection.articulos,
      actions: [
        if (puedeEditar)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.white),
            onSelected: (value) {
              switch (value) {
                case 'precios':
                  _actualizarPreciosMasivo(context, ref);
                case 'exportar':
                  _exportar(context, ref);
                case 'importar':
                  _importar(context, ref);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'precios', child: Text('Actualizar precios masivo')),
              PopupMenuItem(value: 'exportar', child: Text('Exportar a CSV')),
              PopupMenuItem(value: 'importar', child: Text('Importar desde CSV')),
            ],
          ),
      ],
      floatingActionButton: puedeEditar
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ArticuloFormScreen()),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por descripción o código...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final current = ref.read(articuloFiltersProvider);
                ref.read(articuloFiltersProvider.notifier).update(
                      current.copyWith(search: value),
                    );
              },
            ),
          ),
          Expanded(
            child: articulosAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (result) => result.data.isEmpty
                  ? const Center(child: Text('No se encontraron artículos'))
                  : RefreshIndicator(
                      onRefresh: () => ref.refresh(articulosListProvider.future),
                      child: ListView.separated(
                        itemCount: result.data.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final articulo = result.data[index];
                          return ArticuloListItem(
                            articulo: articulo,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ArticuloDetailScreen(articuloId: articulo.id),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
