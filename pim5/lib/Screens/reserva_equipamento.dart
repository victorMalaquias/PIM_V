// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, empty_statements, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pim5/Screens/home.dart';
import 'package:provider/provider.dart';

import '../Components/provider.dart';
import '../Modelos/equipamento.dart';

class ReservaEquipamento extends StatefulWidget {
  final Equipamento equipamento;

  ReservaEquipamento({required this.equipamento});

  @override
  _ReservaEquipamentoState createState() => _ReservaEquipamentoState();
}

class _ReservaEquipamentoState extends State<ReservaEquipamento> {
  late DateTime _dataReserva = DateTime.now();
  late TimeOfDay _horaReserva = TimeOfDay.now();
  late String _sala = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar ${widget.equipamento.nome}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Data da Reserva'),
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy').format(_dataReserva),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _dataReserva = selectedDate;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Hora da Reserva'),
                controller: TextEditingController(
                  text: _horaReserva.format(context),
                ),
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      _horaReserva = selectedTime;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Sala'),
                onChanged: (value) {
                  setState(() {
                    _sala = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              child: Text('Confirmar Reserva'),
              onPressed: () {
                confirmarReserva(widget.equipamento);
              },
            ),
          ],
        ),
      ),
    );
  }

  void confirmarReserva(Equipamento equipamento) {
    final equipamentoProvider =
        Provider.of<EquipamentoReservaProvider>(context, listen: false);

    // Validar data, hora e sala
    if (!isDataHoraValida(_dataReserva, _horaReserva, (String errorMessage) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Erro de Validação'),
                content: Text(errorMessage),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Fechar o diálogo
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }) ||
        _sala.isEmpty) {
      return;
    }

    // Verificar disponibilidade do equipamento
    if (equipamento.quantidade <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sem Disponibilidade'),
            content: Text(
                'Desculpe, não há mais disponibilidade para ${equipamento.nome}.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => MyHomePage(
                          title: 'Sistema de Reserva de Equipamentos'))));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Diminuir a quantidade disponível do equipamento
    equipamentoProvider.reservarEquipamento(
        equipamento, _sala, _dataReserva, _horaReserva);

// Exibir mensagem de reserva concluída
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reserva Concluída'),
          content: Text(
            'Reserva para ${equipamento.nome} na sala $_sala realizada com sucesso!\nData: ${DateFormat('dd/MM/yyyy').format(_dataReserva)}\nHora: ${_horaReserva.format(context)}',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => MyHomePage(
                          title: 'Sistema de Reserva de Equipamentos'))));
                }
                ;
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

bool isDataHoraValida(DateTime data, TimeOfDay hora, Function(String) onError) {
  if (data == null || hora == null) {
    onError('Selecione uma data e uma hora válidas.');
    return false;
  }

  // Validar se a data é posterior à data atual
  if (data.isBefore(DateTime.now())) {
    onError('Selecione uma data futura.');
    return false;
  }

  // Validar se a hora é válida
  if (hora.hour < 0 || hora.hour > 23 || hora.minute < 0 || hora.minute > 59) {
    onError('Selecione uma hora válida.');
    return false;
  }

  return true;
}
