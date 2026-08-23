import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../screens/home/home_screen.dart';
import '../navigation/app_section.dart';
import '../theme/app_colors.dart';

/// Sidebar fijo para pantallas anchas — muestra las mismas secciones que
/// la grilla del Home, para no tener que volver a Home cada vez que se
/// quiere cambiar de módulo. `current` es null en el propio Home (ninguna
/// sección resaltada) y el `AppSection` correspondiente en cada pantalla
/// de nivel superior. Navega con `pushReplacement` — cambiar de módulo no
/// debería ir apilando pantallas iguales una arriba de otra.
class AppSidebar extends ConsumerWidget {
  const AppSidebar({super.key, required this.current});

  final AppSection? current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final secciones = buildAppSections(user).where((s) => s.visible).toList();

    return Container(
      width: 236,
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            _SidebarTile(
              icon: Icons.home_outlined,
              label: 'Inicio',
              color: AppColors.primary,
              seleccionado: current == null,
              onTap: current == null
                  ? null
                  : () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(height: 1),
            ),
            for (final seccion in secciones)
              _SidebarTile(
                icon: seccion.icon,
                label: seccion.label,
                color: seccion.color,
                seleccionado: current == seccion.section,
                onTap: current == seccion.section
                    ? null
                    : () => Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: seccion.builder)),
              ),
          ],
        ),
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.seleccionado,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool seleccionado;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: seleccionado ? color.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: seleccionado ? color : AppColors.primaryDark, size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: seleccionado ? color : AppColors.primaryDark,
                      fontWeight: seleccionado ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
