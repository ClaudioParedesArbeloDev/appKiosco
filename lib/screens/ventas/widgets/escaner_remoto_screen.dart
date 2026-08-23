import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/barcode_scanner_core.dart';
import '../../../providers/sesiones_pos_providers.dart';
import '../../../services/secure_storage_service.dart';

const _prefijoEmparejamiento = 'arbelo-pos:';

/// Pantalla del lado celular: primero escanea el QR de emparejamiento que
/// muestra la PC, después escanea código tras código y los va mandando al
/// backend, que se los reenvía a la PC en tiempo real.
///
/// El emparejamiento queda guardado (dura todo el día, ver `SesionPos` en
/// el backend) así que no hace falta re-escanear el QR en cada venta — solo
/// la primera vez del día, o si la sesión ya venció.
class EscanerRemotoScreen extends ConsumerStatefulWidget {
  const EscanerRemotoScreen({super.key});

  @override
  ConsumerState<EscanerRemotoScreen> createState() => _EscanerRemotoScreenState();
}

class _EscanerRemotoScreenState extends ConsumerState<EscanerRemotoScreen> {
  String? _sesionId;
  bool _emparejando = false;
  bool _cargandoSesionGuardada = true;

  final _storage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _cargarSesionGuardada();
  }

  Future<void> _cargarSesionGuardada() async {
    final sesionId = await _storage.getPairingSessionId();
    if (!mounted) return;
    setState(() {
      _sesionId = sesionId;
      _cargandoSesionGuardada = false;
    });
  }

  Future<void> _onQrDetectado(String codigo) async {
    if (_emparejando || !codigo.startsWith(_prefijoEmparejamiento)) {
      if (!codigo.startsWith(_prefijoEmparejamiento)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ese código no es de emparejamiento con una caja.')),
        );
      }
      return;
    }

    setState(() => _emparejando = true);

    final pairingToken = codigo.substring(_prefijoEmparejamiento.length);

    try {
      final sesionId =
          await ref.read(sesionesPosRepositoryProvider).parear(pairingToken);

      await _storage.savePairingSession(id: sesionId, pairingToken: pairingToken);

      if (!mounted) return;
      setState(() => _sesionId = sesionId);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No pudimos emparejar: $e')),
      );
    } finally {
      if (mounted) setState(() => _emparejando = false);
    }
  }

  void _onCodigoEscaneado(String codigo) {
    ref.read(sesionesPosRepositoryProvider).scan(_sesionId!, codigo).catchError((e) async {
      debugPrint('Error al enviar $codigo: $e');

      // La sesión de hoy venció o ya no existe: se olvida el emparejamiento
      // guardado y se vuelve a pedir el QR, en vez de seguir fallando en
      // silencio en cada escaneo.
      final vencida = e is DioException &&
          (e.response?.statusCode == 404 || e.response?.statusCode == 410);

      if (vencida) {
        await _storage.deletePairingSession();
        if (mounted) setState(() => _sesionId = null);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(vencida ? 'El emparejamiento venció, escaneá el QR de nuevo' : 'No se pudo enviar $codigo'),
          ),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Enviado: $codigo'), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cargandoSesionGuardada) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_sesionId == null) {
      return BarcodeScannerCore(
        title: 'Escaneá el QR de la caja',
        cooldown: const Duration(seconds: 1),
        onDetect: _onQrDetectado,
      );
    }

    return BarcodeScannerCore(
      title: 'Escaneando para la caja',
      onDetect: _onCodigoEscaneado,
    );
  }
}
