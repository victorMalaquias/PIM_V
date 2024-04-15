// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pim5/main.dart';

void main() {
  testWidgets('Teste de Reserva de Equipamento', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verifica se o widget de título da tela inicial está presente
    expect(find.byKey(Key('appTitle')), findsOneWidget);

    // Selecione um equipamento específico para reserva
    await tester.tap(find.text('Datashow'));
    await tester.pump();

    // Verifica se o nome do equipamento está presente na tela de detalhes
    expect(find.text('Datashow'), findsOneWidget);

    // Toca no botão de reserva
    await tester.tap(find.text('Reservar'));
    await tester.pump();

    // Verifica se a tela de reserva foi carregada
    expect(find.text('Reservar Datashow'), findsOneWidget);

    // Toca no botão de Confirmar Reserva
    await tester.tap(find.text('Confirmar Reserva'));
    await tester.pump();

    // Verifica se a mensagem de reserva concluída está presente
    expect(find.text('Reserva Concluída'), findsOneWidget);

    // Você pode adicionar mais verificações conforme necessário, como voltar à tela inicial
    // e verificar se a quantidade disponível foi atualizada
  });
}
