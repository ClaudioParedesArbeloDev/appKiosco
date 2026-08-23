import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/subscription_controller.dart';
import '../../core/fiscal_printer/fiscal_printer_registry.dart';
import '../../core/navigation/app_section.dart';
import '../../core/network/validation_errors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../providers/mercado_pago_providers.dart';
import '../../providers/tenant_providers.dart';
import '../home/widgets/user_avatar.dart';
import 'widgets/subscription_status_card.dart';

const _colorTarjeta = Color(0xFF16273D);

/// Pantalla de cuenta: agrupa el perfil personal (nombre), el perfil del
/// comercio (nombre + logo, solo admin_comercio) y el estado de la
/// suscripción (solo admin_comercio) — antes eran cosas sueltas, se juntan
/// acá para que editar cualquier dato de la cuenta sea siempre el mismo
/// lugar, sin tocar la barra superior.
class PerfilScreen extends ConsumerStatefulWidget {
  const PerfilScreen({super.key});

  @override
  ConsumerState<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends ConsumerState<PerfilScreen> {
  late final _nombreUsuarioController = TextEditingController(
    text: ref.read(authControllerProvider).value?.name ?? '',
  );
  late final _nombreComercioController = TextEditingController(
    text: ref.read(authControllerProvider).value?.nombreComercio ?? '',
  );
  late final _puertoImpresoraController = TextEditingController(
    text: ref.read(authControllerProvider).value?.impresoraFiscalPuerto ?? '',
  );
  late final _baudRateImpresoraController = TextEditingController(
    text: (ref.read(authControllerProvider).value?.impresoraFiscalBaudRate ?? 9600).toString(),
  );
  late String? _marcaImpresora = ref.read(authControllerProvider).value?.impresoraFiscalMarca;

  bool _guardandoUsuario = false;
  bool _guardandoComercio = false;
  bool _guardandoImpresora = false;
  bool _subiendoLogo = false;
  bool _launchingCheckout = false;

  bool? _mpConectado;
  bool _procesandoMp = false;

  @override
  void initState() {
    super.initState();
    if (ref.read(authControllerProvider).value?.isAdminComercio ?? false) {
      _consultarEstadoMercadoPago();
    }
  }

  @override
  void dispose() {
    _nombreUsuarioController.dispose();
    _nombreComercioController.dispose();
    _puertoImpresoraController.dispose();
    _baudRateImpresoraController.dispose();
    super.dispose();
  }

  Future<void> _consultarEstadoMercadoPago() async {
    try {
      final conectado = await ref.read(mercadoPagoRepositoryProvider).estaConectado();
      if (mounted) setState(() => _mpConectado = conectado);
    } catch (_) {
      if (mounted) setState(() => _mpConectado = false);
    }
  }

  Future<void> _conectarMercadoPago() async {
    setState(() => _procesandoMp = true);
    try {
      final url = await ref.read(mercadoPagoRepositoryProvider).obtenerUrlDeConexion();
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Conectá tu cuenta en el navegador y volvé acá — deslizá hacia '
            'abajo para actualizar el estado.',
          ),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No pudimos iniciar la conexión: ${_mensajeError(e, 'mp')}')),
        );
      }
    } finally {
      if (mounted) setState(() => _procesandoMp = false);
    }
  }

  Future<void> _desconectarMercadoPago() async {
    setState(() => _procesandoMp = true);
    try {
      await ref.read(mercadoPagoRepositoryProvider).desconectar();
      if (mounted) setState(() => _mpConectado = false);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo desconectar: ${_mensajeError(e, 'mp')}')),
        );
      }
    } finally {
      if (mounted) setState(() => _procesandoMp = false);
    }
  }

  String _mensajeError(Object e, String campo) {
    if (e is! DioException) return e.toString();
    final errores = ValidationErrors.fromDioException(e);
    return errores.forField(campo) ?? errores.message;
  }

  Future<void> _guardarNombreUsuario() async {
    final nombre = _nombreUsuarioController.text.trim();
    if (nombre.isEmpty) return;

    setState(() => _guardandoUsuario = true);
    try {
      await ref.read(authControllerProvider.notifier).actualizarPerfil(name: nombre);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Perfil actualizado')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo actualizar: ${_mensajeError(e, 'name')}')),
        );
      }
    } finally {
      if (mounted) setState(() => _guardandoUsuario = false);
    }
  }

  Future<void> _guardarNombreComercio() async {
    final nombre = _nombreComercioController.text.trim();
    if (nombre.isEmpty) return;

    setState(() => _guardandoComercio = true);
    try {
      await ref.read(tenantRepositoryProvider).actualizarNombre(nombre);
      await ref.read(authControllerProvider.notifier).refrescarUsuario();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Comercio actualizado')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo actualizar: ${_mensajeError(e, 'nombre_comercio')}')),
        );
      }
    } finally {
      if (mounted) setState(() => _guardandoComercio = false);
    }
  }

  Future<void> _guardarImpresoraFiscal() async {
    setState(() => _guardandoImpresora = true);
    try {
      await ref.read(tenantRepositoryProvider).actualizarImpresoraFiscal(
            nombreComercio: _nombreComercioController.text.trim(),
            marca: _marcaImpresora,
            puerto: _puertoImpresoraController.text.trim().isEmpty
                ? null
                : _puertoImpresoraController.text.trim(),
            baudRate: int.tryParse(_baudRateImpresoraController.text.trim()),
          );
      await ref.read(authControllerProvider.notifier).refrescarUsuario();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Configuración guardada')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo guardar: ${_mensajeError(e, 'impresora_fiscal_marca')}')),
        );
      }
    } finally {
      if (mounted) setState(() => _guardandoImpresora = false);
    }
  }

  Future<void> _cambiarLogo() async {
    final resultado = await FilePicker.pickFiles(type: FileType.image, withData: true);
    final archivo = resultado?.files.singleOrNull;
    final bytes = archivo?.bytes;
    if (archivo == null || bytes == null) return;

    setState(() => _subiendoLogo = true);
    try {
      await ref
          .read(tenantRepositoryProvider)
          .actualizarLogo(bytes: bytes, filename: archivo.name);
      await ref.read(authControllerProvider.notifier).refrescarUsuario();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Logo actualizado')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo actualizar el logo: ${_mensajeError(e, 'logo')}')),
        );
      }
    } finally {
      if (mounted) setState(() => _subiendoLogo = false);
    }
  }

  Future<void> _payNow() async {
    setState(() => _launchingCheckout = true);

    try {
      final initPoint = await ref.read(subscriptionControllerProvider.notifier).startCheckout();
      await launchUrl(Uri.parse(initPoint), mode: LaunchMode.externalApplication);
    } on DioException catch (e) {
      if (!mounted) return;
      final errors = ValidationErrors.fromDioException(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errors.message)));
    } finally {
      if (mounted) setState(() => _launchingCheckout = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).value;
    final esAdminComercio = user?.isAdminComercio ?? false;
    final subscriptionAsync = ref.watch(subscriptionControllerProvider);

    return AppScaffold(
      title: 'Perfil',
      section: AppSection.perfil,
      body: Theme(
        data: AppTheme.dark,
        child: Container(
          color: AppColors.backgroundDark,
          child: RefreshIndicator(
            onRefresh: () async {
            await ref.read(subscriptionControllerProvider.notifier).refresh();
            await _consultarEstadoMercadoPago();
          },
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      children: [
                        _Tarjeta(
                          titulo: 'Mi perfil',
                          children: [
                            Center(
                              child: UserAvatar(
                                name: user?.name ?? '',
                                avatarUrl: user?.avatarUrl,
                                radius: 36,
                              ),
                            ),
                            const SizedBox(height: 20),
                            AppTextField(controller: _nombreUsuarioController, label: 'Nombre'),
                            const SizedBox(height: 8),
                            Text(
                              user?.email ?? '',
                              style: const TextStyle(color: AppColors.primaryLight, fontSize: 13),
                            ),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              label: 'Guardar',
                              onPressed: _guardarNombreUsuario,
                              loading: _guardandoUsuario,
                            ),
                          ],
                        ),
                        if (esAdminComercio) ...[
                          const SizedBox(height: 20),
                          _Tarjeta(
                            titulo: 'Mi comercio',
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: _subiendoLogo ? null : _cambiarLogo,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      UserAvatar(
                                        name: user?.nombreComercio ?? '',
                                        avatarUrl: user?.logoComercioUrl,
                                        radius: 36,
                                      ),
                                      Positioned(
                                        bottom: -2,
                                        right: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: _subiendoLogo
                                              ? const SizedBox(
                                                  width: 12,
                                                  height: 12,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: AppColors.white,
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.edit,
                                                  size: 14,
                                                  color: AppColors.white,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              AppTextField(
                                controller: _nombreComercioController,
                                label: 'Nombre del comercio',
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                label: 'Guardar',
                                onPressed: _guardarNombreComercio,
                                loading: _guardandoComercio,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _Tarjeta(
                            titulo: 'Cobros con tarjeta (Mercado Pago)',
                            children: [
                              if (_mpConectado == null)
                                const Center(child: CircularProgressIndicator())
                              else if (_mpConectado == true) ...[
                                const Row(
                                  children: [
                                    Icon(Icons.check_circle, color: AppColors.success, size: 20),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Tu cuenta de Mercado Pago está conectada — ya podés '
                                        'cobrar con un Point desde Nueva Venta.',
                                        style: TextStyle(color: AppColors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                OutlinedButton(
                                  onPressed: _procesandoMp ? null : _desconectarMercadoPago,
                                  child: const Text('Desconectar'),
                                ),
                              ] else ...[
                                const Text(
                                  'Conectá tu cuenta de Mercado Pago para poder cobrar las '
                                  'ventas con un terminal Point.',
                                  style: TextStyle(color: AppColors.primaryLight),
                                ),
                                const SizedBox(height: 16),
                                PrimaryButton(
                                  label: 'Conectar Mercado Pago',
                                  onPressed: _conectarMercadoPago,
                                  loading: _procesandoMp,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 20),
                          _Tarjeta(
                            titulo: 'Impresora fiscal',
                            children: [
                              const Text(
                                'Todavía no imprime tickets fiscales de verdad — esto solo '
                                'guarda qué equipo tenés para cuando se agregue soporte a esa '
                                'marca.',
                                style: TextStyle(color: AppColors.primaryLight, fontSize: 12),
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String?>(
                                initialValue: _marcaImpresora,
                                dropdownColor: _colorTarjeta,
                                style: const TextStyle(color: AppColors.white),
                                decoration: const InputDecoration(labelText: 'Marca'),
                                items: [
                                  const DropdownMenuItem(value: null, child: Text('Sin configurar')),
                                  ...marcasImpresoraFiscalDisponibles.entries.map(
                                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                                  ),
                                ],
                                onChanged: (value) => setState(() => _marcaImpresora = value),
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                controller: _puertoImpresoraController,
                                label: 'Puerto (ej: COM3 o /dev/ttyUSB0)',
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                controller: _baudRateImpresoraController,
                                label: 'Baud rate',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                label: 'Guardar',
                                onPressed: _guardarImpresoraFiscal,
                                loading: _guardandoImpresora,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _Tarjeta(
                            titulo: 'Suscripción',
                            children: [
                              subscriptionAsync.when(
                                loading: () => const Center(child: CircularProgressIndicator()),
                                error: (error, _) => const Text(
                                  'No pudimos cargar tu suscripción.',
                                  style: TextStyle(color: AppColors.white),
                                ),
                                data: (subscription) {
                                  if (subscription == null) {
                                    return const Text(
                                      'Este comercio no tiene ninguna suscripción.',
                                      style: TextStyle(color: AppColors.white),
                                    );
                                  }

                                  return Column(
                                    children: [
                                      SubscriptionStatusCard(subscription: subscription),
                                      if (subscription.needsPayment) ...[
                                        const SizedBox(height: 20),
                                        PrimaryButton(
                                          label: 'Pagar ahora',
                                          onPressed: _payNow,
                                          loading: _launchingCheckout,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Se abre Mercado Pago en el navegador. Cuando '
                                          'termines, volvé a esta pantalla y deslizá hacia '
                                          'abajo para actualizar el estado.',
                                          style: TextStyle(
                                            color: AppColors.primaryLight,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ],
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

class _Tarjeta extends StatelessWidget {
  const _Tarjeta({required this.titulo, required this.children});

  final String titulo;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _colorTarjeta,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style:
                const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}
