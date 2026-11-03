import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedidos_restaurante/main.dart';

Future<void> toque(WidgetTester t, String texto) async {
  await t.tap(find.text(texto));
  await t.pumpAndSettle();
}

void main() {
  testWidgets('fluxo completo do pedido', (t) async {
    await t.pumpWidget(const RootApp());

    // R1: avancar desabilitado sem selecao
    expect(
      t.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Avançar')).onPressed,
      isNull,
    );
    await toque(t, 'Salmão grelhado');
    await toque(t, 'Avançar');

    await toque(t, 'Refrigerante');
    await toque(t, 'Avançar');

    await toque(t, 'Pudim');
    await toque(t, 'Avançar');

    await toque(t, 'Pix');

    // R3: voltar mantem selecao e permite alterar
    await toque(t, 'Voltar');
    expect(find.text('3. Sobremesa'), findsOneWidget);
    await toque(t, 'Avançar');
    expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    await toque(t, 'Avançar');

    expect(find.text('Total: R\$ 75,50'), findsOneWidget);
    expect(find.text('R\$ 56,00'), findsOneWidget);
    expect(find.text('Pagamento: Pix'), findsOneWidget);

    // R4: sem voltar
    expect(find.byType(BackButton), findsNothing);
    await toque(t, 'Novo pedido');
    expect(find.text('1. Prato principal'), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_checked), findsNothing);
  });

  testWidgets('voltar ao inicio', (t) async {
    await t.pumpWidget(const RootApp());
    await toque(t, 'Salmão grelhado');
    await toque(t, 'Avançar');
    await toque(t, 'Voltar ao início');
    expect(find.text('1. Prato principal'), findsOneWidget);
  });
}
