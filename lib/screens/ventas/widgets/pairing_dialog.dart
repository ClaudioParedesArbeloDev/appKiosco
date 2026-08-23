import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../controllers/cart_controller.dart';
import '../../../core/realtime/reverb_client.dart';
import '../../../providers/articulos_providers.dart';
import '../../../providers/sesiones_pos_providers.dart';
import '../../../services/secure_storage_service.dart';

/// Diálogo que muestra un QR para emparejar el celular como lector remoto
/// del carrito de esta venta. Cada código que llega por el canal en tiempo
/// real se busca en el catálogo del comercio y, si existe, se agrega solo.
class PairingDialog extends ConsumerStatefulWidget {
  const PairingDialog({super.key});

  @override
  ConsumerState<PairingDialog> createState() => _PairingDialogState();
}

class _PairingDialogState extends ConsumerState<PairingDialog> {
  final _realtimeClient = ReverbClient();
  final _ultimosEscaneos = <String>[];

  String? _pairingToken;
  String? _error;
  bool _yaEmparejado = false;

  // Se guarda en initState (no en dispose) porque `ref` puede no ser seguro
  // de usar una vez que el widget está en proceso de destruirse.
  late final _sesionesPosRepository = ref.read(sesionesPosRepositoryProvider);
  final _storage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    try {
      final token = await _storage.getToken();
      if (token == null) throw Exception('Sesión no válida.');

      final sesionGuardadaId = await _storage.getPairingSessionId();
      final sesionGuardadaToken = await _storage.getPairingSessionToken();

      String sesionId;
      String pairingToken;
      var reusada = false;

      if (sesionGuardadaId != null && sesionGuardadaToken != null) {
        try {
          // Revalida contra el backend que la sesión de hoy siga viva.
          await _sesionesPosRepository.parear(sesionGuardadaToken);
          sesionId = sesionGuardadaId;
          pairingToken = sesionGuardadaToken;
          reusada = true;
        } catch (_) {
          await _storage.deletePairingSession();
          final sesion = await _sesionesPosRepository.crear();
          sesionId = sesion.id;
          pairingToken = sesion.pairingToken;
          await _storage.savePairingSession(id: sesionId, pairingToken: pairingToken);
        }
      } else {
        final sesion = await _sesionesPosRepository.crear();
        sesionId = sesion.id;
        pairingToken = sesion.pairingToken;
        await _storage.savePairingSession(id: sesionId, pairingToken: pairingToken);
      }

      if (!mounted) return;

      setState(() {
        _pairingToken = pairingToken;
        _yaEmparejado = reusada;
      });

      await _realtimeClient.conectarASesion(
        sesionId: sesionId,
        token: token,
        onCodigoEscaneado: _onCodigoEscaneado,
      );
    } catch (e) {
      if (mounted) setState(() => _error = 'No pudimos iniciar el emparejamiento: $e');
    }
  }

  Future<void> _usarOtroCelular() async {
    await _storage.deletePairingSession();
    await _realtimeClient.desconectar();
    if (!mounted) return;
    setState(() {
      _pairingToken = null;
      _yaEmparejado = false;
      _ultimosEscaneos.clear();
      _error = null;
    });
    await _iniciar();
  }

  Future<void> _onCodigoEscaneado(String codigo) async {
    try {
      final resultado = await ref.read(articulosRepositoryProvider).buscarPorCodigo(codigo);

      if (!mounted) return;

      if (resultado != null && resultado.esArticuloPropio) {
        ref.read(cartProvider.notifier).agregar(resultado.articulo!);
        setState(() => _ultimosEscaneos.insert(0, '✓ ${resultado.articulo!.descripcion}'));
      } else {
        setState(() => _ultimosEscaneos.insert(0, '✗ $codigo — no encontrado, cargalo primero'));
      }
    } catch (e) {
      if (mounted) setState(() => _ultimosEscaneos.insert(0, '✗ $codigo — error al buscar'));
    }
  }

  @override
  void dispose() {
    // La sesión NO se borra acá a propósito: dura todo el día (ver
    // SesionPos::booted en el backend), así que sigue disponible la próxima
    // vez que se abra este diálogo sin tener que re-escanear el QR.
    _realtimeClient.desconectar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Emparejar celular'),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red))
            else if (_pairingToken == null)
              const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              )
            else if (_yaEmparejado) ...[
              const Icon(Icons.smartphone, size: 48, color: Colors.green),
              const SizedBox(height: 8),
              const Text(
                'Celular ya emparejado — escaneá y se agrega solo al carrito.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _usarOtroCelular,
                child: const Text('Usar otro celular'),
              ),
              if (_ultimosEscaneos.isNotEmpty) ...[
                const Divider(height: 24),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: _ultimosEscaneos.length,
                    itemBuilder: (context, index) => Text(_ultimosEscaneos[index]),
                  ),
                ),
              ],
            ] else ...[
              const Text('Escaneá este código con la app en tu celular:'),
              const SizedBox(height: 16),
              QrImageView(
                data: 'arbelo-pos:$_pairingToken',
                size: 220,
              ),
              const SizedBox(height: 16),
              const Text(
                'Queda emparejado para todo el día — no hace falta volver a escanear.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              if (_ultimosEscaneos.isNotEmpty) ...[
                const Divider(height: 24),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: _ultimosEscaneos.length,
                    itemBuilder: (context, index) => Text(_ultimosEscaneos[index]),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Listo'),
        ),
      ],
    );
  }
}
