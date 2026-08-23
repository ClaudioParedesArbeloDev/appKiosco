import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../models/tenant_option.dart';

class DeepLinkService {
  DeepLinkService._();

  static HttpServer? _server;
  static void Function(String token)? onTokenReceived;
  static void Function(String error)? onError;
  static void Function(String ticket, List<TenantOption> tenants)? onTenantSelectionRequired;

  static Future<void> initialize() async {
    try {
      _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8888);
      _server!.listen(_handleRequest);
    } catch (_) {
      // Si el puerto ya está en uso (otra instancia corriendo), no rompemos la app.
    }
  }

  static Future<void> _handleRequest(HttpRequest request) async {
    final token = request.uri.queryParameters['token'];
    final error = request.uri.queryParameters['error'];
    final requiresSelection = request.uri.queryParameters['requires_tenant_selection'];
    final ticket = request.uri.queryParameters['ticket'];
    final tenantsB64 = request.uri.queryParameters['tenants'];

    request.response
      ..statusCode = 200
      ..headers.contentType = ContentType.html
      ..write(_buildHtml(success: token != null || requiresSelection == '1', error: error));
    await request.response.close();

    if (requiresSelection == '1' && ticket != null && tenantsB64 != null) {
      final tenantsJson = jsonDecode(utf8.decode(base64.decode(tenantsB64))) as List;
      final tenants = tenantsJson
          .map((t) => TenantOption.fromJson(t as Map<String, dynamic>))
          .toList();
      onTenantSelectionRequired?.call(ticket, tenants);
    } else if (token != null) {
      onTokenReceived?.call(token);
    } else if (error != null) {
      onError?.call(error);
    }
  }

  static String _buildHtml({required bool success, String? error}) => '''
<!DOCTYPE html>
<html lang="es">
<head><meta charset="utf-8"><title>Code & Lens Solutions</title></head>
<body style="background:#0D1B2A;color:#fff;font-family:sans-serif;display:flex;
  align-items:center;justify-content:center;height:100vh;flex-direction:column;gap:12px;">
  ${success
      ? '<h2>Autenticación exitosa</h2><p>Podés cerrar esta ventana y volver a la app.</p>'
      : '<h2>Error de autenticación</h2><p>${error ?? "Ocurrió un error inesperado."}</p>'}
</body>
</html>
''';

  static void dispose() {
    _server?.close(force: true);
    _server = null;
  }
}
