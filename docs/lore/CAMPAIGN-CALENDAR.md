# DA LATA — Calendário da Campanha e Ciclo de Planta

**Estado:** CÂNONE

Este documento fixa a escala temporal de uma campanha de **DA LATA** e a relação narrativa entre passagem do tempo, ciclo de planta e fechamento anual. Ele define abstrações de jogo, não parâmetros agronômicos reais.

## Regra-mãe da campanha

Uma partida completa dura exatamente **365 dias de jogo**.

- **Dia 1:** início da campanha.
- **Dia 365:** limite temporal da campanha e fechamento do ano.
- O calendário é um relógio de pressão narrativa: dinheiro, reputação, memória, relações e institucionalização avançam dentro do mesmo ano.
- O jogo não estende silenciosamente a campanha além do Dia 365 para concluir produção atrasada.

## Ciclo canônico de planta

Cada ciclo completo de planta dura **90 dias de jogo**, tratado pelo balanceamento como **3 meses de produção de 30 dias**.

A ordem canônica dos estados é:

```text
seedling
   ↓
Vega
   ↓
flora
   ↓
late flowering
   ↓
pronta
```

Regras:

- nenhum estágio pode ser pulado na progressão normal;
- `pronta` é o estado terminal do ciclo;
- somente um ciclo que alcança `pronta` conta como ciclo concluído;
- a duração exata de cada estágio dentro dos 90 dias permanece **ABERTA para balanceamento**, mas a soma do ciclo deve continuar sendo 90 dias;
- os nomes acima são estados de jogo e não carregam instruções reais de cultivo.

## Equilíbrio de rendimento

O rendimento é normalizado pelo **ciclo completo**, não pela quantidade de dias atribuída a cada estágio.

**CÂNONE de balanceamento narrativo:**

> um ciclo de 90 dias que chega a `pronta` entrega uma unidade-base equivalente de rendimento final.

Consequências:

- redistribuir dias entre `seedling`, `Vega`, `flora` e `late flowering` não cria rendimento extra por si só;
- estados intermediários não geram múltiplos “finais”;
- o valor numérico da unidade-base pertence à camada de balanceamento e pode ser afetado por sistemas futuros, mas o calendário sozinho não multiplica produção;
- qualquer bônus ou penalidade futura deve declarar explicitamente sua origem; não pode surgir apenas de encurtar um estágio.

## Matemática anual

```text
365 dias de campanha
= 4 ciclos completos × 90 dias
+ 5 dias de fechamento
```

Assim, uma linha iniciada no primeiro dia e reiniciada imediatamente após cada ciclo possui quatro janelas completas no ano:

- ciclo 1: 90 dias;
- ciclo 2: 90 dias;
- ciclo 3: 90 dias;
- ciclo 4: 90 dias;
- saldo anual: 5 dias.

Esses **5 dias finais** funcionam como margem temporal de campanha, resolução, consequências e finale. Eles não formam um quinto ciclo completo.

Isso não proíbe sistemas futuros de lotes sobrepostos ou múltiplos espaços. A regra fixa apenas a duração de **cada ciclo individual** e o limite anual da campanha.

## Relação com a narrativa

O calendário deve ser perceptível na história.

- O primeiro “ciclo sustentável” do Ato I não pode ser concluído antes de uma planta atravessar os cinco estados e alcançar `pronta`.
- Quando uma campanha começa no Dia 1, o primeiro fechamento completo pode acontecer a partir do **Dia 90**.
- Os atos seguintes podem atravessar diferentes ciclos e sobrepor conflitos econômicos, comunitários e de memória.
- A distribuição exata dos Atos II–V pelos dias do ano permanece **ABERTA**; não deve ser inventada apenas para preencher o calendário.
- O Dia 365 é um limite dramático real: decisões ainda abertas chegam ao fechamento anual e alimentam o desfecho disponível, sem transformar uma rota em moralmente correta.

## Invariantes

- campanha: exatamente 365 dias;
- ciclo individual: exatamente 90 dias;
- ordem: `seedling → Vega → flora → late flowering → pronta`;
- `pronta` fecha o ciclo;
- rendimento-base é contabilizado no fechamento do ciclo;
- quatro ciclos completos ocupam 360 dias;
- cinco dias permanecem para fechamento anual;
- duração interna dos estágios é balanceável, desde que preserve ordem e total de 90 dias;
- nenhum detalhe deste documento deve virar instrução de cultivo real.
