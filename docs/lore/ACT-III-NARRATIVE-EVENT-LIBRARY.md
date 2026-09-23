# DA LATA — Biblioteca de Eventos Narrativos do Ato III

Esta wave transforma o **Ato III — Dois Mercados** em eventos narrativos estáveis e prontos para futura materialização em Resources, sem implementar gameplay, save, UI ou balanceamento.

## Escopo canônico

O Ato III deve aprofundar seis tensões já existentes no cânone:

1. a **Fita do Farol** existe, mas sua data e a identidade da voz não estão provadas;
2. o mercado começa a explorar comercialmente a ideia de um “DA LATA original”;
3. Helena Prado e o Consórcio Atlântico tratam cultura e marca como ativos organizáveis;
4. Nando Trama tenta preservar autonomia conforme o mercado informal muda de escala;
5. Maya Santiago enfrenta a tensão entre consistência formal e acesso de operadores menores;
6. Caio Brandão personifica a diferença entre regra, interpretação e adaptação institucional.

Esta biblioteca não cria uma rota moralmente correta entre mercado formal, mercado paralelo, capital, pesquisa ou comunidade.

## Estados protegidos

### CÂNONE
- Bento possui uma gravação herdada nas caixas do cais.
- A gravação contém referência audível a **Onda, Sol, Ferrugem e Estrela**.
- O Consórcio Atlântico busca consolidar marcas e propriedade intelectual.
- Helena considera DA LATA um ativo cultural/comercial passível de organização.
- Maya quer manter espaço real para fornecedores pequenos dentro de um varejo que exige consistência.
- Nando quer continuar independente enquanto a formalização e a consolidação aumentam.
- Caio tenta fazer um sistema regulatório contraditório funcionar sem transformar burocracia em antagonista simples.
- Ao final do Ato III, o jogador pode alcançar escala empresarial e receber convite para o Conselho Cívico da Baía.

### RUMOR
- a Fita do Farol pode ser anterior à circulação pública conhecida do Caderno de Sal;
- objetos ou produtos vendidos como “originais” podem carregar histórias verdadeiras, falsificadas ou recombinadas;
- versões informais sobre quem primeiro associou as quatro marcas continuam circulando.

### ABERTO
- data exata da Fita do Farol;
- identidade da voz na gravação;
- relação causal entre a fita e o Caderno de Sal;
- ordem histórica das quatro marcas;
- origem comum ou separada das marcas;
- autenticidade histórica de qualquer item comercializado como “original”;
- autoria e composição do Caderno de Sal;
- qualquer camada sobrenatural.

---

# 1. A Fita do Farol

**ID:** `event_bento_fita_farol`  
**Janela:** início/meio do Ato III, após o jogador conhecer Bento.  
**Estado-base:** CÂNONE sobre a existência da fita e o conteúdo audível; ABERTO sobre data, autoria e prioridade histórica.

## Pré-condições

- `arc_dois_mercados` ativo;
- Bento conhecido;
- jogador já encontrou pelo menos duas das quatro marcas;
- nenhuma flag pode afirmar que a fita antecede o Caderno como fato;
- nenhuma escolha pode identificar a voz como M.V. ou qualquer personagem já conhecido sem evidência futura explícita.

## Participantes

- Bento;
- Lúcia;
- Rui;
- jogador.

## Batida dramática

Bento consegue restaurar um trecho suficientemente claro de uma fita herdada das caixas do cais.

No áudio, uma voz enumera quatro palavras:

**Onda. Sol. Ferrugem. Estrela.**

O trecho parece antigo, mas a própria fita possui remendos, regravações e ausência de catalogação confiável.

Bento quer descobrir de quem era a voz.

Rui percebe imediatamente o valor cultural da descoberta.

Lúcia insiste que conteúdo reconhecível não resolve data, autoria nem cadeia de procedência.

A tensão não é “acreditar ou não acreditar”. É decidir **como tratar uma evidência incompleta que pode mudar o mapa das perguntas sem responder nenhuma delas**.

## Escolhas

### A. Entregar uma cópia ao Aurora antes de divulgar

O jogador prioriza documentação e preservação técnica antes de transformar o áudio em notícia.

**Flags**
- `lore_farol_tape_four_marks_heard = true`
- `lore_farol_tape_date_unverified = true`
- `choice_farol_aurora_first = true`

**Relações**
- Lúcia valoriza o procedimento.
- Bento aceita desde que a fita original permaneça sob seu controle.
- Rui considera que o silêncio temporário pode reduzir a chance de novas fontes aparecerem.

**Sinais**
- `signal_research_up`
- `signal_memory_up`
- `signal_reputation_neutral`

### B. Publicar um trecho com a incerteza no mesmo destaque

O jogador aceita a circulação cultural como ferramenta para localizar outras memórias, sem vender a gravação como prova conclusiva.

**Flags**
- `lore_farol_tape_four_marks_heard = true`
- `lore_farol_tape_date_unverified = true`
- `choice_farol_publish_uncertainty = true`

**Relações**
- Rui vê valor em abrir a investigação.
- Lúcia aceita apenas se a incerteza acompanhar toda reprodução.
- Bento ganha esperança de reconhecerem a voz, mas teme perder controle sobre a história.

**Sinais**
- `signal_reputation_up`
- `signal_memory_up`
- `signal_risk_up`

### C. Manter a fita restrita até surgir uma segunda fonte

O jogador decide que a gravação deve existir como pista privada até aparecer evidência independente.

**Flags**
- `lore_farol_tape_four_marks_heard = true`
- `lore_farol_tape_date_unverified = true`
- `choice_farol_hold_for_corrob = true`

**Relações**
- Bento aprecia a cautela.
- Lúcia considera a decisão defensável.
- Rui alerta que algumas fontes só aparecem quando a cidade sabe o que procurar.

**Sinais**
- `signal_risk_down`
- `signal_research_neutral`
- `signal_memory_up`

## Invariantes

- a gravação nunca prova que as quatro marcas surgiram juntas;
- a gravação nunca prova que antecede o Caderno;
- a voz permanece não identificada;
- nenhuma escolha transforma Bento em proprietário da verdade histórica;
- a fita não contém parâmetros reais de cultivo;
- publicação, estudo ou silêncio alteram circulação e relações, não o passado.

---

# 2. O “Original”

**ID:** `event_falso_original`  
**Janela:** meio do Ato III, quando Reputation suficiente faz DA LATA virar referência de mercado.  
**Local narrativo:** Orla da Vigia.  
**Estado-base:** CÂNONE NEGATIVO sobre inexistência de prova de linhagem contínua; RUMOR sobre a história específica do item anunciado.

## Pré-condições

- `arc_dois_mercados` ativo;
- Reputation narrativa suficiente para a expressão “DA LATA” ter valor comercial;
- Lúcia e Rui conhecidos;
- o evento não pode autenticar uma linhagem histórica;
- o objeto ou produto anunciado pode ser antigo, recente ou composto: sua materialidade não deve ser confundida com a veracidade da alegação.

## Participantes

- Lúcia;
- Rui;
- Maya;
- jogador.

## Batida dramática

Uma vitrine temporária na Orla anuncia algo como **“o original de 1987”** usando uma combinação visual das quatro marcas.

A frase corre pela cidade mais rápido que qualquer verificação.

Lúcia considera a alegação cientificamente vazia porque não existe cadeia capaz de sustentar continuidade intacta.

Rui observa que, verdadeira ou falsa, a peça já virou parte da história contemporânea do mito.

Maya se preocupa com consumidores e parceiros tratando a expressão “DA LATA” como se ela já tivesse um dono e uma definição verificável.

O evento transforma a fraude potencial em um problema maior: **o mercado está fabricando memória em tempo real**.

## Escolhas

### A. Catalogar o anúncio como artefato de mercado contestado

O jogador trata a peça como evidência sobre o presente, não como prova sobre 1987.

**Flags**
- `lore_false_original_claim_seen = true`
- `lore_original_lineage_still_unproven = true`
- `choice_false_original_catalog_claim = true`

**Relações**
- Lúcia aprova separar objeto, alegação e procedência.
- Rui gosta de preservar o episódio como parte da vida do mito.
- Maya considera a resposta lenta, mas intelectualmente defensável.

**Sinais**
- `signal_research_up`
- `signal_memory_up`
- `signal_reputation_neutral`

### B. Tornar pública a diferença entre “história”, “marca” e “evidência”

O jogador responde no campo narrativo: não declara quem é dono do mito, apenas recusa equivaler marketing a autenticação histórica.

**Flags**
- `lore_false_original_claim_seen = true`
- `lore_original_lineage_still_unproven = true`
- `choice_false_original_public_distinction = true`

**Relações**
- Maya valoriza clareza pública.
- Lúcia apoia a distinção metodológica.
- Rui teme que uma resposta oficial demais faça o jogador parecer dono de uma história que é maior que sua empresa.

**Sinais**
- `signal_reputation_up`
- `signal_legitimacy_up`
- `signal_risk_up`

### C. Não amplificar a alegação e guardar apenas o registro

O jogador decide que reagir publicamente daria mais valor ao anúncio do que ele merece.

**Flags**
- `lore_false_original_claim_seen = true`
- `lore_original_lineage_still_unproven = true`
- `choice_false_original_no_amplification = true`

**Relações**
- Rui entende a lógica, mas lembra que silêncio também deixa outras pessoas escreverem a versão dominante.
- Lúcia aceita desde que o registro seja preservado.
- Maya considera que a ambiguidade comercial continuará existindo.

**Sinais**
- `signal_risk_down`
- `signal_memory_up`
- `signal_reputation_neutral`

## Invariantes

- nenhuma escolha comprova que o item é historicamente autêntico;
- nenhuma escolha exige que o item seja materialmente falso;
- o que é definitivamente inválido é a pretensão de uma linhagem contínua já comprovada;
- o jogador não ganha propriedade sobre o episódio histórico real;
- o evento não cria uma “genética original” recuperável.

---

# 3. Nome em Contrato

**ID:** `event_helena_nome_em_contrato`  
**Janela:** meio/final do Ato III, após o Consórcio Atlântico reconhecer o crescimento do jogador.  
**Local narrativo:** Arco Norte.  
**Estado-base:** CÂNONE sobre a estratégia de consolidação do Consórcio; ABERTO sobre a futura forma institucional de DA LATA.

## Pré-condições

- Helena conhecida;
- escala empresarial narrativa alcançada;
- `lore_false_original_claim_seen` recomendado, mas não obrigatório;
- o jogador não pode ser tratado como proprietário da memória histórica da cidade;
- o evento não resolve ainda o formato final de DA LATA no Ato V.

## Participantes

- Helena;
- jogador;
- Maya ou Joana como participante contextual opcional conforme relações anteriores.

## Batida dramática

Helena apresenta uma proposta de expansão cuja parte economicamente mais valiosa não é infraestrutura, mas **controle de uso do nome, dos símbolos e da narrativa pública associada a DA LATA**.

Ela não age como vilã.

Para Helena, se ninguém organizar juridicamente e comercialmente a identidade, outra empresa fará isso de modo pior.

Maya pode enxergar capacidade de distribuição.

Joana pode enxergar o risco de a cidade virar material de campanha sem reciprocidade.

O conflito é direto: **quando uma memória vira ativo, organização pode significar proteção — ou captura**.

## Escolhas

### A. Aceitar um piloto comercial com limites narrativos explícitos

O jogador admite escala corporativa, mas separa expansão de qualquer reivindicação de autenticidade histórica.

**Flags**
- `lore_helena_identity_control_offer_seen = true`
- `choice_helena_limited_pilot = true`

**Relações**
- Helena respeita a disposição para negociar em vez de rejeitar escala por princípio.
- Maya vê uma ponte possível para crescimento formal.
- Joana, se presente, cobra prova futura de que “limite” não será apenas linguagem de apresentação.

**Sinais**
- `signal_cash_up`
- `signal_reputation_up`
- `signal_autonomy_down`

### B. Condicionar qualquer uso ampliado a atribuição compartilhada da memória

O jogador trata a identidade cultural como algo que não pode ser narrado apenas por uma empresa.

**Flags**
- `lore_helena_identity_control_offer_seen = true`
- `choice_helena_shared_attribution = true`

**Relações**
- Helena considera o modelo menos eficiente, mas potencialmente mais durável.
- Joana valoriza a exigência de reciprocidade.
- Maya alerta que múltiplos centros de decisão podem reduzir velocidade.

**Sinais**
- `signal_community_up`
- `signal_legitimacy_up`
- `signal_scale_down`

### C. Recusar exclusividade e manter o nome sem definição proprietária

O jogador preserva autonomia, aceitando perder parte do atalho de escala.

**Flags**
- `lore_helena_identity_control_offer_seen = true`
- `choice_helena_reject_exclusivity = true`

**Relações**
- Helena considera a escolha economicamente cara, não infantil.
- Nando pode reagir positivamente em callbacks futuros.
- Maya pode questionar se autonomia sem infraestrutura será sustentável.

**Sinais**
- `signal_autonomy_up`
- `signal_cash_down`
- `signal_reputation_neutral`

## Invariantes

- Helena não reivindica prova histórica que não existe;
- o Consórcio continua sendo ator racional, não antagonista secreto;
- aceitar capital não define o jogador como “corrupto”;
- rejeitar capital não define o jogador como “puro”;
- direitos e contratos permanecem ficcionais e abstratos, sem pretensão de aconselhamento jurídico real;
- o formato final de DA LATA continua reservado ao Ato V.

---

# 4. Sem Dono, Sem Escala

**ID:** `event_nando_sem_dono_sem_escala`  
**Janela:** meio/final do Ato III, com o Mercado da Madrugada plenamente disponível.  
**Estado-base:** CÂNONE sobre a autonomia de Nando e a natureza descentralizada da Rede Paralela.

## Pré-condições

- Nando conhecido;
- `arc_dois_mercados` ativo;
- jogador mantém acesso narrativo à Rede Paralela independentemente de escolhas formais anteriores;
- o evento não pode criar liderança central, sede, rota ou estrutura operacional da Rede Paralela.

## Participantes

- Nando;
- jogador;
- Rui como participante opcional em variante cultural.

## Batida dramática

Nando chega irritado com uma proposta feita por gente que quer transformar relações dispersas do Mercado da Madrugada em uma única identidade comercial.

A proposta promete previsibilidade e volume.

Para Nando, o preço real é outro: se toda relação passar a responder a um único nome, a rede deixa de ser rede e começa a ter dono.

Ele não pede ao jogador ajuda para esconder nada.

Ele pergunta algo mais difícil para a campanha: **autonomia ainda é autonomia quando depende de escala suficiente para sobreviver?**

## Escolhas

### A. Manter relações independentes mesmo com menor previsibilidade

O jogador privilegia fragmentação e autonomia sobre escala coordenada.

**Flags**
- `lore_nando_scale_autonomy_conflict_seen = true`
- `choice_nando_keep_fragmented = true`

**Relações**
- Nando ganha confiança.
- Maya, em callback futuro, pode considerar a opção pouco previsível para integração com o mercado formal.

**Sinais**
- `signal_autonomy_up`
- `signal_risk_up`
- `signal_scale_down`

### B. Apoiar uma identidade temporária sem autoridade central

O jogador aceita coordenação de curto prazo, desde que ninguém seja apresentado como dono da Rede Paralela.

**Flags**
- `lore_nando_scale_autonomy_conflict_seen = true`
- `choice_nando_temporary_umbrella = true`

**Relações**
- Nando aceita experimentar, desconfiado de qualquer estrutura que sobreviva ao próprio objetivo.
- Rui considera interessante uma “marca que não quer virar instituição”.

**Sinais**
- `signal_scale_up`
- `signal_autonomy_neutral`
- `signal_risk_up`

### C. Reduzir dependência desse circuito conforme a empresa cresce

O jogador preserva a relação pessoal com Nando, mas decide que escala não precisa significar aprofundar toda rota econômica disponível.

**Flags**
- `lore_nando_scale_autonomy_conflict_seen = true`
- `choice_nando_reduce_dependency = true`

**Relações**
- Nando respeita a clareza, mas lembra que instituições formais também criam dependências.
- Maya pode reagir favoravelmente à maior previsibilidade formal sem transformar Nando em inimigo.

**Sinais**
- `signal_risk_down`
- `signal_formal_stability_up`
- `signal_autonomy_neutral`

## Invariantes

- a Rede Paralela permanece descentralizada;
- nenhuma escolha descreve rotas, ocultação, sourcing, logística ou evasão;
- Nando nunca fornece instrução operacional ilícita;
- o jogador não “elimina” um mercado por escolher outro;
- a tensão é dependência econômica versus autonomia, não legalidade como moralidade.

---

# 5. Prateleira Sem Improviso

**ID:** `event_maya_prateleira_sem_improviso`  
**Janela:** meio/final do Ato III, após a Casa Clara oferecer expansão de presença formal.  
**Estado-base:** CÂNONE sobre a contradição da Casa Clara entre acesso e padronização.

## Pré-condições

- Maya conhecida;
- crescimento formal suficiente para uma negociação de escala;
- nenhuma escolha anterior precisa ter removido acesso à Casa Clara;
- Joana pode aparecer em variante se a relação comunitária estiver desenvolvida.

## Participantes

- Maya;
- jogador;
- Joana opcional.

## Batida dramática

A Casa Clara oferece uma expansão real de prateleira, mas a escala exige consistência de apresentação, calendário comercial e narrativa de marca.

Maya não pede perfeição por capricho: uma rede maior precisa prometer coisas que uma loja pequena consegue resolver caso a caso.

O problema surge quando a equipe de comunicação sugere simplificar a história do jogador até ela caber numa campanha sem atrito.

O Morro do Cedro vira “origem autêntica”.

O improviso vira “espírito empreendedor”.

As ambiguidades desaparecem.

Maya sabe que isso funciona.

Ela também sabe por que isso a incomoda.

## Escolhas

### A. Padronizar apenas o que é comercial e preservar a história em arquivo separado

O jogador aceita consistência operacional sem transformar a narrativa em uma versão limpa demais de si mesma.

**Flags**
- `lore_maya_scale_consistency_conflict_seen = true`
- `choice_maya_standardize_commercial_only = true`

**Relações**
- Maya considera a divisão praticável.
- Joana, se presente, cobra que “arquivo separado” não vire lugar onde contexto é escondido.

**Sinais**
- `signal_reputation_up`
- `signal_formal_stability_up`
- `signal_memory_neutral`

### B. Tornar a origem no Cedro parte explícita da expansão

O jogador aceita que crescer também amplifica a obrigação de representar de onde veio.

**Flags**
- `lore_maya_scale_consistency_conflict_seen = true`
- `choice_maya_keep_cedro_visible = true`

**Relações**
- Joana valoriza a visibilidade, mas rejeita estetização sem reciprocidade.
- Maya aceita desde que a história possa conviver com compromissos de consistência.

**Sinais**
- `signal_community_up`
- `signal_reputation_up`
- `signal_complexity_up`

### C. Reduzir o tamanho da expansão para manter flexibilidade

O jogador abre mão de parte da escala imediata para não converter toda a operação em promessa padronizada.

**Flags**
- `lore_maya_scale_consistency_conflict_seen = true`
- `choice_maya_smaller_expansion = true`

**Relações**
- Maya considera a escolha coerente, embora comercialmente limitada.
- Helena pode interpretar a decisão como oportunidade perdida em callback futuro.

**Sinais**
- `signal_scale_down`
- `signal_autonomy_up`
- `signal_reputation_neutral`

## Invariantes

- Maya não vira porta-voz automático da “rota correta”;
- consistência formal não é tratada como mal em si;
- origem comunitária não pode ser usada como decoração sem possibilidade de contestação narrativa;
- o evento não exige detalhamento real de produção ou compliance;
- decisões de escala alteram relações e identidade, não autenticidade histórica.

---

# 6. A Regra que Mudou sem Mudar

**ID:** `event_caio_regra_que_mudou`  
**Janela:** final do Ato III, próximo ao convite para o Conselho Cívico da Baía.  
**Estado-base:** CÂNONE sobre a AVM operar com normas sobrepostas e Caio tentar construir estabilidade.

## Pré-condições

- Caio conhecido;
- jogador com operação suficientemente grande para sentir custo sistêmico de interpretações regulatórias;
- nenhuma versão do evento pode usar político real, partido real ou órgão real;
- Influence pode alterar acesso ao processo, nunca “controle” de pessoas.

## Participantes

- Caio;
- jogador;
- Maya, Helena ou Joana como variante contextual opcional.

## Batida dramática

A AVM publica uma orientação que, no papel, “apenas esclarece” uma regra existente.

Na prática, o esclarecimento muda custos, prazos e interpretação de obrigações para operadores de tamanhos diferentes.

Caio está frustrado porque as duas leituras anteriores eram defensáveis.

Ele não pede obediência cega nem rebelião.

Ele explica que instituições tentam produzir previsibilidade usando textos criados em momentos diferentes — e que corrigir uma inconsistência pode criar outra.

O jogador precisa decidir como responder a uma mudança que oficialmente não é chamada de mudança.

## Escolhas

### A. Adaptar cedo e absorver o custo

O jogador privilegia previsibilidade, mesmo sem saber se a nova leitura permanecerá estável.

**Flags**
- `lore_caio_rule_adaptation_conflict_seen = true`
- `choice_caio_adapt_early = true`

**Relações**
- Caio vê responsabilidade sistêmica.
- Helena pode considerar a resposta compatível com escala.
- Joana pode questionar quem consegue pagar pelo mesmo nível de cautela.

**Sinais**
- `signal_heat_down`
- `signal_cash_down`
- `signal_legitimacy_up`

### B. Usar a janela de transição permitida

O jogador preserva caixa e flexibilidade, aceitando incerteza temporária.

**Flags**
- `lore_caio_rule_adaptation_conflict_seen = true`
- `choice_caio_use_transition = true`

**Relações**
- Caio considera a decisão válida dentro do próprio sistema.
- Maya se preocupa com consistência entre fornecedores em momentos diferentes.

**Sinais**
- `signal_cash_neutral`
- `signal_risk_up`
- `signal_adaptation_up`

### C. Levar a contradição ao processo público de esclarecimento

O jogador usa acesso institucional para pedir uma interpretação mais clara e visível para todos os operadores.

**Flags**
- `lore_caio_rule_adaptation_conflict_seen = true`
- `choice_caio_public_clarification = true`

**Relações**
- Caio valoriza transformar conflito privado em regra legível.
- Helena vê custo de tempo.
- Joana pode considerar positivo reduzir vantagem de quem possui melhor acesso informal à interpretação.

**Sinais**
- `signal_influence_up`
- `signal_legitimacy_up`
- `signal_delay_up`

## Invariantes

- nenhuma opção envolve suborno, pressão pessoal ou persuasão política direcionada;
- o processo é institucional, ficcional e sistêmico;
- Caio não é “o governo” e não controla sozinho o resultado;
- Influence mede acesso e participação, não domínio;
- nenhuma escolha é apresentada como moralmente superior.

---

# Ordem sugerida da wave

A ordem dramática recomendada é:

```text
Ato III início
  -> event_bento_fita_farol
  -> event_falso_original

Ato III meio
  -> event_maya_prateleira_sem_improviso
  -> event_nando_sem_dono_sem_escala
  -> event_helena_nome_em_contrato

Ato III final
  -> event_caio_regra_que_mudou
  -> convite ao Conselho Cívico da Baía
```

A ordem pode variar conforme estado do jogador.

A Fita do Farol deve acontecer antes de qualquer conteúdo que trate as quatro marcas como fenômeno público consolidado.

O convite ao Conselho não deve depender de uma “resposta correta” em nenhum desses eventos. Ele deve refletir **escala + presença institucional suficiente + progressão de campanha**.

---

# Flags canônicas da wave

Flags de observação/estado narrativo:

```text
lore_farol_tape_four_marks_heard
lore_farol_tape_date_unverified
lore_false_original_claim_seen
lore_original_lineage_still_unproven
lore_helena_identity_control_offer_seen
lore_nando_scale_autonomy_conflict_seen
lore_maya_scale_consistency_conflict_seen
lore_caio_rule_adaptation_conflict_seen
```

Flags `choice_*` registram postura e consequência do jogador.

Elas **nunca** devem ser reinterpretadas como prova sobre:
- data da Fita do Farol;
- identidade da voz;
- autenticidade de um “original”;
- autoria do Caderno;
- ordem das quatro marcas;
- existência de uma linhagem histórica intacta.

---

# Callbacks recomendados

Eventos do Ato III devem responder, quando disponível, a escolhas do Ato II sem bloquear conteúdo central.

Exemplos:

- `choice_four_marks_publish_dispute` pode mudar a reação de Rui à publicação da Fita do Farol;
- `choice_nando_catalog_unverified` pode fazer Nando cobrar coerência quando o jogador avalia o falso “original”;
- `choice_rui_cedro_context_first` pode alterar a forma como Joana reage à campanha de expansão da Casa Clara;
- `choice_maya_joana_joint_pilot` pode abrir uma linha de diálogo extra sobre escala com reciprocidade;
- `choice_non_interview_leave_open` pode reforçar a ideia de que nem toda lacuna precisa ser convertida em conteúdo.

Callbacks alteram **tom, confiança e memória relacional**.

Eles não reescrevem fatos históricos.

---

# Dependência futura de implementação

Esta wave é narrativa-only.

Quando uma wave técnica materializar estes eventos, deve reutilizar o contrato já introduzido para eventos narrativos, mantendo:

```text
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
```

Requisitos de integração futura:

1. eventos centrais do Ato III não podem ser removidos por ter escolhido exclusivamente formal ou paralelo no Ato I/II;
2. variantes podem depender de flags de relação;
3. `choice_*` nunca pode virar prova histórica;
4. a disponibilidade da Fita do Farol deve exigir progressão narrativa, não uma rota econômica específica;
5. o convite ao Conselho deve ser consequência de progressão do ato, não recompensa moral;
6. nenhuma implementação deve hardcodar texto narrativo na UI se puder usar conteúdo localizado/data-driven;
7. save migration só pertence a uma wave técnica quando essas flags forem realmente persistidas.

---

# Continuidade preservada

## CÂNONE preservado

- Fita do Farol existe e contém referência às quatro marcas.
- A data da fita não está provada.
- Consórcio Atlântico busca escala e controle comercial de identidade.
- Nando valoriza autonomia.
- Maya valoriza consistência sem querer expulsar pequenos operadores.
- Caio representa estabilidade institucional e adaptação.
- Ato III termina com escala suficiente para a transição ao Conselho Cívico da Baía.

## RUMOR preservado

- a fita pode ser mais antiga do que a circulação pública conhecida do Caderno;
- itens “originais” podem carregar histórias parcialmente verdadeiras;
- circulação pública pode revelar novas fontes sem autenticá-las.

## ABERTO preservado

- identidade da voz da fita;
- data exata da gravação;
- relação entre fita e Caderno;
- ordem/origem das quatro marcas;
- autoria/composição do Caderno de Sal;
- procedência da lata da Onda;
- qualquer camada sobrenatural;
- forma final de DA LATA no Ato V.

---

# Critério de aceite narrativo

A wave está pronta quando:

1. os seis eventos cabem no Ato III sem retcon;
2. nenhum evento exige uma rota econômica única;
3. toda escolha possui trade-off narrativo legível;
4. nenhuma escolha resolve um estado `RUMOR` ou `ABERTO` protegido;
5. os eventos conectam dinheiro, memória, identidade, risco, legitimidade e institucionalização;
6. mercado paralelo permanece abstrato e não-operacional;
7. política/instituições permanecem ficcionais e sistêmicas;
8. a Fita do Farol expande o mistério sem virar prova definitiva;
9. o falso “original” reforça que mercado também fabrica memória;
10. a biblioteca oferece IDs e flags estáveis para futura materialização.
