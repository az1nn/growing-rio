# DA LATA — Biblioteca de Eventos Narrativos — Ato II

Este documento materializa os seis ganchos relacionais do **Ato II** reservados em `CHARACTER-RELATIONSHIPS.md` como especificações narrativas prontas para futura implementação em Resources/event data.

Os beats centrais do Ato I vivem em `ACT-I-NARRATIVE-EVENT-LIBRARY.md`.

## Escopo desta wave

- preservar o cânone pré-`T0`;
- transformar tensões relacionais em escolhas do jogador;
- manter `CÂNONE`, `RUMOR` e `ABERTO` explícitos;
- evitar qualquer resolução prematura do Caderno de Sal, das quatro marcas ou da Mulher da Lata;
- expressar consequências sistêmicas apenas de forma abstrata;
- não introduzir instruções operacionais de cultivo, mercado paralelo ou persuasão política.

## Contrato de evento

Cada evento abaixo define:

- **ID estável**;
- **janela narrativa**;
- **pré-condições**;
- **participantes**;
- **batida dramática**;
- **escolhas do jogador**;
- **flags de lore**;
- **efeitos relacionais**;
- **sinais sistêmicos abstratos**;
- **invariantes de continuidade**.

### Convenção de sinais sistêmicos

Os sinais abaixo são semânticos. Valores numéricos pertencem ao design mecânico futuro.

- `signal_reputation_up|down`
- `signal_research_up|down`
- `signal_community_up|down`
- `signal_legitimacy_up|down`
- `signal_risk_up|down`
- `signal_memory_up|down`

Eles não devem ser interpretados como balanceamento já decidido.

---

# 1. O primeiro depoimento

**ID:** `event_dalva_lucia_primeiro_depoimento`  
**Janela:** início do Ato II, após o jogador receber a lata marcada com Onda e conhecer Lúcia.  
**Estado-base:** CÂNONE sobre a existência do depoimento; ABERTO sobre qual símbolo Dalva mencionou primeiro.

## Pré-condições

- `arc_o_quarto` concluído;
- jogador possui contato com `char_dalva`;
- `char_lucia` introduzida;
- lata da Onda já recebida;
- nenhuma flag posterior autenticando a ordem histórica das marcas.

## Participantes

- Dalva;
- Lúcia;
- jogador.

## Batida dramática

Lúcia mostra ao jogador duas notas de arquivo produzidas a partir de uma conversa anterior com Dalva.

Em uma versão, o primeiro símbolo citado parece ser **Onda**. Em outra anotação marginal, a lembrança de Dalva sugere que ela pode ter falado de **Estrela** antes.

Dalva não trata a diferença como mistério épico. Para ela, o problema é mais simples: transformar lembrança em sequência rígida pode destruir justamente o que a lembrança contém.

Lúcia insiste em registrar a divergência porque omiti-la seria fabricar precisão.

## Escolhas

### A. Registrar as duas versões lado a lado

O jogador apoia a preservação explícita da contradição.

**Flags**
- `lore_dalva_lucia_symbol_order_disputed = true`
- `choice_dalva_lucia_parallel_versions = true`

**Relações**
- Dalva aprecia não ser pressionada a escolher uma memória conveniente.
- Lúcia aprecia a disciplina documental.

**Sinais**
- `signal_research_up`
- `signal_memory_up`

### B. Priorizar o depoimento oral mais recente

O jogador propõe que a versão atual de Dalva tenha precedência como testemunho vivo, sem chamá-la de prova histórica.

**Flags**
- `lore_dalva_lucia_symbol_order_disputed = true`
- `choice_dalva_lucia_living_memory = true`

**Relações**
- Dalva percebe respeito pela memória viva.
- Lúcia aceita a escolha apenas se a divergência permanecer anotada.

**Sinais**
- `signal_community_up`
- `signal_memory_up`
- `signal_research_down`

### C. Congelar a interpretação

O jogador recomenda que nenhum dos dois registros receba prioridade até aparecer nova evidência independente.

**Flags**
- `lore_dalva_lucia_symbol_order_disputed = true`
- `choice_dalva_lucia_hold_judgment = true`

**Relações**
- Lúcia aprova a cautela.
- Dalva considera a postura correta, porém excessivamente institucional.

**Sinais**
- `signal_research_up`
- `signal_reputation_neutral`

## Invariantes

- nenhuma opção determina a ordem histórica das quatro marcas;
- nenhuma opção autentica a lata do jogador;
- Dalva continua sem afirmar possuir uma lata original;
- Lúcia continua tratando memória oral como pista, não prova.

---

# 2. A porta estreita

**ID:** `event_maya_joana_porta_estreita`  
**Janela:** Ato II, durante a expansão do jogador para contratos mais estruturados.  
**Estado-base:** CÂNONE sobre a reunião em `T-2`; ABERTO apenas sobre qual das duas quase encerrou a conversa.

## Pré-condições

- Maya e Joana já conhecidas;
- jogador elegível para um contrato formal de pequena escala;
- sistema de Community disponível;
- nenhuma escolha anterior bloqueia Casa Clara ou Raiz do Cedro permanentemente.

## Participantes

- Maya;
- Joana;
- jogador.

## Batida dramática

Maya convida Joana para revisar uma nova versão do programa de pequenos fornecedores. O documento é melhor do que a versão de `T-2`, mas mantém custos de adaptação que Joana considera assimétricos.

A discussão recupera a antiga expressão **“porta estreita”**.

Maya afirma que padrões protegem fornecedores pequenos de promessas vagas e compradores oportunistas.

Joana responde que um padrão que só pode ser cumprido por quem já tem capital não abre porta nenhuma.

O jogador é convidado a defender uma forma de avançar, não a escolher quem “está certa”.

## Escolhas

### A. Manter o padrão e tornar os custos explícitos

O jogador apoia requisitos estáveis, exigindo transparência total sobre custo e prazo de adaptação.

**Flags**
- `lore_maya_joana_supplier_history_seen = true`
- `choice_porta_estreita_explicit_standard = true`

**Relações**
- Maya vê consistência.
- Joana aceita a honestidade, mas mantém a crítica de capacidade.

**Sinais**
- `signal_legitimacy_up`
- `signal_community_down`

### B. Criar uma trilha de capacidade antes do contrato

O jogador propõe que operadores menores possam demonstrar progresso em etapas antes de cumprir o pacote completo.

**Flags**
- `lore_maya_joana_supplier_history_seen = true`
- `choice_porta_estreita_capacity_path = true`

**Relações**
- Joana percebe reciprocidade concreta.
- Maya teme que flexibilidade excessiva torne o programa inconsistente.

**Sinais**
- `signal_community_up`
- `signal_legitimacy_up`
- `signal_risk_up`

### C. Separar o piloto do programa principal

O jogador recomenda um piloto pequeno, temporário e explicitamente experimental.

**Flags**
- `lore_maya_joana_supplier_history_seen = true`
- `choice_porta_estreita_pilot = true`

**Relações**
- Maya aprecia o limite de risco.
- Joana aceita desde que o piloto não vire vitrine sem continuidade.

**Sinais**
- `signal_reputation_up`
- `signal_community_up`
- `signal_risk_neutral`

## Invariantes

- a Casa Clara não vira “facção correta”;
- a Raiz do Cedro não recebe poder de veto sobre o mercado;
- a tensão acesso × reciprocidade permanece ativa;
- o evento não define números, subsídios, regras reais ou desenho regulatório aplicável fora do jogo.

---

# 3. Contexto não é controle

**ID:** `event_rui_cedro_contexto`  
**Janela:** Ato II, após Rui publicar uma história que cita o Morro do Cedro.  
**Estado-base:** CÂNONE sobre a tensão editorial entre Rui e Joana.

## Pré-condições

- Rui e Joana conhecidos;
- jogador possui Community ou Reputation suficiente para ser tratado como fonte relevante;
- nenhuma flag estabelecendo Rui como porta-voz do Cedro;
- nenhuma flag estabelecendo Joana como autoridade editorial sobre Rui.

## Participantes

- Rui;
- Joana;
- jogador.

## Batida dramática

Uma nova edição de **Maré de Fundo** usa o Cedro como símbolo da transformação econômica da cidade.

Joana considera a história tecnicamente correta e narrativamente incompleta: fala do bairro como cenário, mas quase não mostra quem faz o trabalho cotidiano.

Rui responde que contexto não pode significar autorização prévia.

Os dois pedem ao jogador algo diferente:

- Joana quer que certas ausências sejam registradas;
- Rui quer preservar independência editorial.

## Escolhas

### A. Entregar contexto adicional sem pedir revisão prévia

O jogador fornece informações e nomes ficcionais de iniciativas comunitárias, deixando a decisão editorial com Rui.

**Flags**
- `lore_rui_cedro_context_challenged = true`
- `choice_rui_cedro_context_without_veto = true`

**Relações**
- Rui preserva autonomia.
- Joana reconhece esforço, mas não confunde inclusão com correção estrutural.

**Sinais**
- `signal_reputation_up`
- `signal_community_up`

### B. Pedir uma nota pública sobre as limitações da história

O jogador não pede reescrita; pede que Rui assuma explicitamente o enquadramento parcial.

**Flags**
- `lore_rui_cedro_context_challenged = true`
- `choice_rui_cedro_editorial_note = true`

**Relações**
- Joana valoriza a transparência.
- Rui aceita, mas considera que o jogador está aprendendo rápido a administrar narrativa.

**Sinais**
- `signal_memory_up`
- `signal_reputation_up`

### C. Recusar intermediação

O jogador afirma que a relação entre Joana e Rui já existia antes dele e deve continuar sendo negociada entre os dois.

**Flags**
- `lore_rui_cedro_context_challenged = true`
- `choice_rui_cedro_decline_mediation = true`

**Relações**
- Joana pode considerar a recusa coerente ou conveniente conforme histórico posterior.
- Rui respeita a ausência de tentativa de controle.

**Sinais**
- `signal_legitimacy_neutral`
- `signal_community_neutral`

## Invariantes

- Joana não controla o conteúdo de Rui;
- Rui não é tratado como narrador neutro absoluto;
- o Cedro continua território vivo, não estética;
- nenhuma opção transforma cobertura midiática em fato histórico autenticado.

---

# 4. Procedência insuficiente

**ID:** `event_nando_procedencia_insuficiente`  
**Janela:** Ato II, depois que Research está disponível.  
**Estado-base:** CÂNONE sobre a postura de Lúcia; RUMOR sobre Nando ter visto uma página do Caderno antes de `T0`.

## Pré-condições

- Nando e Lúcia conhecidos;
- Research disponível;
- jogador já ouviu pelo menos um rumor relacionado ao Caderno;
- `lore_nando_saw_caderno_page` não pode existir como flag canônica verdadeira.

## Participantes

- Nando;
- Lúcia;
- jogador.

## Batida dramática

Nando apresenta uma fotografia de um fragmento de papel que ele diz ter visto “antes de todo mundo começar a falar disso”.

Ele não fornece cadeia documental suficiente.

Lúcia reconhece detalhes plausíveis, mas se recusa a chamar a imagem de prova de procedência.

Nando não exige autenticação. Ele exige que a informação não seja descartada só porque chegou pela via errada.

## Escolhas

### A. Catalogar como pista não verificada

A imagem entra no arquivo como material de origem incerta.

**Flags**
- `lore_nando_provenance_rejected = true`
- `rumor_nando_saw_caderno_page_preserved = true`
- `choice_nando_catalog_unverified = true`

**Relações**
- Lúcia aceita o procedimento.
- Nando considera que a pista foi ouvida sem virar certificado.

**Sinais**
- `signal_research_up`
- `signal_memory_up`

### B. Encaminhar a pista ao Arquivo da Maré como rumor

O jogador escolhe circulação cultural em vez de autenticação científica.

**Flags**
- `lore_nando_provenance_rejected = true`
- `rumor_nando_saw_caderno_page_preserved = true`
- `choice_nando_route_to_archive = true`

**Relações**
- Nando gosta da velocidade.
- Lúcia alerta que visibilidade pode aumentar ruído documental.

**Sinais**
- `signal_reputation_up`
- `signal_risk_up`
- `signal_research_down`

### C. Guardar sem publicar nem autenticar

O jogador preserva a pista, mas evita circulação até surgir evidência independente.

**Flags**
- `lore_nando_provenance_rejected = true`
- `rumor_nando_saw_caderno_page_preserved = true`
- `choice_nando_hold_private = true`

**Relações**
- Lúcia aprova a cautela.
- Nando considera que instituições sempre querem tempo que pessoas reais nem sempre têm.

**Sinais**
- `signal_risk_down`
- `signal_research_neutral`

## Invariantes

- Nando nunca confirma ter visto uma página autêntica;
- Lúcia nunca autentica por reputação pessoal;
- nenhuma opção cria cadeia de procedência completa;
- nenhum conteúdo da suposta página inclui parâmetros reais de cultivo.

---

# 5. Quem viu primeiro

**ID:** `event_rui_lucia_quatro_marcas`  
**Janela:** final do Ato II ou ponte para Ato III.  
**Estado-base:** ABERTO sobre quem percebeu primeiro a recorrência das quatro marcas.

## Pré-condições

- Rui e Lúcia conhecidos;
- jogador encontrou referências a pelo menos duas marcas;
- evento não pode revelar a origem conjunta das quatro marcas;
- a Fita do Farol ainda não deve ter resolvido qualquer cronologia.

## Participantes

- Rui;
- Lúcia;
- jogador.

## Batida dramática

Rui encontra uma gravação antiga de seu próprio programa onde afirma ter mostrado a Lúcia um padrão recorrente.

Lúcia apresenta uma anotação de arquivo com data semelhante e afirma que já acompanhava a recorrência antes daquela conversa.

As duas peças são reais dentro do arquivo, mas não resolvem prioridade com segurança.

A discussão não é só ego: para Rui, descoberta pública faz fontes aparecerem. Para Lúcia, crédito sem método cria falsas cronologias.

## Escolhas

### A. Registrar descoberta simultânea e independente

O jogador aceita que ambos chegaram ao padrão por caminhos diferentes.

**Flags**
- `lore_four_marks_priority_disputed = true`
- `choice_four_marks_parallel_discovery = true`

**Relações**
- Rui considera a solução menos dramática e mais justa.
- Lúcia aceita por não fabricar uma prioridade.

**Sinais**
- `signal_research_up`
- `signal_reputation_up`

### B. Publicar a disputa como parte da própria história

O jogador apoia Rui em tornar a divergência pública, sem escolher vencedor.

**Flags**
- `lore_four_marks_priority_disputed = true`
- `choice_four_marks_publish_dispute = true`

**Relações**
- Rui ganha energia narrativa.
- Lúcia aceita desde que a incerteza apareça no mesmo destaque.

**Sinais**
- `signal_reputation_up`
- `signal_memory_up`
- `signal_risk_up`

### C. Tratar prioridade como irrelevante para a pesquisa

O jogador enfatiza que o importante é rastrear ocorrências independentes das marcas.

**Flags**
- `lore_four_marks_priority_disputed = true`
- `choice_four_marks_decenter_credit = true`

**Relações**
- Lúcia concorda com o método.
- Rui lembra que crédito também é parte da memória.

**Sinais**
- `signal_research_up`
- `signal_memory_neutral`

## Invariantes

- o evento nunca define quem percebeu primeiro;
- o evento nunca define quando as quatro marcas surgiram;
- o evento não autentica o Caderno;
- a relação evidência × narrativa continua produtiva e conflituosa.

---

# 6. A entrevista que não foi

**ID:** `event_dalva_rui_entrevista_que_nao_foi`  
**Janela:** Ato II, depois que o jogador já conhece Rui e a importância cultural de Dalva.  
**Estado-base:** CÂNONE sobre a noite em `T-4`; ABERTO sobre a interpretação exata do que aconteceu.

## Pré-condições

- Dalva e Rui conhecidos;
- jogador já ouviu pelo menos uma versão da “melhor entrevista que nunca aconteceu”;
- nenhuma gravação completa da entrevista pode existir;
- nenhuma opção pode forçar Dalva a revelar procedência da lata da Onda.

## Participantes

- Dalva;
- Rui;
- jogador.

## Batida dramática

O jogador encontra dois vestígios da mesma noite:

- uma anotação de Rui descrevendo uma conversa extraordinária interrompida antes da parte “importante”;
- um bilhete de Dalva descrevendo a mesma noite como conversa comum depois do fechamento.

Rui diz que Dalva sabia exatamente o que estava evitando gravar.

Dalva diz que Rui decidiu que o silêncio precisava significar alguma coisa.

Ambos lembram música, chuva e uma lata velha sobre o balcão.

Nenhum lembra a sequência da mesma forma.

## Escolhas

### A. Arquivar as duas versões sem síntese

O jogador trata a incompatibilidade como parte do valor documental.

**Flags**
- `lore_dalva_rui_non_interview_versions_seen = true`
- `choice_non_interview_dual_archive = true`

**Relações**
- Dalva aprecia não ser transformada em enigma resolvido.
- Rui aprecia que sua versão também não seja descartada.

**Sinais**
- `signal_memory_up`
- `signal_research_up`

### B. Pedir que os dois recontem a noite juntos

O jogador cria uma nova conversa, sem prometer resolução.

**Flags**
- `lore_dalva_rui_non_interview_versions_seen = true`
- `choice_non_interview_joint_retelling = true`

**Relações**
- Rui vê potencial narrativo.
- Dalva aceita apenas se não houver obrigação de gravação.

**Sinais**
- `signal_reputation_up`
- `signal_memory_up`
- `signal_risk_up`

### C. Deixar a história sem nova tentativa

O jogador decide que nem toda lacuna precisa ser reaberta.

**Flags**
- `lore_dalva_rui_non_interview_versions_seen = true`
- `choice_non_interview_leave_open = true`

**Relações**
- Dalva valoriza o limite.
- Rui considera que uma boa história acabou de ganhar outra ausência.

**Sinais**
- `signal_community_up`
- `signal_research_neutral`

## Invariantes

- não existe gravação completa que resolva a noite;
- a lata vista no balcão não recebe procedência nova;
- o silêncio de Dalva continua podendo ser privacidade, estratégia, memória falha ou nada especial;
- Rui continua capaz de preservar memória e amplificar ruído ao mesmo tempo.

---

# Ordem sugerida da wave

A biblioteca pode ser usada sem obrigar uma sequência linear, mas a ordem dramática recomendada é:

```text
Ato II início
  -> event_dalva_lucia_primeiro_depoimento
  -> event_maya_joana_porta_estreita
  -> event_rui_cedro_contexto
  -> event_nando_procedencia_insuficiente
  -> event_dalva_rui_entrevista_que_nao_foi
Ato II final / ponte Ato III
  -> event_rui_lucia_quatro_marcas
```

## Regra de disponibilidade

Nenhum evento deve depender de uma única rota econômica prévia.

Escolhas anteriores podem:

- alterar disponibilidade de falas;
- mudar tom e confiança;
- alterar sinais abstratos;
- abrir variantes;

mas não devem eliminar definitivamente personagens centrais do Ato II.

---

# Flags canônicas da wave

Flags de observação e estado narrativo:

```text
lore_dalva_lucia_symbol_order_disputed
lore_maya_joana_supplier_history_seen
lore_rui_cedro_context_challenged
lore_nando_provenance_rejected
rumor_nando_saw_caderno_page_preserved
lore_four_marks_priority_disputed
lore_dalva_rui_non_interview_versions_seen
```

Flags `choice_*` registram resposta do jogador e nunca devem ser reinterpretadas como prova histórica.

---

# Continuidade preservada

## CÂNONE

- Dalva e Lúcia já tiveram um depoimento anterior a `T0`.
- Maya e Joana já discutiram acesso de pequenos fornecedores em `T-2`.
- Rui e Joana já carregam tensão editorial ligada ao Cedro.
- Lúcia rejeita procedência baseada apenas em confiança pessoal.
- Rui e Lúcia discordam sobre prioridade na percepção das quatro marcas.
- Rui e Dalva lembram de forma diferente a noite da entrevista recusada em `T-4`.

## RUMOR preservado

- Nando pode ter visto uma página do Caderno antes de `T0`.
- circulação de histórias pode revelar novas fontes sem torná-las verdadeiras.

## ABERTO preservado

- ordem inicial dos símbolos;
- quem percebeu primeiro a recorrência das quatro marcas;
- procedência da lata da Onda;
- autoria e composição do Caderno de Sal;
- origem conjunta ou separada das quatro marcas;
- existência de qualquer camada sobrenatural.

---

# Dependência futura de implementação

Esta wave não implementa gameplay.

Quando SIGA ou uma wave técnica materializar estes eventos, a implementação deve preferir uma estrutura UI-independent semelhante a:

```text
NarrativeEvent
- id
- arc_id
- conditions[]
- participants[]
- text_key / dialogue_key
- choices[]
- choice_flags[]
- relationship_effects[]
- system_signals[]
- lore_assertions[]
- canon_guardrails[]
```

O conteúdo narrativo deve permanecer fora de lógica hardcoded de UI sempre que possível.

Mudança de schema de save só é justificável se flags persistentes forem realmente necessárias para campanha.

---

# Critério de aceite narrativo

A wave está pronta para implementação quando:

1. os seis eventos podem ser representados sem retcon;
2. nenhuma escolha resolve um mistério classificado como `RUMOR` ou `ABERTO`;
3. cada evento toca pelo menos dois eixos centrais de DA LATA;
4. todas as consequências mecânicas permanecem abstratas;
5. nenhum evento depende de instrução operacional real;
6. a ordem recomendada cabe dentro do Ato II e sua ponte para o Ato III;
7. IDs e flags são estáveis o suficiente para futura tradução em Resources.
