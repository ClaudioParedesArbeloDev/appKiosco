import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/venta_controller.dart';
import '../../core/fiscal_printer/fiscal_printer_driver.dart';
import '../../core/fiscal_printer/fiscal_printer_registry.dart';
import '../../core/navigation/app_section.dart';
import '../../core/platform_helper.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../models/cliente_model.dart';
import '../../models/venta_model.dart';
import '../../providers/mercado_pago_providers.dart';
import 'widgets/articulo_search_field.dart';
import 'widgets/cart_list.dart';
import 'widgets/cliente_selector_field.dart';
import 'widgets/forma_pago_selector.dart';
import 'widgets/pairing_dialog.dart';
import 'widgets/point_charge_dialog.dart';

class PosScreen extends ConsumerStatefulWidget {
  const PosScreen({super.key});

  @override
  ConsumerState<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends ConsumerState<PosScreen> {
  String _formaPago = 'efectivo';
  ClienteModel? _cliente;
  bool _mpConectado = false;

  @override
  void initState() {
    super.initState();
    _consultarMercadoPago();
  }

  Future<void> _consultarMercadoPago() async {
    try {
      final conectado = await ref.read(mercadoPagoRepositoryProvider).estaConectado();
      if (mounted) setState(() => _mpConectado = conectado);
    } catch (_) {
      // Sin Mercado Pago conectado seguimos con el tilde manual de siempre.
    }
  }

  Future<void> _cobrar() async {
    final items = ref.read(cartProvider);
    if (items.isEmpty) return;

    // Una venta a cuenta corriente necesita saber de quién es la deuda —
    // sin esto el backend la rechaza igual, pero conviene avisar acá antes
    // de mandar la request.
    if (_formaPago == 'cuenta_corriente' && _cliente == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Elegí un cliente para vender a cuenta corriente'),
      ));
      return;
    }

    // Con Mercado Pago conectado, "tarjeta" ya no es solo una etiqueta:
    // primero se cobra de verdad en el Point, y solo si se aprueba se
    // registra la venta. Sin conexión, sigue el tilde manual de siempre.
    if (_formaPago == 'tarjeta' && _mpConectado) {
      final total = ref.read(cartTotalProvider);
      final aprobado = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => PointChargeDialog(montoCentavos: total),
      );

      if (aprobado != true) return;
    }

    await ref.read(ventaControllerProvider.notifier).confirmar(
          items: items,
          formaPago: _formaPago,
          clienteId: _cliente?.id,
        );
  }

  void _emparejarCelular() {
    showDialog(context: context, builder: (_) => const PairingDialog());
  }

  Future<void> _imprimirTicket(VentaModel venta) async {
    final user = ref.read(authControllerProvider).value;
    final marca = user?.impresoraFiscalMarca;
    final puerto = user?.impresoraFiscalPuerto;
    if (marca == null || puerto == null) return;

    try {
      await driverParaMarca(marca).imprimirTicket(
        venta,
        FiscalPrinterConfig(puerto: puerto, baudRate: user?.impresoraFiscalBaudRate ?? 9600),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);
    final ventaState = ref.watch(ventaControllerProvider);
    final user = ref.watch(authControllerProvider).value;

    // El emparejamiento necesita poder vender (ingresar_ventas) y buscar
    // artículos por código (modificar_articulos, porque busca en el
    // catálogo al recibir cada escaneo) — y solo tiene sentido en la PC,
    // el celular no puede recibir su propio escaneo.
    final puedeEmparejar = PlatformHelper.isDesktop &&
        (user?.hasPermission('ingresar_ventas') ?? false) &&
        (user?.hasPermission('modificar_articulos') ?? false);

    ref.listen(ventaControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No pudimos registrar la venta. Probá de nuevo.')),
        );
        return;
      }

      final venta = next.value;
      if (venta != null) {
        ref.read(cartProvider.notifier).vaciar();
        setState(() => _cliente = null);

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(venta.pendienteSync ? 'Venta guardada sin conexión' : '¡Venta registrada!'),
            content: Text(
              venta.pendienteSync
                  ? 'Se sincroniza sola apenas vuelva internet.\nTotal: \$${venta.totalPesos.toStringAsFixed(2)}'
                  : 'Venta #${venta.numero}\nTotal: \$${venta.totalPesos.toStringAsFixed(2)}',
            ),
            actions: [
              if (user?.impresoraFiscalMarca != null)
                TextButton(
                  onPressed: () => _imprimirTicket(venta),
                  child: const Text('Imprimir ticket'),
                ),
              TextButton(
                onPressed: () {
                  ref.read(ventaControllerProvider.notifier).limpiar();
                  Navigator.of(context).pop();
                },
                child: const Text('Nueva venta'),
              ),
            ],
          ),
        );
      }
    });

    return AppScaffold(
      title: 'Nueva Venta',
      section: AppSection.nuevaVenta,
      actions: [
        if (puedeEmparejar)
          IconButton(
            icon: const Icon(Icons.smartphone, color: AppColors.white),
            tooltip: 'Emparejar celular',
            onPressed: _emparejarCelular,
          ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ArticuloSearchField(
              onSeleccionar: (articulo) => ref.read(cartProvider.notifier).agregar(articulo),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CartList(
                items: cart,
                onCantidadChanged: (id, cantidad) =>
                    ref.read(cartProvider.notifier).actualizarCantidad(id, cantidad),
                onQuitar: (id) => ref.read(cartProvider.notifier).quitar(id),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Text(
                  '\$${(total / 100).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClienteSelectorField(
              cliente: _cliente,
              onChanged: (value) => setState(() => _cliente = value),
            ),
            const SizedBox(height: 16),
            FormaPagoSelector(
              value: _formaPago,
              onChanged: (value) => setState(() => _formaPago = value),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: cart.isEmpty || ventaState.isLoading ? null : _cobrar,
                child: ventaState.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Cobrar',
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
