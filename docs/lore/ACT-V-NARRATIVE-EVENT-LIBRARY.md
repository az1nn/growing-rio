# DA LATA — Ato V Narrative Event Library

Este documento decompõe **Ato V — DA LATA** em contratos narrativos implementation-ready.

A wave é deliberadamente narrative-only. Ela define significado, pré-condições, escolhas, flags, relações, sinais e guardrails; não implementa Resources, UI, save state, balanceamento, seleção de ending ou regras de gameplay.

---

# Objetivo do ato

Ato V encerra a pergunta iniciada pela lata de Dalva:

> se o passado não pode ser recuperado perfeitamente, o que significa reconstruí-lo sem mentir sobre ele?

A resposta canônica não é encontrar uma relíquia intacta.

**DA LATA é uma reconstrução contemporânea.**

Ela pode carregar evidência, memória, legitimidade, mercado, capital e instituição ao mesmo tempo — mas nenhuma dessas forças possui sozinha o direito de declarar que o passado foi recuperado.

## Invariantes do Ato V

- não existe prova de linhagem contínua e intacta desde o verão original;
- a reconstrução final nunca é apresentada como geneticamente “a mesma” cannabis histórica;
- cultivo, seleção e pesquisa permanecem abstratos e não instrucionais;
- cada facção oferece uma capacidade real e cobra um custo real;
- nenhuma facção, forma institucional ou ending é moralmente classificado como correto;
- Onda, Sol, Ferrugem e Estrela podem ser reunidas no presente sem provar ordem histórica, origem comum ou uso conjunto no passado;
- autoria/composição do Caderno de Sal permanece ABERTA;
- data e voz da Fita do Farol permanecem ABERTAS;
- procedência exata da lata de Dalva permanece ABERTA;
- o sobrenatural permanece não confirmado;
- o Conselho Cívico da Baía continua ficcional, sistêmico e não corresponde a órgão real;
- escolhas anteriores mudam confiança, linguagem, acesso e custos narrativos; não reescrevem fatos históricos.

---

# 1. Não Existe Original para Voltar

**ID:** `event_reconstrucao_sem_original`  
**Janela:** abertura do Ato V, após a Estrela e o fechamento de `arc_o_sistema`.  
**Local narrativo:** Instituto Aurora, com materiais de Onda, Sol, Ferrugem e Estrela reunidos para revisão.  
**Estado-base:** CÂNONE sobre a ausência de prova de linhagem contínua.

## Pré-condições

- `arc_o_sistema` concluído;
- `event_foto_estrela` concluído;
- três documentos, uma fita e um objeto já classificados como materialmente compatíveis no nível definido pelo Ato IV;
- nenhuma escolha pode promover compatibilidade material a prova de identidade botânica contínua.

## Participantes

- Dra. Lúcia Vilar;
- jogador;
- Rui Sal;
- Dona Dalva como presença opcional, presencial ou por mensagem/objeto.

## Batida dramática

Lúcia encerra a etapa mais longa da pesquisa com uma conclusão menos vendável do que qualquer participante gostaria:

há material suficiente para sustentar que partes da história circularam juntas, foram copiadas, preservadas, recontadas e materialmente conectadas.

Não há material suficiente para declarar que existe uma linhagem botânica intacta esperando ser “recuperada”.

Rui pergunta se isso mata a lenda.

Lúcia responde que só mata a mentira mais conveniente.

O jogador recebe a formulação que orientará todo o ato:

> **reconstruir não é fingir continuidade; é declarar as lacunas e ainda assim escolher o que fazer com elas.**

## Escolhas

### A. Tornar a incerteza parte pública do projeto

O jogador assume desde o início que DA LATA será apresentada como reconstrução contemporânea.

**Flags**
- lore_act_v_reconstruction_framed = true
- choice_reconstruction_public_uncertainty = true

**Relações**
- Lúcia ganha confiança na integridade do enquadramento.
- Rui vê potencial cultural em publicar as contradições.
- Helena considera a linguagem menos simples para mercado de massa.

**Sinais**
- signal_research_up
- signal_legitimacy_up
- signal_marketing_friction_up

### B. Separar comunicação pública e dossiê técnico sem esconder a conclusão

O jogador aceita uma narrativa pública mais curta, desde que o registro completo permaneça acessível e não reivindique autenticidade inexistente.

**Flags**
- lore_act_v_reconstruction_framed = true
- choice_reconstruction_layered_disclosure = true

**Relações**
- Maya considera o formato mais legível para varejo.
- Lúcia exige que o resumo nunca contradiga o dossiê.
- Rui teme que a versão curta vire a única lembrada.

**Sinais**
- signal_market_access_up
- signal_research_preserved
- signal_memory_tension_up

### C. Manter a reconstrução primeiro como projeto fechado de pesquisa

O jogador posterga a linguagem pública de marca até que a coalizão de contribuições esteja definida.

**Flags**
- lore_act_v_reconstruction_framed = true
- choice_reconstruction_research_first = true

**Relações**
- Lúcia vê prudência metodológica.
- Joana pergunta quem terá acesso durante a espera.
- Helena vê perda de janela econômica.

**Sinais**
- signal_research_up
- signal_scale_delay_up
- signal_governance_pressure_up

## Callbacks

- `choice_ferrugem_shared_custody` permite citar explicitamente que nenhum custodiante sozinho encerra a interpretação do acervo.
- `choice_ferrugem_aurora_custody` aumenta a responsabilidade de Lúcia em explicar limites de evidência.
- decisões anteriores sobre publicidade, procedência e autoria compartilhada alteram quem questiona primeiro a formulação de “reconstrução”.

## Invariantes

- a cena não revela “a genética original”;
- compatibilidade material não equivale a linhagem;
- a palavra reconstrução não é punição narrativa;
- nenhuma escolha pode converter RUMOR/ABERTO em prova apenas por Reputation, Cash ou Influence.

---

# 2. Sete Partes da Cidade

**ID:** `event_sete_partes_da_cidade`  
**Janela:** primeiro terço do Ato V, depois do enquadramento da reconstrução.  
**Local narrativo:** sequência de revisitas aos distritos já conhecidos.  
**Estado-base:** CÂNONE sobre as capacidades e contradições das sete forças do Ato V.

## Pré-condições

- `lore_act_v_reconstruction_framed = true`;
- relações anteriores continuam disponíveis como contexto;
- nenhuma facção pode fornecer sozinha “a DA LATA completa”.

## Participantes e contribuições

- **Instituto Aurora / Lúcia:** evidência, classificação e limites do que pode ser afirmado;
- **Arquivo da Maré / Rui:** memória, contradições, objetos e contexto cultural;
- **Raiz do Cedro / Joana:** legitimidade comunitária, reciprocidade e origem social do valor;
- **Casa Clara / Maya:** acesso ao mercado formal e legibilidade para público consumidor;
- **Consórcio Atlântico / Helena:** capital, escala e infraestrutura;
- **Rede Paralela / Nando:** histórias, circulação cultural e materiais fora de arquivo, sempre de forma abstrata;
- **Conselho Cívico da Baía / Isa:** enquadramento institucional e registro de trade-offs.

## Batida dramática

O jogador revisita a cidade não para coletar sete “chaves”, mas para descobrir que cada contribuição muda o próprio significado do projeto.

Aurora pode tornar uma afirmação defensável e ao mesmo tempo estreitar o que pode ser dito.

Arquivo da Maré pode ampliar memória e ao mesmo tempo tornar autoria mais difusa.

Raiz do Cedro pode dar reciprocidade social e ao mesmo tempo exigir governança compartilhada.

Casa Clara pode dar alcance e ao mesmo tempo exigir padronização.

Atlântico pode dar escala e ao mesmo tempo pedir controle.

Rede Paralela pode preservar circulação cultural e ao mesmo tempo manter volatilidade e risco.

O Conselho pode dar legibilidade institucional e ao mesmo tempo transformar escolhas em registro público.

A tensão não é “quem entra”.

É:

> **como aceitar contribuição sem fingir que contribuição não cria dependência?**

## Escolhas

### A. Registrar cada contribuição com custo e autoria visíveis

O jogador cria uma matriz narrativa de contribuição: ninguém entra como patrocinador neutro.

**Flags**
- lore_act_v_city_contributions_mapped = true
- choice_city_contributions_attributed = true

**Relações**
- Isa reconhece consistência com o processo do Ato IV.
- Joana e Rui valorizam autoria explícita.
- Helena considera o arranjo mais difícil de simplificar como marca única.

**Sinais**
- signal_legitimacy_up
- signal_memory_up
- signal_governance_complexity_up

### B. Construir uma coordenação central com acordos diferentes por facção

O jogador assume que a reconstrução terá um centro decisório, mas mantém custos e limites específicos documentados.

**Flags**
- lore_act_v_city_contributions_mapped = true
- choice_city_contributions_central_coordination = true

**Relações**
- Maya e Helena veem maior capacidade de execução.
- Joana cobra mecanismos contra captura.
- Rui teme que versões incompatíveis sejam editadas para caber no centro.

**Sinais**
- signal_scale_up
- signal_execution_up
- signal_autonomy_pressure_up

### C. Manter uma coalizão distribuída até a decisão de forma final

O jogador adia a centralização e aceita que diferentes partes do projeto permaneçam sob custódias distintas.

**Flags**
- lore_act_v_city_contributions_mapped = true
- choice_city_contributions_distributed = true

**Relações**
- Joana e Rui veem proteção contra apropriação única.
- Lúcia exige regras para integridade de evidência.
- Maya e Helena apontam custos de coordenação.

**Sinais**
- signal_community_up
- signal_memory_up
- signal_complexity_up

## Variações por relação

As cenas podem mudar ordem, temperatura e confiança conforme o histórico do jogador, mas devem preservar a capacidade real de cada facção.

Exemplos:

- baixa confiança com Helena não apaga a capacidade de escala do Consórcio;
- alta relação com Joana não elimina o custo de coordenação comunitária;
- boa relação com Nando não transforma a Rede Paralela em instituição única;
- alta Research não dá ao Aurora monopólio sobre memória;
- alta Influence não permite ao jogador controlar o Conselho.

## Invariantes

- nenhuma facção vira vilã final ou solução total;
- nenhum NPC abandona sua contradição central apenas para viabilizar o ending;
- a passagem por distritos revisita consequências existentes, não inventa uma geografia nova;
- materiais da Rede Paralela permanecem narrativos e não operacionais.

---

# 3. O Nome que Já Estava Lá

**ID:** `event_nome_da_lata`  
**Janela:** meio do Ato V, depois do mapa de contribuições.  
**Local narrativo:** Morro do Cedro, em encontro pequeno antes da formalização pública do projeto.  
**Estado-base:** CÂNONE sobre a nomeação final.

## Pré-condições

- `lore_act_v_city_contributions_mapped = true`;
- o projeto ainda usa um nome provisório técnico ou administrativo;
- a cena não depende de uma rota econômica específica.

## Participantes

- Dona Dalva;
- Dra. Lúcia Vilar;
- Rui Sal;
- jogador;
- Joana Cedro como presença opcional.

## Batida dramática

Lúcia apresenta um código técnico adequado para dossiê e rastreabilidade.

Rui propõe um título longo, poético e impossível de colocar em qualquer formulário.

A discussão começa a repetir o conflito inteiro da campanha: ciência quer precisão, memória quer densidade, mercado quer legibilidade, comunidade quer pertencimento.

Dalva interrompe.

> “Chama de DA LATA e para de frescura.”

O silêncio que segue não transforma a frase em revelação histórica.

Transforma-a em decisão presente.

O nome é canônico porque o grupo escolhe assumir o mito com suas lacunas, não porque Dalva prove uma origem secreta.

## Escolhas de tom

A escolha do jogador altera a forma de aceitar o nome, não o nome final.

### A. “DA LATA. E com a história inteira junto.”

**Flags**
- lore_da_lata_name_canonical = true
- choice_name_memory_forward = true

**Sinais**
- signal_memory_up
- signal_public_context_up

### B. “DA LATA. Mas sem chamar reconstrução de original.”

**Flags**
- lore_da_lata_name_canonical = true
- choice_name_evidence_forward = true

**Sinais**
- signal_research_up
- signal_legitimacy_up

### C. “DA LATA. Agora falta decidir de quem ela é — ou se pode ser de alguém.”

**Flags**
- lore_da_lata_name_canonical = true
- choice_name_governance_forward = true

**Sinais**
- signal_governance_pressure_up
- signal_identity_up

## Invariantes

- o nome final é sempre DA LATA;
- Dalva não autentica a lata antiga nem uma linhagem;
- a cena não estabelece autoria histórica do termo;
- o humor encerra tensão sem apagar o conflito de propriedade, memória e forma institucional.

---

# 4. Que Forma Fica de Pé

**ID:** `event_forma_da_lata`  
**Janela:** último terço do Ato V, depois da nomeação.  
**Local narrativo:** sessão híbrida entre reunião de projeto e registro público no Conselho Cívico da Baía.  
**Estado-base:** CÂNONE sobre a pluralidade de formas finais; nenhuma é ranking moral.

## Pré-condições

- `lore_da_lata_name_canonical = true`;
- contribuições das facções já foram explicitadas;
- estado acumulado de Cash, Reputation, Community, Research, Influence, relações e mercados pode alterar quais propostas chegam maduras à mesa;
- nenhuma escolha isolada deve selecionar mecanicamente um ending por si só.

## Participantes

- Isa Valente;
- Maya Santiago;
- Nando Trama;
- Dra. Lúcia Vilar;
- Joana Cedro;
- Rui Sal;
- Helena Prado;
- Caio Brandão como leitura técnica opcional;
- jogador.

## Batida dramática

Pela primeira vez, todos discutem DA LATA como algo que realmente pode existir no presente.

O conflito deixa de ser “o que aconteceu?” e vira:

> **que tipo de coisa DA LATA deve ser para continuar existindo sem apagar o modo como foi construída?**

As propostas correspondem às tensões já presentes nos endings:

- marca escalável;
- rede cooperativa;
- circulação sem institucionalização completa;
- projeto de pesquisa e arquivo;
- plataforma de grande escala com capital concentrado;
- forma composta que mantém múltiplas relações sem reivindicar pureza histórica.

Isa impede que a sessão vire plebiscito moral.

Cada proposta precisa declarar:

- o que preserva;
- o que torna possível;
- quem ganha poder de decisão;
- quem perde autonomia;
- qual memória tende a ficar mais visível;
- qual custo não desaparece.

## Escolhas de intervenção

Estas escolhas moldam o registro final, mas o ending continua derivado do estado acumulado da campanha.

### A. Exigir uma cláusula de origem fragmentária em qualquer forma final

**Flags**
- lore_final_form_debate_seen = true
- choice_final_form_fragmentary_origin_clause = true

**Sinais**
- signal_research_up
- signal_memory_up
- signal_brand_simplicity_down

### B. Exigir autoria e contrapartidas explícitas para contribuições coletivas

**Flags**
- lore_final_form_debate_seen = true
- choice_final_form_reciprocity_clause = true

**Sinais**
- signal_community_up
- signal_governance_complexity_up

### C. Exigir capacidade real de execução antes de prometer abertura ou escala

**Flags**
- lore_final_form_debate_seen = true
- choice_final_form_execution_clause = true

**Sinais**
- signal_scale_up
- signal_legitimacy_up
- signal_flexibility_down

### D. Recusar um centro único de propriedade narrativa

**Flags**
- lore_final_form_debate_seen = true
- choice_final_form_no_single_narrative_owner = true

**Sinais**
- signal_autonomy_up
- signal_memory_up
- signal_coordination_cost_up

## Ending affinity — narrativa, não regra de seleção

O evento pode reconhecer afinidades sem anunciar um “vencedor”:

- **Marca Nacional:** coerência com escala, varejo formal, Reputation e capacidade de coordenação;
- **Rede Viva:** coerência com Community, reciprocidade e governança distribuída;
- **Noite Sem Rótulo:** coerência com autonomia, Rede Paralela e baixa institucionalização;
- **Arquivo Público:** coerência com Research, procedência e abertura de acervo;
- **Atlântico:** coerência com escala, capital e aceitação de perda parcial de autonomia;
- **O Verão Volta:** coerência composta entre Research, Community, Reputation e Influence sem apagar completamente nenhum dos dois mercados.

## Invariantes

- nenhum ending é chamado de bom, ruim, verdadeiro, secreto superior ou moralmente correto;
- `O Verão Volta` continua sendo final composto, não “true ending”;
- o Conselho não escolhe pelo jogador; ele registra e enquadra trade-offs;
- nenhuma fala tenta persuadir eleitores, partidos ou agentes políticos reais.

---

# 5. A Lata do Presente

**ID:** `event_da_lata_handoff`  
**Janela:** fechamento do Ato V, imediatamente antes da coda específica do ending.  
**Local narrativo:** variável conforme a forma construída; começa com um último encontro do núcleo de personagens.  
**Estado-base:** CÂNONE sobre DA LATA como reconstrução contemporânea.

## Pré-condições

- `lore_final_form_debate_seen = true`;
- um ending elegível foi determinado por sistemas externos à lore;
- `lore_da_lata_name_canonical = true`;
- a coda não pode adicionar prova histórica nova apenas para produzir fechamento.

## Participantes

Núcleo mínimo:

- jogador;
- Dona Dalva;
- Dra. Lúcia Vilar;
- Rui Sal.

Participantes adicionais variam conforme relações e ending.

## Batida dramática

O projeto finalmente pode ser chamado de DA LATA sem aspas provisórias.

Lúcia confirma apenas o que pode confirmar.

Rui conta uma versão que já começa a divergir do registro.

Dalva não corrige nenhuma das duas.

O jogador vê as quatro marcas reunidas **agora**:

**Onda. Sol. Ferrugem. Estrela.**

A reunião presente das marcas não prova que elas estiveram historicamente juntas.

Ela funciona como síntese do caminho percorrido:

- Onda — origem lembrada;
- Sol — projeção e fama;
- Ferrugem — desgaste, edição e disputa;
- Estrela — conexão suficiente para avançar sem encerrar o mistério.

## Handoff para as codas

### Marca Nacional

A cena entrega a imagem final já canônica: embalagem contemporânea perfeita ao lado da lata antiga de Dalva.

O contraste deve permanecer sem narração moral.

### Rede Viva

A cena entrega DA LATA como selo cultural e protocolo comum entre múltiplos operadores.

O foco final retorna ao Morro do Cedro.

### Noite Sem Rótulo

A cena entrega a continuidade do mito sem formalização integral.

Risco, volatilidade e Heat permanecem custos narrativos visíveis.

### Arquivo Público

A cena entrega o acervo como objeto verificável e acessível, com a reconstrução tratada como projeto de pesquisa.

Preservação substitui escala como principal imagem de encerramento, sem ser declarada superior.

### Atlântico

A cena entrega escala nacional e deslocamento parcial de decisão para a plataforma do Consórcio.

Helena chama isso de maturidade; outros personagens podem nomear o mesmo fato de outro modo.

### O Verão Volta

A cena preserva o final composto já definido:

- lançamento sem reivindicação de pureza histórica;
- publicação da origem fragmentária;
- tempestade noturna;
- criança encontrando uma lata vazia na areia;
- quatro símbolos dentro;
- corte para preto.

A lata encontrada não recebe procedência confirmada.

O sobrenatural continua aberto.

## Flags

- lore_arc_da_lata_complete = true
- lore_reconstruction_declared_contemporary = true
- lore_four_marks_reunited_in_present = true

Flags específicos de ending pertencem à implementação futura e não são definidos nesta wave.

## Última regra narrativa

O encerramento deve permitir duas leituras simultâneas:

1. o jogador construiu algo real no presente;
2. o passado continua maior, mais incompleto e menos possuível do que qualquer produto, arquivo ou instituição.

A campanha termina sem resolver essa tensão.

---

# Continuidade e integração futura

## Dependências narrativas fechadas por esta biblioteca

- enquadramento explícito da reconstrução contemporânea;
- contribuição e custo das sete forças do Ato V;
- cena canônica de nomeação;
- pressão por forma institucional sem ranking moral;
- handoff narrativo para os seis endings existentes.

## Dependências que permanecem abertas

- autoria/composição do Caderno de Sal;
- data e identidade da voz da Fita do Farol;
- ordem histórica e origem comum das quatro marcas;
- autenticidade histórica de qualquer “original” comercializado;
- procedência exata da lata de Dalva;
- continuidade genética/histórica desde o verão original;
- identidade e natureza da Mulher da Lata.

## Próxima camada narrativa recomendada

Depois desta biblioteca, a próxima wave de lore pode criar **Ato V Dialogue Beat Sheets** para estes cinco contratos.

Essa camada deve trabalhar voz, subtexto, callbacks e linhas que não podem ser ditas sem alterar o cânone.

Materialização em Resources, UI, save flags, lógica de ending ou gameplay pertence ao SIGA, não a esta wave.
