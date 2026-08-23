import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../screens/home/widgets/home_top_bar.dart';
import '../navigation/app_section.dart';
import '../theme/app_colors.dart';
import 'app_sidebar.dart';

/// Scaffold compartido por las pantallas principales (las que se abren
/// directo desde el Home: Artículos, Ventas, Clientes, Caja, Perfil) —
/// mantiene siempre la misma barra de marca (Code & Lens + comercio + usuario +
/// reloj) en vez de que cada una tenga su propio AppBar suelto, más una
/// franja fina debajo con el título de la pantalla y la flecha de volver.
/// En pantallas anchas (> 900px) también agrega el sidebar de navegación
/// entre módulos y limita el ancho del contenido — en angosto/mobile queda
/// exactamente igual que antes.
///
/// Las pantallas de detalle/edición que cuelgan de estas (ej. el form de un
/// artículo) siguen usando un `Scaffold`/`AppBar` común — repetir la barra
/// de marca ahí adentro solo restaría espacio útil sin aportar nada nuevo.
class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.section,
    this.actions,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;

  /// Qué ítem del sidebar corresponde a esta pantalla — null solo tiene
  /// sentido si algún día se usa `AppScaffold` para algo que no es una
  /// sección de nivel superior.
  final AppSection? section;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final esEscritorioAncho = MediaQuery.of(context).size.width > 900;

    final contenido = Column(
      children: [
        Material(
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                  tooltip: 'Volver',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ...?actions,
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: body,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      floatingActionButton: floatingActionButton,
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
                      AppSidebar(current: section),
                      Expanded(child: contenido),
                    ],
                  )
                : contenido,
          ),
        ],
      ),
    );
  }
}
