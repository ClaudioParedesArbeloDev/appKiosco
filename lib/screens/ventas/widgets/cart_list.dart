import 'package:flutter/material.dart';
import '../../../models/cart_item.dart';

class CartList extends StatelessWidget {
  const CartList({
    super.key,
    required this.items,
    required this.onCantidadChanged,
    required this.onQuitar,
  });

  final List<CartItem> items;
  final void Function(String articuloId, int cantidad) onCantidadChanged;
  final void Function(String articuloId) onQuitar;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Buscá un artículo para empezar la venta.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          title: Text(
            item.articulo.descripcion,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '\$${item.articulo.precioVigentePesos.toStringAsFixed(2)} c/u',
            style: const TextStyle(fontSize: 15),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 28),
                onPressed: () => onCantidadChanged(item.articulo.id, item.cantidad - 1),
              ),
              Text(
                '${item.cantidad}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 28),
                onPressed: () => onCantidadChanged(item.articulo.id, item.cantidad + 1),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$${item.subtotalPesos.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 26),
                onPressed: () => onQuitar(item.articulo.id),
              ),
            ],
          ),
        );
      },
    );
  }
}
