import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../models/pedido.dart';
import '../utils/formatar_valor.dart';
import 'tela_sobremesa.dart';

const List<ItemCardapio> bebidas = [
  ItemCardapio('Suco de laranja', 9.00),
  ItemCardapio('Refrigerante', 7.00),
  ItemCardapio('Água mineral', 4.50),
  ItemCardapio('Cerveja long neck', 12.00),
];

class TelaBebida extends StatefulWidget {
  final Pedido pedido;

  const TelaBebida({super.key, required this.pedido});

  @override
  State<TelaBebida> createState() => _TelaBebidaState();
}

class _TelaBebidaState extends State<TelaBebida> {
  Pedido get pedido => widget.pedido;

  void avancar() {
    if (pedido.bebida == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaSobremesa(pedido: pedido)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Bebida')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha a bebida:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final item in bebidas)
                    ListTile(
                      selected: pedido.bebida == item,
                      leading: Icon(
                        pedido.bebida == item
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                      ),
                      title: Text(item.nome),
                      trailing: Text(formatarValor(item.valor)),
                      onTap: () => setState(() => pedido.bebida = item),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: pedido.bebida == null ? null : avancar,
                child: const Text('Avançar'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (rota) => rota.isFirst),
                child: const Text('Voltar ao início'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
