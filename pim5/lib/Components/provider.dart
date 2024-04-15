// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import '../Modelos/equipamento.dart';
import '../Modelos/reserva.dart';

class EquipamentoReservaProvider extends ChangeNotifier {
  List<Equipamento> _equipamentos = [
    Equipamento(nome: 'Datashow', quantidade: 2),
    Equipamento(nome: 'TV com VCR', quantidade: 1),
    Equipamento(nome: 'TV com DVD', quantidade: 1),
    Equipamento(nome: 'Projetor de slides', quantidade: 1),
    Equipamento(nome: 'Sistema de áudio-microfone', quantidade: 1),
    Equipamento(nome: 'Caixa amplificada', quantidade: 1),
    Equipamento(nome: 'Notebooks', quantidade: 3),
    Equipamento(nome: 'Kits multimídia', quantidade: 2),
  ];

  List<Reserva> _reservas = [];

  List<Equipamento> get equipamentos => _equipamentos;

  List<Reserva> get reservas => _reservas;

  void reservarEquipamento(Equipamento equipamento, String sala,
      DateTime dataReserva, TimeOfDay horaReserva) {
    final equipamentoIndex = _equipamentos.indexOf(equipamento);

    if (equipamentoIndex != -1 &&
        _equipamentos[equipamentoIndex].quantidade > 0 &&
        isSalaDisponivel(sala, dataReserva, horaReserva)) {
      _equipamentos[equipamentoIndex].quantidade--;

      _reservas.add(Reserva(
        sala: sala,
        data: dataReserva,
        hora: horaReserva,
      ));

      notifyListeners(); // Notifica os ouvintes sobre a mudança
    }
  }

  bool isSalaDisponivel(String sala, DateTime data, TimeOfDay hora) {
    for (Reserva reserva in _reservas) {
      if (reserva.sala == sala &&
          reserva.data == data &&
          reserva.hora == hora) {
        return false;
      }
    }
    return true;
  }
}
