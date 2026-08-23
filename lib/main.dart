import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/platform_helper.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'services/deep_link_service.dart';
import 'services/google_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  if (PlatformHelper.isMobile) {
    try {
      await GoogleAuthService.initializeMobile().timeout(const Duration(seconds: 5));
    } catch (e) {
      debugPrint('No se pudo inicializar Google Sign-In: $e');
    }
  }
  if (PlatformHelper.isDesktop) {
    await DeepLinkService.initialize();
  }

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code & Lens Solutions - Gestión',
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}