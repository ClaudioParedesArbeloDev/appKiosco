import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../screens/articulos/articulos_list_screen.dart';
import '../../screens/caja/caja_screen.dart';
import '../../screens/clientes/clientes_list_screen.dart';
import '../../screens/compras/compras_list_screen.dart';
import '../../screens/empleados/empleados_list_screen.dart';
import '../../screens/notas_credito/notas_credito_list_screen.dart';
import '../../screens/perfil/perfil_screen.dart';
import '../../screens/presupuestos/presupuestos_list_screen.dart';
import '../../screens/proveedores/proveedores_list_screen.dart';
import '../../screens/remitos/remitos_list_screen.dart';
import '../../screens/reportes/reportes_screen.dart';
import '../../screens/ventas/pos_screen.dart';
import '../../screens/ventas/ventas_list_screen.dart';
import '../theme/app_colors.dart';

/// Cada pantalla de nivel superior (las que cuelgan directo del Home) es
/// una sección — un solo lugar para el ícono/color/permiso/destino de cada
/// una, así el grid del Home (mobile) y el sidebar (desktop) nunca se
/// desincronizan entre sí. "Escanear para caja" queda afuera a propósito:
/// es mobile-only, no tiene sentido en un sidebar de escritorio.
enum AppSection {
  nuevaVenta,
  articulos,
  clientes,
  ventas,
  caja,
  perfil,
  empleados,
  proveedores,
  compras,
  reportes,
  presupuestos,
  remitos,
  notasCredito,
}

typedef AppSectionItem = ({
  AppSection section,
  IconData icon,
  String label,
  Color color,
  bool visible,
  WidgetBuilder builder,
});

List<AppSectionItem> buildAppSections(UserModel? user) {
  return [
    (
      section: AppSection.nuevaVenta,
      icon: Icons.point_of_sale,
      label: 'Nueva Venta',
      color: AppColors.accentVentas,
      visible: user?.hasPermission('ingresar_ventas') ?? false,
      builder: (_) => const PosScreen(),
    ),
    (
      section: AppSection.articulos,
      icon: Icons.inventory_2,
      label: 'Artículos',
      color: AppColors.accentArticulos,
      visible: true, // lectura abierta a cualquier usuario logueado
      builder: (_) => const ArticulosListScreen(),
    ),
    (
      section: AppSection.clientes,
      icon: Icons.people,
      label: 'Clientes',
      color: AppColors.accentClientes,
      visible: true,
      builder: (_) => const ClientesListScreen(),
    ),
    (
      section: AppSection.ventas,
      icon: Icons.receipt_long,
      label: 'Ventas',
      color: AppColors.accentHistorial,
      visible: user?.hasPermission('consultar_ventas') ?? false,
      builder: (_) => const VentasListScreen(),
    ),
    (
      section: AppSection.caja,
      icon: Icons.point_of_sale_outlined,
      label: 'Caja',
      color: AppColors.accentCaja,
      visible: true, // ver estado/historial abierto a cualquier usuario logueado
      builder: (_) => const CajaScreen(),
    ),
    (
      section: AppSection.perfil,
      icon: Icons.person,
      label: 'Perfil',
      color: AppColors.accentPerfil,
      // Solo admin_comercio: adentro vive la config del comercio,
      // suscripción y Mercado Pago — un empleado no debe verlas.
      visible: user?.isAdminComercio ?? false,
      builder: (_) => const PerfilScreen(),
    ),
    (
      section: AppSection.empleados,
      icon: Icons.badge,
      label: 'Empleados',
      color: AppColors.accentEmpleados,
      visible: user?.isAdminComercio ?? false,
      builder: (_) => const EmpleadosListScreen(),
    ),
    (
      section: AppSection.proveedores,
      icon: Icons.local_shipping,
      label: 'Proveedores',
      color: AppColors.accentProveedores,
      visible: true, // lectura abierta a cualquier usuario logueado
      builder: (_) => const ProveedoresListScreen(),
    ),
    (
      section: AppSection.compras,
      icon: Icons.shopping_cart,
      label: 'Compras',
      color: AppColors.accentCompras,
      visible: user?.hasPermission('ingresar_compras') ?? false,
      builder: (_) => const ComprasListScreen(),
    ),
    (
      section: AppSection.reportes,
      icon: Icons.bar_chart,
      label: 'Reportes',
      color: AppColors.accentReportes,
      visible: user?.hasPermission('ver_reportes') ?? false,
      builder: (_) => const ReportesScreen(),
    ),
    (
      section: AppSection.presupuestos,
      icon: Icons.request_quote,
      label: 'Presupuestos',
      color: AppColors.accentPresupuestos,
      visible: user?.hasPermission('consultar_ventas') ?? false,
      builder: (_) => const PresupuestosListScreen(),
    ),
    (
      section: AppSection.remitos,
      icon: Icons.local_shipping_outlined,
      label: 'Remitos',
      color: AppColors.accentRemitos,
      visible: user?.hasPermission('consultar_ventas') ?? false,
      builder: (_) => const RemitosListScreen(),
    ),
    (
      section: AppSection.notasCredito,
      icon: Icons.assignment_return,
      label: 'Notas de crédito',
      color: AppColors.accentNotasCredito,
      visible: user?.hasPermission('consultar_ventas') ?? false,
      builder: (_) => const NotasCreditoListScreen(),
    ),
  ];
}
