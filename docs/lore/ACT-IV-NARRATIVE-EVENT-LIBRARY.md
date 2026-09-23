# DA LATA — Ato IV Narrative Event Library

Este documento decompõe **Ato IV — O Sistema** em contratos narrativos implementation-ready.

A wave é deliberadamente narrativa-only. Ela define significado, pré-condições, escolhas, flags, relações, sinais e guardrails; não implementa Resources, UI, save state, balanceamento ou regras de gameplay.

---

# Objetivo do ato

Ato IV muda a pergunta central da campanha:

> de **“qual versão é verdadeira?”**
> para **“quem ganha o direito de decidir qual versão será lembrada?”**

A **Ferrugem** representa tempo, perda e falsificação.

O Conselho Cívico da Baía transforma Influence em participação sistêmica, nunca em controle de pessoas, políticos ou resultado institucional.

## Invariantes do Ato IV

- Isa Valente é mediadora de processo, não árbitra moral.
- O Conselho é ficcional, sistêmico e não corresponde a parlamento ou órgão real.
- Nenhuma escolha usa políticos, partidos, eleições, segmentação de eleitores ou persuasão direcionada.
- O lote Ferrugem contém materiais de estados mistos: parte autenticável, parte recente e parte impossível de datar.
- “Autêntico” nunca significa “prova de linhagem contínua de DA LATA”.
- A Fita do Farol continua sem data e voz definitivamente provadas.
- O Caderno de Sal continua sem autoria/composição definitivamente provadas.
- A ordem e origem comum de Onda, Sol, Ferrugem e Estrela continuam **ABERTAS**.
- O sobrenatural continua não confirmado.
- Nenhuma rota econômica anterior é tratada como moralmente correta.
- Consequências do Ato III alteram tom, acesso e confiança; não reescrevem fatos históricos.

---

# 1. A Mesa Não É Palco

**ID:** event_isa_mesa_sem_palco  
**Janela:** abertura do Ato IV, após o convite ao Conselho Cívico da Baía.  
**Local narrativo:** Centro Baixo / Conselho Cívico da Baía.  
**Estado-base:** CÂNONE sobre Isa, o Conselho e a função de Influence.

## Pré-condições

- arc_dois_mercados concluído;
- convite ao Conselho recebido;
- Isa Valente ainda não apresentada em cena;
- nenhum resultado do Conselho pode depender de concordar pessoalmente com Isa.

## Participantes

- Isa Valente;
- jogador;
- Caio Brandão como presença técnica opcional;
- observadores de facções podem aparecer apenas como vozes contextuais.

## Batida dramática

Antes da primeira sessão pública, Isa chama o jogador para uma conversa curta.

Ela explica que o Conselho não foi criado para produzir consenso, mas para tornar **trade-offs legíveis antes de virarem regra**.

Isa sabe que empresas querem velocidade, comunidades querem reciprocidade, pesquisadores querem proteção de evidência e operadores menores querem não ser esmagados pelo custo de entrada.

Ela não pergunta “qual lado é o certo?”.

Ela pergunta:

> “Quando você falar aqui dentro, o que você aceita deixar registrado contra você amanhã?”

A cena introduz sua tensão central: **participação versus espetáculo**.

## Escolhas

### A. Declarar interesses e contradições antes de defender propostas

O jogador aceita que sua posição tenha custos visíveis e histórico consultável.

**Flags**
- lore_isa_process_introduction_seen = true
- choice_isa_disclose_tradeoffs = true

**Relações**
- Isa considera a postura útil para comparação futura entre discurso e decisões.
- Caio vê ganho de legibilidade institucional.
- Helena pode interpretar transparência como custo de negociação.

**Sinais**
- signal_legitimacy_up
- signal_influence_up
- signal_flexibility_down

### B. Entrar como operador e defender previsibilidade econômica

O jogador deixa claro que sua prioridade é transformar conflito em regras que permitam planejamento.

**Flags**
- lore_isa_process_introduction_seen = true
- choice_isa_predictability_first = true

**Relações**
- Isa registra a posição sem tratá-la como menos cívica.
- Maya e Helena podem reconhecer coerência com escala.
- Joana pode cobrar quem absorve o custo da previsibilidade.

**Sinais**
- signal_formal_stability_up
- signal_scale_up
- signal_community_neutral

### C. Usar o assento para ampliar vozes com menos acesso

O jogador prioriza mecanismos de participação de operadores e territórios com menor presença institucional.

**Flags**
- lore_isa_process_introduction_seen = true
- choice_isa_access_first = true

**Relações**
- Isa alerta que ampliar participação também aumenta tempo e conflito.
- Joana valoriza a abertura.
- Helena e Maya podem cobrar previsibilidade de processo.

**Sinais**
- signal_community_up
- signal_influence_up
- signal_delay_up

## Callbacks do Ato III

- choice_caio_public_clarification pode fazer Isa citar o histórico do jogador de transformar ambiguidade privada em registro público.
- choice_helena_shared_attribution pode abrir uma linha sobre autoria compartilhada de memória.
- choice_nando_keep_fragmented pode gerar uma pergunta sobre como representar redes sem transformá-las em uma entidade única.

## Invariantes

- Isa nunca premia “concordar com ela”.
- A entrada no Conselho não exige rota formal, paralela ou corporativa específica.
- Influence mede acesso e capacidade de participar, não poder de mandar no processo.

---

# 2. O Lote Ferrugem

**ID:** event_leilao_ferrugem  
**Janela:** início/meio do Ato IV, depois da apresentação de Isa.  
**Local narrativo:** leilão privado ficcional conectado ao Arquivo da Maré.  
**Estado-base:** CÂNONE sobre a existência do lote; estado misto sobre seus itens.

## Pré-condições

- Rui Sal conhecido;
- Lúcia conhecida;
- lore_isa_process_introduction_seen = true;
- Fita do Farol já descoberta;
- nenhuma escolha pode autenticar uma linhagem histórica contínua.

## Participantes

- Rui Sal;
- Dra. Lúcia Vilar;
- jogador;
- Helena Prado ou Joana Cedro como variante contextual opcional.

## Batida dramática

Surge um lote de documentos, fotografias, envelopes e cópias atribuído por vendedores ao “núcleo perdido” do Caderno de Sal.

Lúcia faz uma leitura preliminar:

- alguns materiais têm suporte, desgaste e procedência compatíveis com acervo antigo;
- alguns são claramente cópias ou inserções recentes;
- alguns não podem ser datados com segurança.

Rui considera o conjunto valioso justamente porque mostra décadas de edição e recirculação.

O mercado, por outro lado, tenta vender a mistura inteira como uma única origem.

A tensão é **preservar evidência sem deixar que a raridade transforme incerteza em autenticidade comercial**.

## Escolhas

### A. Apoiar aquisição pelo Aurora com cadeia de procedência explícita

O jogador prioriza conservação técnica e classificação por evidência.

**Flags**
- lore_ferrugem_lot_seen = true
- choice_ferrugem_aurora_custody = true

**Relações**
- Lúcia ganha confiança.
- Rui teme que acesso público fique lento ou excessivamente filtrado.
- Helena reconhece valor em uma procedência mais defensável.

**Sinais**
- signal_research_up
- signal_legitimacy_up
- signal_access_down

### B. Apoiar custódia compartilhada entre arquivo, pesquisa e comunidade

O jogador tenta impedir que uma única instituição defina sozinha o significado do lote.

**Flags**
- lore_ferrugem_lot_seen = true
- choice_ferrugem_shared_custody = true

**Relações**
- Rui e Joana veem valor no acesso distribuído.
- Lúcia aceita se as categorias de evidência não forem diluídas.
- Helena considera a governança mais lenta e mais difícil de licenciar.

**Sinais**
- signal_memory_up
- signal_community_up
- signal_complexity_up

### C. Não disputar a posse; financiar apenas registro e cópia do conjunto

O jogador aceita que o lote possa se dispersar, mas tenta preservar informação verificável sobre sua existência e procedência.

**Flags**
- lore_ferrugem_lot_seen = true
- choice_ferrugem_document_without_ownership = true

**Relações**
- Rui respeita a recusa em confundir preservação com posse.
- Lúcia alerta para perda de oportunidade de exame material posterior.
- Helena considera a opção economicamente pouco defensiva.

**Sinais**
- signal_cash_neutral
- signal_memory_up
- signal_research_down

## Invariantes

- o lote nunca é chamado de “Caderno original” como fato;
- material antigo não autentica genética, linhagem ou autoria;
- nenhum item recente precisa ser tratado como fraude deliberada: cópia, anotação e remontagem também fazem parte da história de circulação;
- leilão e aquisição permanecem abstratos, sem instruções operacionais.

---

# 3. Quem Assina a Memória

**ID:** event_ferrugem_quem_assina_memoria  
**Janela:** meio do Ato IV, após triagem inicial do lote Ferrugem.  
**Local narrativo:** Instituto Aurora / Arquivo da Maré / exposição temporária.  
**Estado-base:** CÂNONE sobre a classificação mista do lote; ABERTO sobre autoria e sequência histórica.

## Pré-condições

- lore_ferrugem_lot_seen = true;
- Lúcia concluiu uma primeira classificação sem autenticar o conjunto inteiro;
- o jogador já tem histórico suficiente para que facções cobrem coerência entre discurso e prática.

## Participantes

- Lúcia;
- Rui;
- Joana;
- jogador;
- Isa pode aparecer como observadora de processo, não como autoridade científica.

## Batida dramática

A triagem produz um problema inesperado.

As categorias técnicas de Lúcia são claras, mas a forma de apresentar o material ao público não é.

Uma legenda simples como “arquivo de DA LATA” apaga a mistura de datas.

Uma legenda técnica demais torna invisível o conflito cultural que fez o conjunto sobreviver.

Rui quer mostrar versões lado a lado.

Joana pergunta quem aparece como fonte e quem some no rodapé.

Isa pergunta quem terá poder de corrigir o registro depois.

A pergunta do ato fica explícita: **não basta decidir o que é verdadeiro; é preciso decidir quem pode nomear, contestar e revisar o que será lembrado**.

## Escolhas

### A. Publicar por classes de evidência

Cada item aparece com estado explícito: compatível, recente, indeterminado ou contestado.

**Flags**
- lore_ferrugem_mixed_evidence_public = true
- choice_memory_evidence_classes = true

**Relações**
- Lúcia considera o sistema auditável.
- Rui teme que categorias pareçam mais definitivas do que realmente são.
- Joana cobra espaço para procedência social além de material.

**Sinais**
- signal_research_up
- signal_legitimacy_up
- signal_mystery_down

### B. Publicar versões concorrentes com autoria explícita

O catálogo mostra interpretações incompatíveis e identifica quem sustenta cada leitura.

**Flags**
- lore_ferrugem_mixed_evidence_public = true
- choice_memory_competing_annotations = true

**Relações**
- Rui aprova a visibilidade do conflito.
- Lúcia exige que opinião não seja visualmente confundida com evidência.
- Isa considera o modelo coerente com processo contestável.

**Sinais**
- signal_memory_up
- signal_reputation_up
- signal_complexity_up

### C. Manter itens indeterminados fora da narrativa principal por enquanto

O jogador publica apenas o que possui suporte suficiente e mantém o restante acessível como material em revisão.

**Flags**
- lore_ferrugem_mixed_evidence_public = true
- choice_memory_hold_indeterminate = true

**Relações**
- Lúcia vê prudência.
- Rui teme que “por enquanto” se torne esquecimento.
- Joana cobra prazo e direito de contestação.

**Sinais**
- signal_risk_down
- signal_research_up
- signal_public_attention_down

## Invariantes

- classificação de evidência não fecha autoria do Caderno;
- nenhuma apresentação pública prova ordem das quatro marcas;
- nenhuma escolha transforma memória comunitária em evidência material;
- nenhuma escolha rebaixa memória oral a algo “sem valor”; ela apenas possui estatuto diferente de prova material.

---

# 4. A Audiência do Período Verde

**ID:** event_audiencia_periodo_verde  
**Janela:** meio/final do Ato IV.  
**Local narrativo:** Conselho Cívico da Baía.  
**Estado-base:** CÂNONE sobre o debate sistêmico; propostas e resultados permanecem ficcionais.

## Pré-condições

- Isa apresentada;
- lore_ferrugem_mixed_evidence_public = true;
- Influence suficiente para participação substantiva;
- todas as facções centrais continuam capazes de aparecer independentemente da rota econômica do jogador.

## Participantes

- Isa Valente — mediação;
- Caio Brandão — leitura técnica de regras;
- Maya Santiago — acesso e previsibilidade no varejo;
- Helena Prado — escala e capital;
- Joana Cedro — reciprocidade e acesso;
- Lúcia Vilar — pesquisa e preservação;
- Rui Sal — memória e arquivo;
- Nando Trama — voz contextual de redes independentes, sem representar uma organização central;
- jogador.

## Batida dramática

O Conselho debate um pacote regulatório ficcional para a próxima fase do Período Verde.

As propostas afetam, em diferentes combinações:

- custo de compliance;
- acesso de pequenos operadores;
- pesquisa;
- preservação cultural;
- projetos comunitários;
- previsibilidade de mercado;
- velocidade de expansão.

Isa impede que a sessão vire desfile de slogans ao exigir que cada defesa registre **benefício, custo e grupo que absorve o custo**.

Nenhum bloco é escrito como solução perfeita.

O jogador pode usar Influence para priorizar uma emenda e formar apoio institucional, mas nunca controla pessoas nem garante o resultado sozinho.

## Escolhas

### A. Priorizar previsibilidade regulatória com transição escalonada

Defende regras mais legíveis e uma janela de adaptação, reduzindo mudanças bruscas.

**Flags**
- lore_audiencia_periodo_verde_seen = true
- choice_audiencia_predictable_transition = true

**Relações**
- Caio e Maya reconhecem ganho de estabilidade.
- Joana questiona se operadores menores conseguem atravessar a transição sem apoio adicional.
- Helena vê ambiente melhor para investimento.

**Sinais**
- signal_formal_stability_up
- signal_risk_down
- signal_change_speed_down

### B. Priorizar acesso e contrapartidas comunitárias

Defende mecanismos que reduzam barreiras para operadores pequenos e vinculem parte do crescimento a capacidade local.

**Flags**
- lore_audiencia_periodo_verde_seen = true
- choice_audiencia_access_reciprocity = true

**Relações**
- Joana ganha confiança.
- Helena alerta para aumento de coordenação e custo.
- Maya vê potencial para ampliar fornecedores, mas exige critérios previsíveis.

**Sinais**
- signal_community_up
- signal_legitimacy_up
- signal_complexity_up

### C. Priorizar pesquisa e preservação com acesso público condicionado

Defende incentivos à pesquisa e proteção de acervos, com regras para não transformar patrimônio em propriedade narrativa exclusiva.

**Flags**
- lore_audiencia_periodo_verde_seen = true
- choice_audiencia_research_memory = true

**Relações**
- Lúcia valoriza recursos para preservação.
- Rui cobra que acesso não seja apenas promessa institucional.
- Helena observa oportunidade de inovação e disputa de direitos.

**Sinais**
- signal_research_up
- signal_memory_up
- signal_cash_pressure_up

### D. Priorizar flexibilidade entre modelos com revisão obrigatória

Defende uma regra menos rígida, mas com reavaliação pública após efeitos observáveis.

**Flags**
- lore_audiencia_periodo_verde_seen = true
- choice_audiencia_adaptive_review = true

**Relações**
- Caio vê capacidade de correção, mas teme instabilidade.
- Nando reconhece espaço para autonomia sem centralização.
- Maya e Helena cobram horizonte claro para decisões de escala.

**Sinais**
- signal_adaptation_up
- signal_autonomy_up
- signal_uncertainty_up

## Callbacks do Ato III

- choice_caio_adapt_early pode mudar a cobrança de Caio sobre previsibilidade.
- choice_caio_use_transition pode abrir linha sobre janela de adaptação.
- choice_helena_limited_pilot ou choice_helena_shared_attribution altera a posição de Helena sobre propriedade de identidade.
- choice_maya_keep_cedro_visible pode reforçar a disputa sobre origem comunitária versus campanha de marca.
- choice_nando_reduce_dependency ou choice_nando_keep_fragmented muda o tom de Nando sobre institucionalização.
- choice_false_original_no_amplification pode ser citado quando Rui discute regras de publicidade e memória.

## Invariantes

- o Conselho não é parlamento, eleição ou campanha política real;
- não existem partidos ou políticos reais;
- o jogador não compra voto, não pressiona indivíduos e não recebe instruções de persuasão direcionada;
- Influence altera acesso e capacidade de negociação sistêmica, nunca controle;
- nenhuma escolha é moralmente privilegiada;
- toda proposta tem beneficiários, custos e efeitos secundários.

---

# 5. A Estrela no Verso

**ID:** event_foto_estrela  
**Janela:** fechamento do Ato IV.  
**Local narrativo:** Instituto Aurora, com publicação posterior no arquivo.  
**Estado-base:** CÂNONE sobre compatibilidade material limitada; ABERTO sobre linhagem, autoria e significado final da Estrela.

## Pré-condições

- lore_audiencia_periodo_verde_seen = true;
- lote Ferrugem examinado;
- Fita do Farol preservada;
- objeto da Onda disponível no histórico da campanha;
- nenhum estado anterior pode ter autenticado uma linhagem contínua.

## Participantes

- Lúcia;
- Rui;
- Bento;
- jogador;
- Isa ou Joana como variante de reação pública.

## Batida dramática

Lúcia reúne três documentos do lote Ferrugem, a Fita do Farol e um objeto já conhecido da investigação.

Ela consegue sustentar algo novo — e cuidadosamente limitado:

**os materiais compartilham uma origem material compatível dentro de uma mesma rede de circulação documental.**

Isso não prova:

- autoria única;
- data exata de todos os itens;
- ordem original das quatro marcas;
- origem botânica;
- continuidade genética;
- que toda peça seja antiga.

Ao revisar uma fotografia já conhecida em melhor conservação, Bento nota um detalhe no verso: uma **Estrela**.

Rui quer anunciar “as quatro marcas reunidas”.

Lúcia corrige:

> “Reunidas agora. Não necessariamente juntas antes.”

O encerramento do ato entrega avanço real sem transformar o mistério em certeza total.

## Escolhas

### A. Publicar uma nota técnica curta com limites explícitos

O jogador prioriza precisão e reduz espaço para interpretações excessivas.

**Flags**
- lore_material_origin_compatibility_established = true
- lore_star_mark_revealed = true
- lore_original_lineage_still_unproven = true
- choice_star_publish_technical_limits = true

**Sinais**
- signal_research_up
- signal_legitimacy_up
- signal_public_attention_neutral

### B. Publicar o conjunto com anotações concorrentes e histórico de revisão

O jogador trata a descoberta como evidência e como memória em disputa ao mesmo tempo.

**Flags**
- lore_material_origin_compatibility_established = true
- lore_star_mark_revealed = true
- lore_original_lineage_still_unproven = true
- choice_star_publish_contested_archive = true

**Sinais**
- signal_memory_up
- signal_reputation_up
- signal_complexity_up

### C. Registrar a descoberta e adiar a narrativa pública ampla

O jogador preserva o material e mantém acesso de pesquisa, mas evita transformar a Estrela imediatamente em campanha de marca.

**Flags**
- lore_material_origin_compatibility_established = true
- lore_star_mark_revealed = true
- lore_original_lineage_still_unproven = true
- choice_star_delay_public_story = true

**Sinais**
- signal_risk_down
- signal_research_up
- signal_reputation_neutral

## Invariantes

- compatibilidade material não equivale a identidade histórica total;
- Estrela não prova que as quatro marcas nasceram juntas;
- a fotografia não autentica o Caderno inteiro;
- o evento não cria uma “genética original” recuperável;
- o Ato V continua sendo reconstrução contemporânea, não recuperação de uma relíquia pura.

---

# Ordem sugerida da wave

~~~text
Ato IV início
  -> event_isa_mesa_sem_palco
  -> event_leilao_ferrugem

Ato IV meio
  -> event_ferrugem_quem_assina_memoria
  -> event_audiencia_periodo_verde

Ato IV final
  -> event_foto_estrela
  -> transição para arc_da_lata
~~~

A ordem de variantes pode mudar conforme relações e flags anteriores.

Os cinco eventos centrais não podem ser bloqueados por uma única rota econômica ou moral.

---

# Flags canônicas da wave

Flags de observação/estado:

~~~text
lore_isa_process_introduction_seen
lore_ferrugem_lot_seen
lore_ferrugem_mixed_evidence_public
lore_audiencia_periodo_verde_seen
lore_material_origin_compatibility_established
lore_star_mark_revealed
lore_original_lineage_still_unproven
~~~

Flags choice_* registram postura e consequência do jogador.

Elas nunca podem ser reinterpretadas como prova sobre:

- autoria do Caderno de Sal;
- data/voz da Fita do Farol;
- autenticidade histórica de uma “DA LATA original”;
- ordem original das quatro marcas;
- existência de linhagem genética contínua;
- existência do sobrenatural.

---

# Dependência futura de implementação

Quando SIGA materializar esta wave, deve reutilizar o contrato narrativo existente e manter conteúdo fora da UI hardcoded.

Contrato esperado:

~~~text
NarrativeEventDefinition
- id
- arc_id
- conditions
- participants
- dialogue/content keys
- choices
- choice flags
- relationship effects
- system signals
- lore assertions
- canon guardrails
~~~

Requisitos futuros:

1. arc_o_sistema deve aceitar callbacks do Ato III sem exigir uma “resposta correta”.
2. Isa precisa reagir à consistência do histórico, não à concordância ideológica.
3. A Audiência deve produzir modificadores sistêmicos ficcionais, não controle de indivíduos.
4. Estados de evidência do lote Ferrugem devem permanecer distinguíveis em dados.
5. lore_material_origin_compatibility_established nunca pode ser usado como sinônimo de linhagem autenticada.
6. A transição para arc_da_lata depende de progressão do ato, não de uma escolha política ou econômica específica.
7. Save/schema pertence a uma wave técnica posterior.

---

# Continuidade preservada

## CÂNONE preservado

- Isa mede consistência e qualidade de processo, não concordância.
- Conselho Cívico da Baía é fórum institucional ficcional.
- Ferrugem representa tempo, perda e falsificação.
- O lote possui evidência mista.
- A audiência coloca facções já estabelecidas em conflito sistêmico.
- O encerramento do Ato IV produz compatibilidade material limitada e revela a Estrela.

## RUMOR preservado

- versões sobre origem do Caderno e das quatro marcas;
- interpretações de objetos “originais”;
- possíveis conexões antigas entre fita, documentos e objetos;
- Mulher da Lata.

## ABERTO preservado

- autoria/composição do Caderno de Sal;
- data e voz da Fita do Farol;
- ordem e origem comum das quatro marcas;
- proveniência histórica definitiva do objeto da Onda;
- qualquer continuidade genética desde 1987;
- status sobrenatural;
- forma institucional final de DA LATA no Ato V.

---

# Critério de aceite narrativo

A wave está pronta quando:

1. os cinco eventos cobrem a espinha dorsal de Ato IV sem retcon;
2. Isa entra como mediadora coerente com seu papel canônico;
3. o lote Ferrugem mantém estados de evidência mistos;
4. a pergunta do ato muda de verdade para governança da memória;
5. a Audiência apresenta trade-offs sistêmicos e ficcionais sem política real;
6. nenhuma rota anterior bloqueia o núcleo do ato;
7. callbacks do Ato III alteram relação/tom, não fatos históricos;
8. Estrela é revelada sem autenticar ordem comum ou linhagem;
9. o fechamento prepara Ato V como reconstrução contemporânea;
10. IDs e flags são estáveis o suficiente para futura materialização técnica.
