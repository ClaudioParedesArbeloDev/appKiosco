import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/realtime/reverb_client.dart';
import '../../../providers/sesiones_pos_providers.dart';
import '../../../services/secure_storage_service.dart';

/// Diálogo para leer un código de barras con el celular desde la PC,
/// reusando el mismo mecanismo de emparejamiento (SesionPos + Reverb) que
/// el lector remoto del POS. A diferencia de ese, no filtra por artículo
/// propio: devuelve el primer código que llegue, sea cual sea, para que el
/// formulario decida qué hacer con él.
class RemoteScanDialog extends ConsumerStatefulWidget {
  const RemoteScanDialog({super.key});

  @override
  ConsumerState<RemoteScanDialog> createState() => _RemoteScanDialogState();
}

class _RemoteScanDialogState extends ConsumerState<RemoteScanDialog> {
  final _realtimeClient = ReverbClient();

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
        onCodigoEscaneado: (codigo) {
          if (mounted) Navigator.of(context).pop(codigo);
        },
      );
    } catch (e) {
      if (mounted) setState(() => _error = 'No pudimos iniciar el escaneo: $e');
    }
  }

  Future<void> _usarOtroCelular() async {
    await _storage.deletePairingSession();
    await _realtimeClient.desconectar();
    if (!mounted) return;
    setState(() {
      _pairingToken = null;
      _yaEmparejado = false;
      _error = null;
    });
    await _iniciar();
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
      title: const Text('Escanear con el celular'),
      content: SizedBox(
        width: 320,
        child: _error != null
            ? Text(_error!, style: const TextStyle(color: Colors.red))
            : _pairingToken == null
                ? const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : _yaEmparejado
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.smartphone, size: 48, color: Colors.green),
                          const SizedBox(height: 8),
                          const Text(
                            'Celular ya emparejado — escaneá el código de barras.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          const CircularProgressIndicator(),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: _usarOtroCelular,
                            child: const Text('Usar otro celular'),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Escaneá este código con la app en tu celular:'),
                          const SizedBox(height: 16),
                          QrImageView(data: 'arbelo-pos:$_pairingToken', size: 220),
                          const SizedBox(height: 16),
                          const Text(
                            'Después escaneá el código de barras del producto — se completa solo. '
                            'Queda emparejado para todo el día.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
