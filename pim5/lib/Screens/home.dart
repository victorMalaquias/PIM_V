// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/equipamentos.dart';
import '../Components/provider.dart';
import '../Modelos/equipamento.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final equipamentos =
        Provider.of<EquipamentoReservaProvider>(context).equipamentos;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: equipamentos.length,
        itemBuilder: (context, index) {
          Equipamento equipamento = equipamentos[index];
          return Card(
            child: ListTile(
              title: Text(equipamento.nome),
              subtitle:
                  Text('Quantidade disponível: ${equipamento.quantidade}'),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipamentoDetails(
                      equipamento: equipamento,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
