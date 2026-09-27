# DA LATA — Biblioteca de Eventos Narrativos — Ato I: O Quarto

Este documento materializa os beats centrais já definidos para **Ato I — O Quarto** em contratos narrativos prontos para futura implementação em Resources/event data.

A wave é **narrativa-only**. Ela não define números de balanceamento, produção, cultivo, rotas, logística, evasão, compliance real, UI ou schema de save.

## Objetivos

- dar ao Ato I uma espinha narrativa implementation-ready equivalente aos atos seguintes;
- apresentar Maya, Nando e Dalva sem transformar nenhum deles em tutorial ambulante;
- colocar dinheiro, risco, reputação, memória, comunidade e identidade em tensão desde o começo;
- preservar que a escolha entre mercado formal e paralelo nunca bloqueia permanentemente um caminho;
- entregar a lata marcada com **Onda** sem autenticar sua procedência;
- fechar o ato com o jogador sustentável o suficiente para poder formalizar parte da operação, sem definir uma rota moralmente correta.

---

# Contrato de evento

Cada evento define:

- **ID estável**;
- **janela narrativa**;
- **estado-base**;
- **pré-condições narrativas**;
- **participantes**;
- **batida dramática**;
- **escolhas do jogador**;
- **flags de lore**;
- **ecos relacionais**;
- **sinais sistêmicos abstratos**;
- **invariantes de continuidade**.

## Convenção de sinais

Os sinais abaixo são semânticos. Valores pertencem ao design mecânico futuro.

- `signal_cash_up|down|neutral`
- `signal_reputation_up|down|neutral`
- `signal_risk_up|down|neutral`
- `signal_community_up|down|neutral`
- `signal_legitimacy_up|down|neutral`
- `signal_memory_up|down|neutral`
- `signal_autonomy_up|down|neutral`

Nenhum sinal determina sozinho verdade histórica, relação fixa ou ending.

---

# 1. Duas portas no mesmo dia

**ID:** `event_duas_portas_mesmo_dia`  
**Janela:** abertura do Ato I, após o jogador conseguir operar o primeiro espaço no Morro do Cedro.  
**Estado-base:** CÂNONE sobre Maya e Nando apresentarem oportunidades no mesmo dia; ABERTO sobre qual oportunidade o jogador prioriza.

## Pré-condições

- `arc_o_quarto` ativo;
- `district_morro_cedro` como origem operacional;
- Maya e Nando podem ser apresentados;
- nenhuma relação futura está bloqueada.

## Participantes

- Maya;
- Nando;
- jogador.

## Batida dramática

No mesmo dia, o jogador recebe duas propostas que tratam o mesmo problema de formas incompatíveis.

Maya oferece uma oportunidade formal pequena. O valor imediato é limitado, mas a relação pode construir previsibilidade e reputação.

Nando oferece uma oportunidade mais bem paga e mais incerta. O dinheiro chega com menos promessa de continuidade e mais risco abstrato.

Nenhum dos dois vende a própria rota como destino final.

Maya quer saber se o jogador consegue cumprir o que promete.

Nando quer saber se o jogador entende que velocidade também tem preço.

A escolha inaugura a pergunta central do ato:

**o que vale mais agora: margem, nome ou autonomia?**

## Escolhas

### A. Priorizar a oportunidade de Maya

O jogador escolhe previsibilidade e reputação como primeiro sinal público.

**Flags**
- `choice_act1_first_market_formal = true`
- `lore_maya_first_offer_seen = true`
- `lore_nando_first_offer_seen = true`

**Ecos**
- Maya registra o jogador como alguém disposto a construir consistência.
- Nando não interpreta a escolha como ruptura; ele passa a testar se a formalização vai realmente atender às urgências do jogador.

**Sinais**
- `signal_reputation_up`
- `signal_legitimacy_up`
- `signal_cash_neutral`
- `signal_risk_down`

### B. Priorizar a oportunidade de Nando

O jogador escolhe liquidez e autonomia como primeira resposta.

**Flags**
- `choice_act1_first_market_parallel = true`
- `lore_maya_first_offer_seen = true`
- `lore_nando_first_offer_seen = true`

**Ecos**
- Nando percebe pragmatismo.
- Maya não encerra a relação; ela passa a observar se o jogador consegue transformar urgência em operação previsível.

**Sinais**
- `signal_cash_up`
- `signal_autonomy_up`
- `signal_risk_up`
- `signal_reputation_neutral`

### C. Recusar a falsa escolha de identidade

O jogador escolhe uma das oportunidades para aquele ciclo, mas deixa explícito que não pretende transformar uma transação em identidade permanente.

**Flags**
- `choice_act1_first_market_nonexclusive = true`
- `lore_maya_first_offer_seen = true`
- `lore_nando_first_offer_seen = true`

**Ecos**
- Maya considera a posição válida apenas se compromissos concretos continuarem confiáveis.
- Nando aprova a autonomia, mas lembra que independência sem caixa também pode virar dependência.

**Sinais**
- `signal_autonomy_up`
- `signal_reputation_neutral`
- `signal_risk_neutral`

## Invariantes

- nenhuma escolha bloqueia Casa Clara ou Rede Paralela;
- Maya não é “rota boa” e Nando não é “rota má”;
- a Rede Paralela permanece abstrata, sem logística ou instruções operacionais;
- o evento não define valores, quantidades, preços ou procedimentos reais;
- a primeira escolha registra postura, não destino.

---

# 2. Chuva no Cedro

**ID:** `event_chuva_lata_onda`  
**Janela:** meio do Ato I, depois que o jogador já teve ao menos uma consequência visível da primeira escolha de mercado.  
**Estado-base:** CÂNONE sobre a chuva, a entrega de uma lata antiga vazia por Dalva e a presença da marca **Onda**; ABERTO sobre procedência, idade exata, cadeia de custódia e significado histórico do objeto.

## Pré-condições

- Dalva já conhece o jogador;
- o jogador já enfrentou ao menos uma tensão entre dinheiro, risco e reputação;
- a lata ainda não foi apresentada;
- nenhum documento futuro pode ter autenticado sua procedência antecipadamente.

## Participantes

- Dalva;
- jogador.

## Batida dramática

Depois de uma chuva forte, Dalva encontra o jogador lidando com as pequenas consequências de crescer num lugar em que tudo fica perto demais: trabalho, vizinhança, barulho, promessa e memória.

Ela entrega uma lata antiga vazia.

No fundo, quase apagado, existe o símbolo de uma **Onda**.

Dalva diz que a lata não vale nada.

Quando o jogador pergunta de onde veio, ela responde apenas o suficiente para impedir uma conclusão fácil:

**ela viu quem encontrou.**

Não diz quando.
Não diz onde.
Não diz se o objeto é raro.
Não diz se existe outro igual.

A cena não transforma a lata em tesouro. Ela transforma o passado em problema.

## Escolhas

### A. Guardar sem anunciar

O jogador trata o objeto como memória antes de tratá-lo como oportunidade.

**Flags**
- `lore_onda_can_received = true`
- `choice_onda_can_private = true`

**Ecos**
- Dalva respeita a ausência de espetáculo.
- A procedência continua exatamente tão aberta quanto antes.

**Sinais**
- `signal_memory_up`
- `signal_reputation_neutral`

### B. Perguntar por contexto, não por autenticação

O jogador pede a Dalva que diga apenas o que ela realmente lembra.

**Flags**
- `lore_onda_can_received = true`
- `choice_onda_can_context = true`

**Ecos**
- Dalva diferencia lembrança, rumor e prova.
- A conversa prepara o jogador para a disciplina que Lúcia exigirá no Ato II.

**Sinais**
- `signal_memory_up`
- `signal_research_neutral`

### C. Admitir que ainda não sabe o que o objeto significa

O jogador recusa transformar a lata imediatamente em marca, mercadoria ou prova.

**Flags**
- `lore_onda_can_received = true`
- `choice_onda_can_uncertain = true`

**Ecos**
- Dalva considera a incerteza uma resposta aceitável.
- A lata pode ganhar importância depois sem parecer que o jogador já conhecia seu papel.

**Sinais**
- `signal_memory_up`
- `signal_autonomy_up`

## Invariantes

- a lata não é autenticada;
- Dalva não afirma possuir ou ter encontrado “a original”;
- a marca Onda existe fisicamente no objeto;
- o evento não prova relação histórica com Sol, Ferrugem ou Estrela;
- a chuva não recebe explicação sobrenatural;
- nenhuma escolha altera a evidência do objeto.

---

# 3. O quarto também é uma história

**ID:** `event_quarto_como_origem`  
**Janela:** segunda metade do Ato I, quando o jogador já consegue imaginar uma operação maior do que o espaço inicial.  
**Estado-base:** CÂNONE sobre o quarto ser a origem da campanha; ABERTO sobre o significado que o jogador atribui a essa origem.

## Pré-condições

- `event_duas_portas_mesmo_dia` concluído;
- `event_chuva_lata_onda` concluído ou disponível;
- crescimento suficiente para a expansão deixar de parecer impossível;
- nenhuma decisão futura sobre mudança, múltiplos espaços ou formalização é tomada por este evento.

## Participantes

- Dalva;
- Maya ou Nando como eco contextual, conforme histórico;
- jogador.

## Batida dramática

O espaço que parecia provisório começa a carregar sinais de permanência.

Não porque ficou grande.

Porque acumulou decisões.

Dalva provoca o jogador: quando todo mundo disser que o quarto era “óbvio” depois que as coisas derem certo, qual versão ele pretende contar?

A pergunta não é sentimental.

Ela toca reputação, comunidade e identidade.

Maya, se mais próxima, trata a origem como prova de que uma operação pequena pode construir consistência.

Nando, se mais próximo, trata a origem como lembrança de que autonomia nasce antes de existir estrutura suficiente para protegê-la.

Nenhuma leitura substitui a outra.

## Escolhas

### A. “Origem é referência”

O jogador assume que crescer não exige apagar o ponto de partida.

**Flags**
- `choice_act1_origin_reference = true`

**Ecos**
- futuras falas podem citar o quarto como referência de identidade;
- isso não obriga o jogador a permanecer pequeno.

**Sinais**
- `signal_memory_up`
- `signal_reputation_up`

### B. “Origem é etapa”

O jogador recusa romantizar precariedade.

**Flags**
- `choice_act1_origin_stage = true`

**Ecos**
- personagens podem reconhecer ambição sem tratar crescimento como traição;
- Dalva pode lembrar que superar uma condição não exige fingir que ela nunca existiu.

**Sinais**
- `signal_autonomy_up`
- `signal_legitimacy_up`

### C. “Origem cria responsabilidade”

O jogador interpreta crescimento como aumento de responsabilidade com quem estava perto antes de existir reputação.

**Flags**
- `choice_act1_origin_reciprocity = true`

**Ecos**
- a escolha pode alimentar callbacks com Joana no Ato II;
- não cria dívida mecânica nem obrigação automática.

**Sinais**
- `signal_community_up`
- `signal_memory_up`

## Invariantes

- o evento não obriga permanência no quarto;
- não transforma pobreza ou improviso em virtude moral;
- crescimento continua válido em todas as rotas;
- nenhum personagem passa a possuir autoridade sobre a identidade do jogador;
- o Morro do Cedro continua lugar vivo, não decoração nostálgica.

---

# 4. Levado a sério

**ID:** `event_primeiro_ciclo_sustentavel`  
**Janela:** encerramento do Ato I, quando o jogador conclui o primeiro ciclo sustentável e a formalização parcial passa a ser possível; sob o calendário canônico, isso não ocorre antes de um ciclo de 90 dias alcançar `pronta`.  
**Estado-base:** CÂNONE sobre o encerramento do primeiro ciclo sustentável; ABERTO sobre o que o jogador considera “ser levado a sério”.

## Pré-condições

- os principais beats do Ato I concluídos;
- Maya e Nando apresentados;
- lata da Onda recebida;
- nenhuma rota de mercado permanentemente bloqueada;
- transição para `arc_o_negocio` disponível.

## Participantes

- jogador;
- Maya;
- Nando;
- Dalva como fechamento contextual.

## Batida dramática

O jogador alcança o primeiro ponto em que a operação deixa de parecer um acidente prestes a acabar.

Maya reconhece capacidade suficiente para conversar sobre uma relação mais estruturada.

Nando reconhece que o jogador já tem algo que outros agentes passam a levar em conta.

Dalva não celebra “virar empresa”.

Ela pergunta o que mudou de verdade.

O encerramento do ato transforma a fantasia inicial — sobreviver tempo suficiente para ser levado a sério — numa nova pergunta:

**ser levado a sério por quem, e a que custo?**

## Escolhas

### A. Credibilidade

O jogador define o próximo passo como provar consistência sem depender de explicação pessoal.

**Flags**
- `choice_act1_serious_credibility = true`

**Ecos**
- Maya responde bem à clareza;
- Ato II pode usar a flag em tensões de contrato e reputação.

**Sinais**
- `signal_reputation_up`
- `signal_legitimacy_up`

### B. Autonomia

O jogador define o próximo passo como crescer sem entregar todas as decisões a compradores maiores.

**Flags**
- `choice_act1_serious_autonomy = true`

**Ecos**
- Nando reconhece a prioridade;
- Maya pode discordar da leitura sem encerrar a relação.

**Sinais**
- `signal_autonomy_up`
- `signal_risk_neutral`

### C. Reciprocidade

O jogador define o próximo passo como crescer sem fazer a origem desaparecer da contabilidade moral da própria história.

**Flags**
- `choice_act1_serious_reciprocity = true`

**Ecos**
- prepara callbacks com Joana e Community no Ato II;
- Dalva aceita a intenção, mas rejeita promessa grandiosa sem consequência.

**Sinais**
- `signal_community_up`
- `signal_memory_up`

## Invariantes

- todas as escolhas permitem entrar no Ato II;
- formalização parcial torna-se possibilidade, não obrigação moral;
- mercado formal e paralelo continuam disponíveis;
- a lata da Onda continua sem autenticação;
- nenhuma escolha declara uma identidade final do jogador.

---

# Ordem narrativa da wave

A ordem recomendada é:

```text
event_duas_portas_mesmo_dia
        |
        v
event_chuva_lata_onda
        |
        v
event_quarto_como_origem
        |
        v
event_primeiro_ciclo_sustentavel
        |
        v
arc_o_negocio
```

`event_chuva_lata_onda` pode acontecer antes ou depois de alguns ecos menores de mercado, desde que:

- a primeira tensão de dinheiro/risco já tenha sido apresentada;
- a lata seja recebida antes do encerramento do ato;
- nenhum personagem trate a Onda como evidência autenticada.

---

# Flags canônicas da wave

## Fatos de campanha

- `lore_maya_first_offer_seen`
- `lore_nando_first_offer_seen`
- `lore_onda_can_received`

## Postura do jogador

Primeira tensão de mercado:
- `choice_act1_first_market_formal`
- `choice_act1_first_market_parallel`
- `choice_act1_first_market_nonexclusive`

Lata da Onda:
- `choice_onda_can_private`
- `choice_onda_can_context`
- `choice_onda_can_uncertain`

Origem:
- `choice_act1_origin_reference`
- `choice_act1_origin_stage`
- `choice_act1_origin_reciprocity`

Encerramento:
- `choice_act1_serious_credibility`
- `choice_act1_serious_autonomy`
- `choice_act1_serious_reciprocity`

Flags de escolha registram interpretação e postura. Elas não promovem RUMOR ou ABERTO para CÂNONE.

---

# Continuidade preservada

## Maya

- começa transacional;
- não representa pureza moral;
- pode se tornar parceira, crítica ou rival;
- acredita que padrão pode abrir mercado sem negar seus custos.

## Nando

- representa uma rede informal descentralizada, não uma organização única;
- não fornece detalhes operacionais;
- velocidade e liquidez convivem com risco e volatilidade;
- não vira antagonista por contraste com Maya.

## Dalva

- entrega a lata sem autenticar;
- distingue memória de prova;
- evita transformar a origem do jogador ou da cidade em mercadoria simples;
- não controla a interpretação do protagonista.

## Morro do Cedro

- continua origem, comunidade e pequeno operador;
- não é romantizado como lugar em que o jogador “deveria” permanecer;
- crescimento não apaga automaticamente relação com o território.

## DA LATA

- ainda não é projeto, marca ou cultivar reconstruída no Ato I;
- existe apenas como horizonte narrativo futuro;
- a Onda é pista, não prova de linhagem.

---

# Dependências futuras

Esta wave não cria diálogo beat sheets nem codex entries próprios do Ato I.

Próximas camadas possíveis, somente depois desta biblioteca ser aceita:

1. beat sheets de diálogo dos quatro eventos do Ato I;
2. codex/memory entries para os beats que realmente mereçam persistência no arquivo;
3. Resources/event data consumindo os IDs acima;
4. callbacks do Ato II que leiam as flags sem transformar escolha em verdade histórica.

---

# Critério de aceite narrativo

A wave está coerente quando:

- os quatro eventos cobrem abertura, mito, identidade de origem e fechamento do Ato I;
- Maya, Nando e Dalva preservam suas contradições já canônicas;
- nenhuma rota de mercado é bloqueada pela primeira escolha;
- dinheiro, risco, reputação, memória, comunidade e identidade aparecem como tensões, não como placar moral;
- a lata marcada com Onda permanece sem procedência autenticada;
- não há instrução operacional de cultivo, mercado paralelo, evasão ou logística;
- o encerramento conduz ao Ato II sem escolher pelo jogador o que “crescer certo” significa.
