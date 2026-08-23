import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/env/app_env.dart';
import '../core/network/api_base_url.dart';
import '../core/network/api_endpoints.dart';
import '../core/producto.dart';

class GoogleAuthService {
  static Future<void> initializeMobile() async {
    await GoogleSignIn.instance.initialize(
      clientId: Platform.isIOS ? AppEnv.googleClientIdIos : null,
      serverClientId: AppEnv.googleClientIdWeb,
    );
  }

  Future<String?> signInMobile() async {
    final account = await GoogleSignIn.instance.authenticate();
    return account.authentication.idToken;
  }

  Future<void> signInDesktop() async {
    final authUrl = Uri.parse('${ApiBaseUrl.value}${ApiEndpoints.googleRedirect}')
        .replace(queryParameters: {'producto': kProducto});
    await launchUrl(authUrl, mode: LaunchMode.externalApplication);
  }
}
