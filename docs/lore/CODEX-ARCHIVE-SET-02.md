# DA LATA — Codex / Archive Set 02 — Ato III: Dois Mercados

Este documento define o segundo conjunto de textos de códice/arquivo de **DA LATA**, derivado dos seis eventos canônicos e das beat sheets de diálogo do **Ato III — Dois Mercados**.

A wave é **narrativa-only**. Ela não implementa Resource, schema, save, UI, balanceamento, lógica de campanha ou efeitos sistêmicos.

## Objetivos

- transformar os seis conflitos centrais do Ato III em entradas de arquivo curtas e reutilizáveis;
- dar a cada entrada um candidato estável de ID `memory_*`;
- preservar os estados `CÂNONE`, `RUMOR` e `ABERTO` sem promover incerteza por escolha do jogador;
- registrar procedência como origem do registro, não como certificado de autenticidade;
- carregar ecos de escolhas do Ato III sem reescrever o passado;
- preparar continuidade para Ato IV e Ato V sem antecipar uma forma institucional “correta”;
- manter mercado paralelo, contratos e instituições em nível ficcional e não operacional.

---

# Regras do Set 02

## Estado pertence à afirmação

Uma mesma entrada pode conter mais de um estado quando fatos diferentes exigirem classificações diferentes.

- **CÂNONE** registra acontecimentos estabelecidos no mundo ficcional.
- **RUMOR** registra alegações que circulam sem prova suficiente.
- **ABERTO** registra lacunas deliberadas que não devem ser resolvidas apenas para completar o arquivo.

Prestígio, escala empresarial, acesso institucional ou afinidade com um personagem não alteram o estado de uma afirmação.

## Procedência não é autenticação

A linha de procedência descreve de onde o registro surgiu.

Ela nunca transforma, por si só:

- uma gravação em cronologia provada;
- um anúncio comercial em linhagem histórica;
- um contrato em propriedade sobre a memória da cidade;
- uma rede social em estrutura centralizada;
- uma campanha em origem histórica;
- uma interpretação institucional em regra eterna.

## Regra de ecos de escolha

As flags `choice_*` podem mudar a frase exibida ao jogador e registrar postura ou consequência.

Elas nunca podem:

- identificar a voz da Fita do Farol;
- provar que a fita antecede o Caderno de Sal;
- autenticar um “original de 1987”;
- estabelecer ordem ou origem comum de Onda, Sol, Ferrugem e Estrela;
- transformar o jogador em proprietário da memória histórica de DA LATA;
- converter uma escolha comercial em superioridade moral;
- transformar Influence em controle político.

---

# Entrada 01 — Quatro palavras na fita

**ID:** `memory_fita_farol_quatro_marcas`  
**Evento-fonte:** `event_bento_fita_farol`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a existência da fita e as quatro palavras audíveis; ABERTO sobre data, identidade da voz, prioridade histórica e relação com o Caderno de Sal.  
**Procedência:** `gravação herdada por Bento + cópia/registro produzido no evento`

## Título de arquivo
**Quatro palavras na fita**

## Texto principal
Uma gravação herdada por Bento contém quatro palavras reconhecíveis:

**Onda. Sol. Ferrugem. Estrela.**

A fita tem remendos, regravações e catalogação incompleta. O conteúdo é real dentro do arquivo; a data exata, a identidade da voz e a relação cronológica com o **Caderno de Sal** continuam sem prova suficiente.

**A fita amplia as perguntas. Não fecha a cronologia.**

## Eco da escolha

- `choice_farol_aurora_first` — `Você priorizou cópia, documentação e preservação antes da circulação pública.`
- `choice_farol_publish_uncertainty` — `Você colocou a gravação em circulação com a incerteza no mesmo destaque.`
- `choice_farol_hold_for_corrob` — `Você manteve a pista restrita enquanto aguardava uma fonte independente.`

## Choice echoes futuros

- Se o áudio circulou, eventos posteriores podem reconhecer que mais pessoas passaram a associar as quatro marcas publicamente.
- Se ficou restrito, o arquivo pode registrar que a pista existia antes de sua circulação mais ampla.
- Nenhum eco futuro pode reclassificar data, voz, prioridade ou origem comum como CÂNONE sem nova evidência canônica explícita.

## Guardrail
Nunca escrever que a fita é anterior ao Caderno, que a voz pertence a M.V., que Bento herdou “a prova” ou que as quatro marcas surgiram juntas.

---

# Entrada 02 — O original anunciado

**ID:** `memory_original_1987_contestado`  
**Evento-fonte:** `event_falso_original`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a existência da alegação comercial e sobre a ausência de prova de linhagem contínua; RUMOR sobre a história específica do item anunciado; ABERTO sobre sua autenticidade histórica.  
**Procedência:** `registro da vitrine da Orla da Vigia + arquivo contemporâneo do episódio`

## Título de arquivo
**O original anunciado**

## Texto principal
Uma vitrine anunciou **“O ORIGINAL DE 1987”** usando as quatro marcas como linguagem visual.

O anúncio é um fato do presente. A alegação histórica não é.

O objeto pode ser antigo, recente, composto ou reaproveitado. O arquivo não possui uma cadeia capaz de demonstrar continuidade histórica ou genética desde o verão original.

**Marketing produz memória contemporânea. Não produz autenticação retroativa.**

## Eco da escolha

- `choice_false_original_catalog_claim` — `Você catalogou a alegação como artefato de mercado contestado.`
- `choice_false_original_public_distinction` — `Você tornou pública a diferença entre história, marca e evidência.`
- `choice_false_original_no_amplification` — `Você preservou o registro sem ampliar a alegação.`

## Choice echoes futuros

- A resposta pública pode tornar o jogador uma referência na distinção entre narrativa comercial e evidência, sem lhe dar autoridade histórica absoluta.
- O silêncio pode reduzir amplificação imediata, sem apagar o fato de que a alegação circulou.
- Catalogar o episódio pode permitir callbacks de arquivo em Ato IV sem transformar o item em “falso comprovado”.

## Guardrail
A entrada não declara que o item é autêntico nem materialmente falso. O que permanece inválido é tratar sua alegação comercial como prova de uma linhagem contínua já estabelecida.

---

# Entrada 03 — Nome em contrato

**ID:** `memory_nome_em_contrato`  
**Evento-fonte:** `event_helena_nome_em_contrato`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a proposta do Consórcio Atlântico e a disputa por governança de nome, símbolos e narrativa; ABERTO sobre a forma institucional futura de DA LATA.  
**Procedência:** `proposta de expansão do Consórcio Atlântico + anotações da negociação`

## Título de arquivo
**Nome em contrato**

## Texto principal
Na proposta de Helena, a parte mais valiosa não era só infraestrutura.

Era a possibilidade de organizar o uso de **nome, símbolos e narrativa pública**.

Para o Consórcio Atlântico, deixar a identidade sem governança também é uma decisão: outra organização pode ocupá-la primeiro. Para os críticos da proposta, governar a identidade pode protegê-la ou capturá-la.

O arquivo preserva a tensão.

**Organizar uma memória não prova quem a possui.**

## Eco da escolha

- `choice_helena_limited_pilot` — `Você aceitou testar escala com limites explícitos para qualquer reivindicação histórica.`
- `choice_helena_shared_attribution` — `Você condicionou uso ampliado a atribuição plural e espaço para contestação.`
- `choice_helena_reject_exclusivity` — `Você recusou exclusividade e aceitou o custo econômico de manter a identidade aberta.`

## Choice echoes futuros

- Um piloto limitado pode alimentar discussões posteriores sobre governança sem decidir o ending.
- Atribuição compartilhada pode aumentar o número de vozes presentes na memória institucional sem criar unanimidade.
- Recusar exclusividade pode preservar autonomia e simultaneamente reduzir capacidade de escala.
- Nenhuma opção predetermina a forma final de DA LATA no Ato V.

## Guardrail
Helena não é vilã secreta, capital não é sinônimo de corrupção, autonomia não é sinônimo de pureza e o contrato ficcional não funciona como aconselhamento jurídico real.

---

# Entrada 04 — Rede sem dono

**ID:** `memory_rede_sem_dono`  
**Evento-fonte:** `event_nando_sem_dono_sem_escala`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a natureza descentralizada da Rede Paralela e o conflito de Nando entre autonomia e escala.  
**Procedência:** `conversa registrada com Nando + material de coordenação apresentado no evento`

## Título de arquivo
**Rede sem dono**

## Texto principal
Uma proposta tentou dar identidade comum a relações dispersas do Mercado da Madrugada.

Nando viu o ganho: previsibilidade e escala.

Viu também o risco: quando muitas relações passam a responder pelo mesmo nome, alguém pode começar a responder **pelo nome**.

O arquivo não descreve rotas, fornecedores ou logística. Registra apenas a disputa de governança:

**uma rede pode coordenar sem virar hierarquia?**

## Eco da escolha

- `choice_nando_keep_fragmented` — `Você preservou relações independentes e aceitou menor previsibilidade.`
- `choice_nando_temporary_umbrella` — `Você apoiou uma identidade temporária sem autoridade central presumida.`
- `choice_nando_reduce_dependency` — `Você manteve a relação, mas reduziu o peso desse circuito na expansão.`

## Choice echoes futuros

- Coordenação temporária pode ser lembrada como experimento, nunca como fundação canônica de uma autoridade central.
- Fragmentação pode preservar autonomia e continuar cobrando custo de escala.
- Reduzir dependência não transforma Nando ou o Mercado da Madrugada em inimigos.
- Nenhuma variante permite material operacional sobre atividade ilícita.

## Guardrail
Não registrar rotas, pontos, sourcing, ocultação, evasão, cadeia de fornecimento ou liderança central da Rede Paralela.

---

# Entrada 05 — A história que cabe na prateleira

**ID:** `memory_historia_na_prateleira`  
**Evento-fonte:** `event_maya_prateleira_sem_improviso`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a oferta de expansão da Casa Clara e a tensão entre padronização, escala e contexto comunitário.  
**Procedência:** `rascunhos de campanha da Casa Clara + revisão de Maya e, quando presente, Joana`

## Título de arquivo
**A história que cabe na prateleira**

## Texto principal
A expansão da Casa Clara exigia uma história fácil de repetir.

Nos rascunhos, o Morro do Cedro virou **“origem autêntica”**. O improviso virou **“espírito empreendedor”**. As contradições desapareceram.

Maya rejeitou a facilidade dessa versão, mas não a necessidade de consistência.

O problema ficou no arquivo:

**quanto contexto sobrevive quando uma história precisa caber em escala?**

## Eco da escolha

- `choice_maya_standardize_commercial_only` — `Você separou a promessa comercial do arquivo narrativo e manteve uma ponte entre os dois.`
- `choice_maya_keep_cedro_visible` — `Você manteve o Cedro visível como relação e contexto, não como decoração.`
- `choice_maya_smaller_expansion` — `Você reduziu a expansão para preservar margem de mudança e complexidade narrativa.`

## Choice echoes futuros

- Um arquivo separado não pode virar lugar onde o contexto é escondido.
- Dar visibilidade ao Cedro não transforma nenhuma pessoa ou instituição em porta-voz absoluto do território.
- Reduzir escala preserva flexibilidade, mas continua tendo custo econômico real.
- Representar o Cedro nunca autentica alegações sobre 1987 ou sobre a origem das quatro marcas.

## Guardrail
Nenhuma opção é a rota moral oficial. O texto não deve incluir parâmetros reais de produção, compliance ou vantagem operacional.

---

# Entrada 06 — A regra que mudou sem mudar

**ID:** `memory_regra_que_mudou`  
**Evento-fonte:** `event_caio_regra_que_mudou`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a orientação da AVM, a coexistência de interpretações defensáveis e o custo desigual de adaptação; ABERTO sobre qual leitura se tornará estável no longo prazo.  
**Procedência:** `duas versões da orientação da AVM + registro do esclarecimento apresentado por Caio`

## Título de arquivo
**A regra que mudou sem mudar**

## Texto principal
A AVM publicou um esclarecimento que, formalmente, não alterava a regra.

Na prática, o esclarecimento mudou o cálculo de prazo, custo e risco para operadores de tamanhos diferentes.

Caio colocou as duas leituras lado a lado: ambas tinham sido defensáveis em momentos próximos.

O arquivo registra uma característica do sistema, não um vilão.

**Texto estável não garante interpretação estável.**

## Eco da escolha

- `choice_caio_adapt_early` — `Você absorveu custo cedo para comprar previsibilidade.`
- `choice_caio_use_transition` — `Você usou a janela de transição e aceitou incerteza temporária.`
- `choice_caio_public_clarification` — `Você levou a contradição para um processo público de esclarecimento.`

## Choice echoes futuros

- Adaptar cedo pode ser lembrado como capacidade de absorver incerteza, não como obediência moralmente superior.
- Usar a transição pode ser lembrado como leitura estratégica do sistema, não como evasão.
- Pedir esclarecimento público pode ampliar legibilidade institucional, sem garantir o resultado desejado.
- O convite ao Conselho Cívico da Baía continua dependente de progressão, escala e presença institucional, nunca de uma escolha “correta”.

## Guardrail
Nenhuma linha pode envolver político real, partido real, suborno, pressão pessoal, persuasão direcionada ou afirmar que Caio controla a AVM. Influence mede acesso e participação, não domínio.

---

# Relações entre as entradas

O Set 02 pode permitir referências cruzadas sem fundir os registros em uma verdade única.

## Fita -> Original
A circulação das quatro palavras pode explicar por que a linguagem das marcas ganha valor comercial rapidamente. Isso não prova que o anúncio deriva historicamente da fita nem que as marcas possuem origem comum.

## Original -> Nome em contrato
A alegação comercial contestada pode aumentar o valor percebido de governar nome e símbolos. Isso torna a proposta de Helena compreensível sem validá-la automaticamente.

## Rede sem dono -> Nome em contrato
As duas entradas apresentam respostas diferentes ao mesmo eixo: **coordenação versus autoridade**. Nenhuma delas é a solução oficial do jogo.

## Prateleira -> Nome em contrato
Escala de varejo e governança de identidade podem se cruzar em callbacks posteriores, preservando a diferença entre consistência comercial e propriedade narrativa.

## Regra -> Conselho
A forma como o jogador respondeu à ambiguidade institucional pode mudar o texto do convite ao Conselho, mas não a existência do convite quando os requisitos de campanha forem atingidos.

---

# Compatibilidade com Set 01

O Set 02 herda as seguintes invariantes de `CODEX-ARCHIVE-SET-01.md`:

1. a ordem de apresentação `Onda -> Sol -> Ferrugem -> Estrela` não é cronologia histórica;
2. a procedência da lata marcada com Onda permanece aberta;
3. a autoria e composição do Caderno de Sal permanecem abertas;
4. a prioridade de descoberta das quatro marcas não é resolvida retroativamente;
5. a Mulher da Lata e qualquer camada sobrenatural permanecem inconclusivas;
6. escolha do jogador registra postura, não verdade histórica.

O Set 02 acrescenta proteção explícita para:

- data e voz da Fita do Farol;
- relação cronológica fita/Caderno;
- autenticidade de qualquer “original” de mercado;
- futura forma institucional de DA LATA;
- ausência de liderança central canônica da Rede Paralela;
- diferença entre narrativa de origem e autenticação histórica;
- diferença entre acesso institucional e controle político.

---

# Notas para futura implementação

Esta wave não define schema.

Quando SIGA materializar o códice:

1. preservar os seis IDs `memory_*` como candidatos estáveis;
2. manter título, texto, procedência, estados e eco de escolha em campos/chaves separáveis;
3. desbloquear a entrada-base pela conclusão do evento-fonte;
4. usar `choice_*` apenas para eco e variante textual;
5. permitir múltiplos estados sem forçar toda a entrada a um único rótulo quando as afirmações forem semanticamente distintas;
6. nunca promover `RUMOR` ou `ABERTO` por causa da escolha;
7. manter callbacks opcionais e data-driven;
8. não hardcodar texto de arquivo na UI;
9. não criar save migration nesta wave narrativa;
10. manter instituições e mercado paralelo em nível abstrato e ficcional.

---

# Critério de aceite narrativo

O Set 02 está pronto para futura implementação quando:

- as seis entradas podem ser lidas sem consultar uma escolha moralmente privilegiada;
- cada entrada aponta para um único evento-fonte canônico;
- procedência e estado estão explícitos;
- a Fita do Farol continua sem data e voz provadas;
- o “original de 1987” continua sem autenticação histórica;
- nenhuma entrada estabelece ordem ou origem comum das quatro marcas;
- nenhuma entrada resolve a forma institucional final de DA LATA;
- a Rede Paralela permanece descentralizada e sem detalhe operacional;
- Caio e a AVM permanecem ficcionais e sistêmicos;
- nenhum eco transforma acesso institucional em controle político;
- nenhuma entrada inclui instrução operacional de cultivo, mercado paralelo, compliance ou atividade regulatória real;
- o Set 02 pode ser materializado futuramente sem retcon do Ato III, IV ou V.

# Status canônico

Esta wave não cria novos fatos históricos da ficção.

- **CÂNONE materializado em arquivo:** os seis conflitos centrais do Ato III ganham entradas estáveis de códice/arquivo e candidatos `memory_*`.
- **RUMOR preservado:** a Fita pode anteceder a circulação pública conhecida do Caderno; versões sobre os quatro símbolos e a história do “original” continuam disputadas.
- **ABERTO preservado:** data e voz da Fita, relação fita/Caderno, ordem e origem comum das marcas, autenticidade histórica de itens específicos, autoria do Caderno, procedência da lata da Onda, forma institucional final de DA LATA e camada sobrenatural.
