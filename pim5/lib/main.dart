// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pim5/Login/login.dart';
import 'package:provider/provider.dart';

import 'Components/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => EquipamentoReservaProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Reserva de Equipamentos',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoginPage(),
    );
  }
}
