import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/articulo_model.dart';
import '../../../providers/articulos_providers.dart';

/// Buscador de artículos para agregar al carrito. A propósito NO usa
/// `articuloFiltersProvider` (es el estado global de la pantalla de
/// Artículos) — así escribir acá no le pisa la búsqueda a esa pantalla.
class ArticuloSearchField extends ConsumerStatefulWidget {
  const ArticuloSearchField({super.key, required this.onSeleccionar});

  final ValueChanged<ArticuloModel> onSeleccionar;

  @override
  ConsumerState<ArticuloSearchField> createState() => _ArticuloSearchFieldState();
}

class _ArticuloSearchFieldState extends ConsumerState<ArticuloSearchField> {
  final _controller = TextEditingController();
  Timer? _debounce;
  List<ArticuloModel> _resultados = [];
  bool _buscando = false;

  void _onChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      setState(() => _resultados = []);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 350), () => _buscar(query));
  }

  Future<void> _buscar(String query) async {
    setState(() => _buscando = true);

    try {
      final resultado = await ref.read(articulosRepositoryProvider).listar(search: query);
      if (!mounted) return;
      setState(() => _resultados = resultado.data);
    } finally {
      if (mounted) setState(() => _buscando = false);
    }
  }

  void _seleccionar(ArticuloModel articulo) {
    widget.onSeleccionar(articulo);
    _controller.clear();
    setState(() => _resultados = []);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          onChanged: _onChanged,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Buscar artículo por descripción o código...',
            hintStyle: const TextStyle(fontSize: 16),
            prefixIcon: const Icon(Icons.search, size: 26),
            suffixIcon: _buscando
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        if (_resultados.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 240),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _resultados.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final articulo = _resultados[index];
                final precio = articulo.promocionVigente
                    ? '\$${articulo.precioVentaPesos.toStringAsFixed(2)} → \$${articulo.precioVigentePesos.toStringAsFixed(2)}'
                    : '\$${articulo.precioVentaPesos.toStringAsFixed(2)}';

                return ListTile(
                  title: Text(
                    articulo.descripcion,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '$precio'
                    '${articulo.stockActual != null ? ' · stock: ${articulo.stockActual}' : ''}',
                    style: TextStyle(
                      fontSize: 15,
                      color: articulo.promocionVigente ? Colors.green : null,
                      fontWeight: articulo.promocionVigente ? FontWeight.bold : null,
                    ),
                  ),
                  trailing: const Icon(Icons.add_circle_outline, size: 28),
                  onTap: () => _seleccionar(articulo),
                );
              },
            ),
          ),
      ],
    );
  }
}
