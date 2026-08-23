import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../core/navigation/app_section.dart';
import '../../core/platform_helper.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_sidebar.dart';
import '../login/login_screen.dart';
import '../ventas/widgets/escaner_remoto_screen.dart';
import 'widgets/home_menu_card.dart';
import 'widgets/home_top_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;

    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null && !next.isLoading) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    // El listado de accesos se arma dinámicamente: cada módulo se muestra
    // solo si el usuario tiene el permiso correspondiente. admin_comercio
    // (UserModel.hasPermission) siempre ve todo. Compartido con el sidebar
    // de AppScaffold — ver core/navigation/app_section.dart.
    final secciones = buildAppSections(user).where((s) => s.visible).toList();
    final esEscritorioAncho = MediaQuery.of(context).size.width > 900;

    final grilla = Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        crossAxisCount: esEscritorioAncho ? 5 : 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.3,
        children: [
          ...secciones.map(
            (seccion) => HomeMenuCard(
              icon: seccion.icon,
              label: seccion.label,
              color: seccion.color,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: seccion.builder),
              ),
            ),
          ),
          // Mobile-only: no es una AppSection porque no tiene sentido en el
          // sidebar de escritorio.
          if (PlatformHelper.isMobile && (user?.hasPermission('ingresar_ventas') ?? false))
            HomeMenuCard(
              icon: Icons.qr_code_scanner,
              label: 'Escanear para caja',
              color: AppColors.accentEscanear,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EscanerRemotoScreen()),
              ),
            ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          HomeTopBar(
            user: user,
            onLogout: () => ref.read(authControllerProvider.notifier).logout(),
          ),
          Expanded(
            child: esEscritorioAncho
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AppSidebar(current: null),
                      Expanded(child: grilla),
                    ],
                  )
                : grilla,
          ),
        ],
      ),
    );
  }
}
