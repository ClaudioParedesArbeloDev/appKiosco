import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/company_title.dart';
import '../../../models/user_model.dart';
import 'live_clock.dart';
import 'sync_status_indicator.dart';
import 'user_avatar.dart';

/// Barra superior de la app: identidad (marca de Code & Lens, nombre del
/// comercio, avatar/nombre/rol de quien está logueado) y la fecha/hora
/// actual. Se usa en el Home y en todas las pantallas principales (ver
/// `AppScaffold`) para que quede siempre visible. Editar el logo/nombre del
/// comercio se hace en la pantalla de Perfil, no tocando esta barra.
/// Responsive: en desktop todo en una fila, en mobile se acomoda en varias
/// líneas para no desbordar en pantallas angostas.
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, required this.user, required this.onLogout});

  final UserModel? user;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final name = user?.name ?? '';
    final role = user?.displayRole ?? '';
    final nombreComercio = user?.nombreComercio;
    final logoComercioUrl = user?.logoComercioUrl;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 16, vertical: isDesktop ? 16 : 12),
        decoration: const BoxDecoration(
          color: AppColors.primaryDark,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: SafeArea(
          bottom: false,
          child: isDesktop
              ? _DesktopLayout(
                  name: name,
                  role: role,
                  avatarUrl: user?.avatarUrl,
                  nombreComercio: nombreComercio,
                  logoComercioUrl: logoComercioUrl,
                  onLogout: onLogout,
                )
              : _MobileLayout(
                  name: name,
                  role: role,
                  avatarUrl: user?.avatarUrl,
                  nombreComercio: nombreComercio,
                  logoComercioUrl: logoComercioUrl,
                  onLogout: onLogout,
                ),
        ),
      ),
    );
  }
}

/// Logo de Code & Lens Solutions chico y discreto — es la marca de la
/// plataforma, no la del comercio, así que no tiene que competir visualmente.
class _CompanyBrand extends StatelessWidget {
  const _CompanyBrand({this.height = 92});

  final double height;

  @override
  Widget build(BuildContext context) {
    // Debajo de ~40px no entra el wordmark completo, así que en el layout
    // mobile (height: 18) queda solo el ícono.
    final showWordmark = height >= 40;
    return Opacity(
      opacity: 0.75,
      child: CompanyTitle(
        iconSize: height * (showWordmark ? 0.3 : 1),
        fontSize: height * 0.15,
        showWordmark: showWordmark,
      ),
    );
  }
}

class _NombreComercio extends StatelessWidget {
  const _NombreComercio({required this.nombre, required this.logoUrl});

  final String nombre;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserAvatar(name: nombre, avatarUrl: logoUrl, radius: 16),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            nombre,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.nombreComercio,
    required this.logoComercioUrl,
    required this.onLogout,
  });

  final String name;
  final String role;
  final String? avatarUrl;
  final String? nombreComercio;
  final String? logoComercioUrl;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _CompanyBrand(),
        Expanded(
          child: Center(
            child: nombreComercio == null || nombreComercio!.isEmpty
                ? const SizedBox.shrink()
                : _NombreComercio(nombre: nombreComercio!, logoUrl: logoComercioUrl),
          ),
        ),
        const LiveClock(
          textStyle: TextStyle(color: AppColors.primaryLight, fontSize: 13),
        ),
        const SizedBox(width: 12),
        const SyncStatusIndicator(),
        const SizedBox(width: 24),
        Container(height: 32, width: 1, color: AppColors.primaryLight.withValues(alpha: 0.3)),
        const SizedBox(width: 24),
        UserAvatar(name: name, avatarUrl: avatarUrl, radius: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            if (role.isNotEmpty)
              Text(role, style: const TextStyle(color: AppColors.primaryLight, fontSize: 12)),
          ],
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.logout, color: AppColors.white),
          tooltip: 'Cerrar sesión',
          onPressed: onLogout,
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.nombreComercio,
    required this.logoComercioUrl,
    required this.onLogout,
  });

  final String name;
  final String role;
  final String? avatarUrl;
  final String? nombreComercio;
  final String? logoComercioUrl;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const _CompanyBrand(height: 18),
            if (nombreComercio != null && nombreComercio!.isNotEmpty) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _NombreComercio(nombre: nombreComercio!, logoUrl: logoComercioUrl),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            UserAvatar(name: name, avatarUrl: avatarUrl, radius: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  if (role.isNotEmpty)
                    Text(
                      role,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.primaryLight, fontSize: 12),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: AppColors.white),
              tooltip: 'Cerrar sesión',
              onPressed: onLogout,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SyncStatusIndicator(),
            const SizedBox(width: 8),
            LiveClock(
              crossAxisAlignment: CrossAxisAlignment.end,
              textStyle: const TextStyle(color: AppColors.primaryLight, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
