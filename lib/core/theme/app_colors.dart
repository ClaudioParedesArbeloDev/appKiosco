import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Magenta vivo del isologo de Code & Lens — es el color de marca, se usa
  // para acciones principales (botones, enlaces, foco).
  static const primary = Color(0xFFE30B6D);
  // Magenta profundo del isologo — barra superior, fondos oscuros, texto
  // de marca.
  static const primaryDark = Color(0xFF4E0827);
  static const primaryLight = Color(0xFFE2B5C9);
  static const white = Color(0xFFFFFFFF);

  static const background = Color(0xFFF6F7FB);
  static const backgroundDark = Color(0xFF0B1530);

  // Texto sobre fondo oscuro (splash, login, topbar) — usado por CompanyTitle.
  static const textPrimary = white;
  static const textSecondary = primaryLight;

  static const success = Color(0xFF1E9E6F);
  static const danger = Color(0xFFE0505F);
  static const warning = Color(0xFFE8A23C);

  // Acentos por módulo del Home — cada tile tiene su propio color en vez
  // de repetir siempre el mismo azul, para que el menú principal se lea
  // con más vida sin perder cohesión (misma familia de saturación/brillo).
  static const accentVentas = primary;
  static const accentArticulos = Color(0xFFE0913D);
  static const accentClientes = Color(0xFF8B5FE0);
  static const accentHistorial = Color(0xFF1FA6A6);
  static const accentCaja = Color(0xFFE0637A);
  static const accentPerfil = Color(0xFF6C7A94);
  static const accentEscanear = Color(0xFF23AFCB);
  static const accentEmpleados = Color(0xFF4F9D6E);
  static const accentProveedores = Color(0xFF3D7A9E);
  static const accentCompras = Color(0xFFB5892C);
  static const accentReportes = Color(0xFF6E5AA8);
  static const accentPresupuestos = Color(0xFF5C7CE0);
  static const accentRemitos = Color(0xFF3D9E7A);
  static const accentNotasCredito = Color(0xFFCC5B5B);
}
