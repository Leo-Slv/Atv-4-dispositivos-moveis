# Spec – Aplicativo de pedidos de restaurante (Aula 4 – Navegação entre telas)

## Objetivo
App Flutter com 5 telas para montar um pedido, usando `Navigator` + `MaterialPageRoute`.

## Telas
1. **Prato principal** – >= 3 opções com preço, seleciona uma.
2. **Bebida** – >= 3 opções com preço, seleciona uma.
3. **Sobremesa** – >= 3 opções com preço, seleciona uma.
4. **Forma de pagamento** – Pix, cartão de crédito, cartão de débito, dinheiro.
5. **Finalização** – itens escolhidos, preço de cada, total e forma de pagamento.

## Regras (obrigatórias)
- R1: só avança após selecionar uma opção na tela atual.
- R2: nas telas 2, 3 e 4 é possível voltar à anterior (`pop`) ou direto ao início (`popUntil isFirst`).
- R3: ao voltar, a escolha permanece selecionada e pode ser alterada.
- R4: na finalização não é possível retornar (sem botão voltar no AppBar, `PopScope(canPop:false)`); única ação "Novo pedido" -> primeira tela com escolhas reiniciadas.
- R5: valores em reais com 2 casas (`formatarValor`).

## Requisitos técnicos
- `Navigator`/`MaterialPageRoute`; dados passados por construtores.
- `StatefulWidget` + `setState` para seleções.
- Cardápio e preços definidos no código.
- Retorno de dados via `Navigator.pop(context, valor)` / `await Navigator.push<T>()` para preservar escolhas (R3).
- Estrutura:
```
lib/
  main.dart
  models/item_cardapio.dart        (conteúdo fornecido)
  utils/formatar_valor.dart        (conteúdo fornecido)
  telas/tela_prato_principal.dart, tela_bebida.dart, tela_sobremesa.dart,
        tela_pagamento.dart, tela_finalizacao.dart
```

## Design
- Cada tela recebe as escolhas anteriores e a sua própria escolha atual (`escolhaInicial`) pelo construtor.
- Ao avançar, `await Navigator.push` retorna a escolha atualizada da tela seguinte? Não: a escolha de cada tela é devolvida à tela anterior via pop com resultado; cada tela mantém seu estado e repassa adiante o estado do que vem depois. Mais simples: o estado do pedido (pratos, bebida, sobremesa) fica nos State das telas; ao voltar, a tela anterior já está viva na pilha, logo a escolha dela permanece. Ao reabrir a tela seguinte, esta recebe sua escolha anterior como `escolhaInicial` (guardada no State da tela pai).
- "Voltar ao início" a partir das telas 2-4 descarta a pilha (`popUntil`); novo pedido reinicia tudo (`pushAndRemoveUntil` para nova `TelaPratoPrincipal`).

## Execução
Flutter não instalado na máquina: build/análise/testes via Docker (`ghcr.io/cirruslabs/flutter`).
