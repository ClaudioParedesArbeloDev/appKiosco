import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/platform_helper.dart';
import '../../controllers/articulos_controller.dart';
import '../../models/articulo_model.dart';
import '../../providers/articulos_providers.dart';
import 'widgets/barcode_scanner_screen.dart';
import 'widgets/remote_scan_dialog.dart';

class ArticuloFormScreen extends ConsumerStatefulWidget {
  const ArticuloFormScreen({super.key, this.articulo});

  /// Si viene null, es alta. Si viene con datos, es edición.
  final ArticuloModel? articulo;

  @override
  ConsumerState<ArticuloFormScreen> createState() => _ArticuloFormScreenState();
}

class _ArticuloFormScreenState extends ConsumerState<ArticuloFormScreen> {
  late final _descripcionController =
      TextEditingController(text: widget.articulo?.descripcion);
  late final _codigoBarrasController =
      TextEditingController(text: widget.articulo?.codigoBarras);
  late final _marcaController = TextEditingController(text: widget.articulo?.marca);
  late final _rubroController = TextEditingController(text: widget.articulo?.rubro);
  late final _imagenUrlController = TextEditingController(text: widget.articulo?.imagenUrl);
  late final _precioCostoController = TextEditingController(
    text: widget.articulo != null ? widget.articulo!.precioCostoPesos.toStringAsFixed(2) : '',
  );
  late final _precioVentaController = TextEditingController(
    text: widget.articulo != null ? widget.articulo!.precioVentaPesos.toStringAsFixed(2) : '',
  );
  late final _precioPromocionalController = TextEditingController(
    text: widget.articulo?.precioPromocional != null
        ? widget.articulo!.precioPromocionalPesos.toStringAsFixed(2)
        : '',
  );
  final _stockInicialController = TextEditingController();

  DateTime? _promocionDesde;
  DateTime? _promocionHasta;

  bool _guardando = false;
  bool _buscandoCodigo = false;

  bool get _esEdicion => widget.articulo != null;

  @override
  void initState() {
    super.initState();
    _promocionDesde = widget.articulo?.promocionDesde;
    _promocionHasta = widget.articulo?.promocionHasta;
  }

  @override
  void dispose() {
    _descripcionController.dispose();
    _codigoBarrasController.dispose();
    _marcaController.dispose();
    _rubroController.dispose();
    _imagenUrlController.dispose();
    _precioCostoController.dispose();
    _precioVentaController.dispose();
    _precioPromocionalController.dispose();
    _stockInicialController.dispose();
    super.dispose();
  }

  int _pesosACentavos(String texto) {
    final valor = double.tryParse(texto.replaceAll(',', '.')) ?? 0;
    return (valor * 100).round();
  }

  String _formatFecha(DateTime fecha) =>
      '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';

  Future<void> _escanear() async {
    final codigo = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
    );

    if (codigo == null || !mounted) return;

    _codigoBarrasController.text = codigo;
    await _buscarPorCodigo(codigo);
  }

  Future<void> _escanearConCelular() async {
    final codigo = await showDialog<String>(
      context: context,
      builder: (_) => const RemoteScanDialog(),
    );

    if (codigo == null || !mounted) return;

    _codigoBarrasController.text = codigo;
    await _buscarPorCodigo(codigo);
  }

  Future<void> _buscarPorCodigo(String codigo) async {
    if (codigo.trim().isEmpty) return;

    setState(() => _buscandoCodigo = true);

    try {
      final resultado =
          await ref.read(articulosRepositoryProvider).buscarPorCodigo(codigo.trim());

      if (!mounted) return;

      if (resultado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se encontró información para este código.')),
        );
        return;
      }

      if (resultado.esArticuloPropio) {
        // Ya existe un artículo propio con este código: vamos directo a su
        // edición en vez de dejar cargar un duplicado.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ArticuloFormScreen(articulo: resultado.articulo),
          ),
        );
        return;
      }

      // Autocompletamos con lo que trae el catálogo global u Open Food
      // Facts, sin pisar lo que el usuario ya haya escrito a mano.
      if (_descripcionController.text.trim().isEmpty && resultado.sugerenciaDescripcion != null) {
        _descripcionController.text = resultado.sugerenciaDescripcion!;
      }
      if (_marcaController.text.trim().isEmpty && resultado.sugerenciaMarca != null) {
        _marcaController.text = resultado.sugerenciaMarca!;
      }
      if (_imagenUrlController.text.trim().isEmpty && resultado.sugerenciaImagenUrl != null) {
        _imagenUrlController.text = resultado.sugerenciaImagenUrl!;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos completados automáticamente.')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al buscar el código: $e')));
      }
    } finally {
      if (mounted) setState(() => _buscandoCodigo = false);
    }
  }

  Future<void> _elegirFecha({required bool esDesde}) async {
    final inicial = (esDesde ? _promocionDesde : _promocionHasta) ?? DateTime.now();

    final fecha = await showDatePicker(
      context: context,
      initialDate: inicial,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (fecha == null) return;

    setState(() {
      if (esDesde) {
        _promocionDesde = fecha;
      } else {
        _promocionHasta = fecha;
      }
    });
  }

  Future<void> _guardar() async {
    if (_descripcionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('La descripción es obligatoria')));
      return;
    }

    final precioVenta = _pesosACentavos(_precioVentaController.text);
    final tienePrecioPromocional = _precioPromocionalController.text.trim().isNotEmpty;
    final precioPromocional =
        tienePrecioPromocional ? _pesosACentavos(_precioPromocionalController.text) : null;

    if (precioPromocional != null && precioPromocional >= precioVenta) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El precio promocional debe ser menor al precio de venta')),
      );
      return;
    }

    setState(() => _guardando = true);

    final data = {
      'descripcion': _descripcionController.text.trim(),
      if (_codigoBarrasController.text.trim().isNotEmpty)
        'codigo_barras': _codigoBarrasController.text.trim(),
      if (_marcaController.text.trim().isNotEmpty) 'marca': _marcaController.text.trim(),
      if (_rubroController.text.trim().isNotEmpty) 'rubro': _rubroController.text.trim(),
      if (_imagenUrlController.text.trim().isNotEmpty)
        'imagen_url': _imagenUrlController.text.trim(),
      'precio_costo': _pesosACentavos(_precioCostoController.text),
      'precio_venta': precioVenta,
      'precio_promocional': precioPromocional,
      'promocion_desde': _promocionDesde?.toIso8601String().split('T').first,
      'promocion_hasta': _promocionHasta?.toIso8601String().split('T').first,
      if (!_esEdicion && _stockInicialController.text.trim().isNotEmpty)
        'stock_inicial': int.tryParse(_stockInicialController.text.trim()) ?? 0,
    };

    try {
      final repository = ref.read(articulosRepositoryProvider);

      if (_esEdicion) {
        await repository.actualizar(widget.articulo!.id, data);
        ref.invalidate(articuloDetailProvider(widget.articulo!.id));
      } else {
        await repository.crear(data);
      }

      ref.invalidate(articulosListProvider);

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al guardar: $e')));
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar artículo' : 'Nuevo artículo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _descripcionController,
            decoration: const InputDecoration(labelText: 'Descripción', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _codigoBarrasController,
                  decoration: const InputDecoration(
                    labelText: 'Código de barras',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: _buscarPorCodigo,
                ),
              ),
              if (PlatformHelper.isMobile) ...[
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.qr_code_scanner),
                  tooltip: 'Escanear código',
                  onPressed: _guardando ? null : _escanear,
                ),
              ],
              if (PlatformHelper.isDesktop) ...[
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.smartphone),
                  tooltip: 'Escanear con el celular',
                  onPressed: _guardando ? null : _escanearConCelular,
                ),
              ],
              IconButton(
                icon: _buscandoCodigo
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.search),
                tooltip: 'Buscar datos por código',
                onPressed: _buscandoCodigo
                    ? null
                    : () => _buscarPorCodigo(_codigoBarrasController.text),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _marcaController,
            decoration: const InputDecoration(labelText: 'Marca', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _rubroController,
            decoration: const InputDecoration(labelText: 'Rubro', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _imagenUrlController,
            decoration:
                const InputDecoration(labelText: 'URL de imagen', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _precioCostoController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Precio costo', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _precioVentaController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Precio venta', border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Promoción / descuento', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _precioPromocionalController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Precio promocional (opcional)',
              helperText: 'Debe ser menor al precio de venta',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _elegirFecha(esDesde: true),
                  child: Text(
                    _promocionDesde == null
                        ? 'Vigencia desde'
                        : 'Desde: ${_formatFecha(_promocionDesde!)}',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _elegirFecha(esDesde: false),
                  child: Text(
                    _promocionHasta == null
                        ? 'Vigencia hasta'
                        : 'Hasta: ${_formatFecha(_promocionHasta!)}',
                  ),
                ),
              ),
            ],
          ),
          if (_promocionDesde != null || _promocionHasta != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => setState(() {
                  _promocionDesde = null;
                  _promocionHasta = null;
                }),
                child: const Text('Quitar fechas'),
              ),
            ),
          if (!_esEdicion) ...[
            const SizedBox(height: 16),
            TextField(
              controller: _stockInicialController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock inicial (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _guardando ? null : _guardar,
            child: _guardando
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
