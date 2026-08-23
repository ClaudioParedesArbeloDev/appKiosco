import 'dart:async';
import 'package:flutter/material.dart';

/// Reloj con fecha y hora que se actualiza solo, cada segundo.
class LiveClock extends StatefulWidget {
  const LiveClock({super.key, this.textStyle, this.crossAxisAlignment = CrossAxisAlignment.end});

  final TextStyle? textStyle;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  // Argentina no usa horario de verano desde 2009: UTC-3 fijo todo el año,
  // sin importar la zona horaria configurada en el dispositivo.
  static const _offsetArgentina = Duration(hours: -3);

  static const _diasSemana = [
    'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo',
  ];

  static DateTime _horaArgentina() => DateTime.now().toUtc().add(_offsetArgentina);

  DateTime _now = _horaArgentina();
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = _horaArgentina());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _dosDigitos(int n) => n.toString().padLeft(2, '0');

  String get _fecha =>
      '${_diasSemana[_now.weekday - 1]}, ${_dosDigitos(_now.day)}/${_dosDigitos(_now.month)}/${_now.year}';

  String get _hora =>
      '${_dosDigitos(_now.hour)}:${_dosDigitos(_now.minute)}:${_dosDigitos(_now.second)}';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        Text(_fecha, style: widget.textStyle),
        Text(_hora, style: widget.textStyle),
      ],
    );
  }
}
