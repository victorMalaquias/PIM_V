import 'package:flutter/material.dart';

class Reserva {
  final String sala;
  final DateTime data;
  final TimeOfDay hora;

  Reserva({
    required this.sala,
    required this.data,
    required this.hora,
  });
}
