// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:pim5/Components/provider.dart';
import 'package:provider/provider.dart';

import '../Modelos/equipamento.dart';
import '../Screens/reserva_equipamento.dart';

class EquipamentoDetails extends StatelessWidget {
  final Equipamento equipamento;

  EquipamentoDetails({
    required this.equipamento,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(equipamento.nome),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  equipamento.nome,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                Text('Quantidade disponível: ${equipamento.quantidade}',
                    style: TextStyle(color: Colors.red, fontSize: 25)),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: ElevatedButton(
                    child: Text(
                      'Reservar',
                      style: TextStyle(fontSize: 25),
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(200, 50))),
                    onPressed: () async {
                      // Navigator.push retorna um Future que pode ser null
                      dynamic result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservaEquipamento(
                            equipamento: equipamento,
                          ),
                        ),
                      );
                      // Verifica se o resultado é diferente de null e é um bool
                      if (result != null && result is bool && result) {
                        // Atualiza o estado usando o Provider
                        Provider.of<EquipamentoReservaProvider>(context,
                                listen: false)
                            .notifyListeners();
                      }
                    },
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
