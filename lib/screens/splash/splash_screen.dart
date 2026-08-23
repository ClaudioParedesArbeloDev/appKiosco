import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import 'widgets/app_logo.dart';
import 'widgets/splash_loading_indicator.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final _minDisplayTime = Future.delayed(const Duration(seconds: 2));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    ref.listen(authControllerProvider, (previous, next) async {
      if (next.isLoading) return;

      await _minDisplayTime;
      if (!context.mounted) return;

      final destination = next.value != null ? const HomeScreen() : const LoginScreen();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => destination),
      );
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(size: isDesktop ? 220 : 160),
            const SizedBox(height: 32),
            const SplashLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
