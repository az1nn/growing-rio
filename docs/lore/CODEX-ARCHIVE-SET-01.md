# DA LATA — Codex / Archive Set 01

Este documento define o primeiro conjunto de textos de códice/arquivo derivado dos seis eventos canônicos de Ato II.

Ele é **conteúdo narrativo pronto para futura materialização**, não implementação de gameplay e não definição de schema.

## Objetivos

- transformar memória, rumor e contradição em textos curtos consultáveis pelo jogador;
- preservar explicitamente os estados `CÂNONE`, `RUMOR` e `ABERTO`;
- registrar procedência sem converter procedência incompleta em autenticação;
- permitir ecos da escolha do jogador sem reescrever fatos históricos;
- manter cada bloco curto e independente para localização futura;
- oferecer microcopy dos quatro símbolos sem afirmar uma ordem histórica entre eles.

---

# Linguagem de apresentação

O estado pertence à **afirmação**, não ao prestígio de quem a contou.

## CÂNONE

**Rótulo de UI sugerido:** `REGISTRO CONFIRMADO`

**Ajuda curta:**  
`O arquivo confirma que este fato ocorreu. A interpretação ainda pode permanecer disputada.`

Usar para acontecimentos estabelecidos no mundo ficcional.

## RUMOR

**Rótulo de UI sugerido:** `RELATO NÃO VERIFICADO`

**Ajuda curta:**  
`Este relato existe no arquivo, mas não funciona como prova.`

Nunca trocar automaticamente por “confirmado”, “autêntico” ou “original” depois de uma escolha do jogador.

## ABERTO

**Rótulo de UI sugerido:** `QUESTÃO EM ABERTO`

**Ajuda curta:**  
`Há versões incompatíveis, lacunas ou evidência insuficiente para concluir.`

`ABERTO` não significa “conteúdo faltando”. É uma condição narrativa deliberada.

## Regra de procedência

A linha de procedência deve descrever **de onde o registro veio**, não o quanto ele merece confiança.

Exemplos válidos:

- `duas notas de arquivo do mesmo depoimento`;
- `fotografia entregue por Nando; origem documental incompleta`;
- `gravação de Maré de Fundo + anotação de arquivo`.

Exemplos proibidos quando o estado não permite:

- `prova definitiva`;
- `objeto original`;
- `documento autenticado`;
- `versão verdadeira`.

---

# Entrada 01 — Duas folhas

**ID:** `memory_depoimento_duas_folhas`  
**Evento-fonte:** `event_dalva_lucia_primeiro_depoimento`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a existência das duas notas; ABERTO sobre a ordem dos símbolos.  
**Procedência:** `duas notas de arquivo do mesmo depoimento`

## Título de arquivo
**Duas folhas**

## Texto principal
Duas notas registram a mesma conversa com Dalva. Uma sugere **Onda**; uma anotação posterior admite que **Estrela** talvez tenha aparecido antes. O arquivo preserva as duas versões.

**A ordem não foi estabelecida.**

## Eco da escolha

- `choice_dalva_lucia_parallel_versions` — `Você preservou as duas versões lado a lado.`
- `choice_dalva_lucia_living_memory` — `Você deu prioridade ao relato atual sem apagar a divergência.`
- `choice_dalva_lucia_hold_judgment` — `Você manteve a interpretação suspensa.`

## Guardrail
Nenhum eco pode virar “Dalva confirmou” ou estabelecer qual marca veio primeiro.

---

# Entrada 02 — Porta estreita

**ID:** `memory_porta_estreita`  
**Evento-fonte:** `event_maya_joana_porta_estreita`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre o conflito de acesso e padronização; ABERTO sobre qual das duas quase encerrou a conversa anterior.  
**Procedência:** `revisão do programa + versões de Maya e Joana`

## Título de arquivo
**Porta estreita**

## Texto principal
Maya e Joana concordam que o modelo anterior falhou em alguma coisa. Discordam sobre a falha: previsibilidade insuficiente para uma; capacidade desigual para a outra.

A expressão **“porta estreita”** permanece porque melhorar o acesso não elimina o custo de entrar.

## Eco da escolha

- `choice_porta_estreita_explicit_standard` — `Você manteve o padrão e tornou o custo impossível de esconder.`
- `choice_porta_estreita_capacity_path` — `Você defendeu uma trilha de capacidade antes do contrato.`
- `choice_porta_estreita_pilot` — `Você separou o experimento do programa principal.`

## Guardrail
O arquivo não declara Maya, Joana, Casa Clara ou Raiz do Cedro como posição moral oficial do jogo.

---

# Entrada 03 — Contexto não é controle

**ID:** `memory_contexto_sem_controle`  
**Evento-fonte:** `event_rui_cedro_contexto`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a tensão editorial entre Rui e Joana.  
**Procedência:** `edição de Maré de Fundo + exemplar marcado por Joana`

## Título de arquivo
**Contexto não é controle**

## Texto principal
A matéria de Rui não inventou o Cedro, mas Joana marcou o que ficou fora do enquadramento. A disputa não é sobre autorização prévia. É sobre quem aparece como sujeito quando uma história transforma território em símbolo.

## Eco da escolha

- `choice_rui_cedro_context_without_veto` — `Você ofereceu contexto sem pedir poder de revisão.`
- `choice_rui_cedro_editorial_note` — `Você pediu que o limite do enquadramento ficasse público.`
- `choice_rui_cedro_decline_mediation` — `Você recusou virar árbitro da relação entre os dois.`

## Guardrail
Joana não fala por todo o Cedro e Rui não funciona como narrador neutro absoluto.

---

# Entrada 04 — Procedência insuficiente

**ID:** `memory_foto_procedencia_incerta`  
**Evento-fonte:** `event_nando_procedencia_insuficiente`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** RUMOR sobre Nando ter visto uma página do Caderno antes de `T0`.  
**Procedência:** `fotografia entregue por Nando; origem documental incompleta`

## Título de arquivo
**Procedência insuficiente**

## Texto principal
A fotografia mostra um fragmento plausível associado ao **Caderno de Sal**, mas não existe cadeia suficiente para autenticar sua origem.

A pista pode ser preservada. A procedência continua insuficiente.

## Eco da escolha

- `choice_nando_catalog_unverified` — `Você catalogou a imagem como pista não verificada.`
- `choice_nando_route_to_archive` — `Você permitiu circulação do rumor com a incerteza escrita junto.`
- `choice_nando_hold_private` — `Você preservou a pista sem publicar nem autenticar.`

## Guardrail
A entrada nunca afirma que Nando viu uma página autêntica nem que Lúcia autenticou a fotografia.

---

# Entrada 05 — Quem viu primeiro

**ID:** `memory_quatro_marcas_prioridade`  
**Evento-fonte:** `event_rui_lucia_quatro_marcas`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** ABERTO sobre prioridade na percepção das quatro marcas.  
**Procedência:** `gravação antiga de Maré de Fundo + anotação de arquivo`

## Título de arquivo
**Quem viu primeiro**

## Texto principal
Rui possui uma gravação em que diz ter mostrado o padrão a Lúcia. Lúcia possui uma anotação de data semelhante indicando que já acompanhava a recorrência.

Os dois registros existem. Nenhum resolve prioridade com segurança.

## Eco da escolha

- `choice_four_marks_parallel_discovery` — `Você registrou caminhos paralelos sem fabricar prioridade.`
- `choice_four_marks_publish_dispute` — `Você deixou a própria disputa fazer parte do arquivo público.`
- `choice_four_marks_decenter_credit` — `Você tirou a prioridade do centro sem apagar a disputa por crédito.`

## Guardrail
A entrada não define quando as quatro marcas surgiram, quem as criou ou se compartilham uma origem comum.

---

# Entrada 06 — A entrevista que não foi

**ID:** `memory_entrevista_que_nao_foi`  
**Evento-fonte:** `event_dalva_rui_entrevista_que_nao_foi`  
**Desbloqueio narrativo:** após a conclusão do evento.  
**Estado:** CÂNONE sobre a noite em `T-4`; ABERTO sobre o significado do que ocorreu.  
**Procedência:** `anotação de Rui + bilhete de Dalva`

## Título de arquivo
**A entrevista que não foi**

## Texto principal
Rui descreveu uma conversa extraordinária interrompida antes da parte importante. Dalva descreveu uma conversa comum depois do fechamento.

Os dois lembram música, chuva e uma lata velha sobre o balcão. Nenhuma versão transforma o silêncio em prova.

## Eco da escolha

- `choice_non_interview_dual_archive` — `Você arquivou as duas versões sem síntese.`
- `choice_non_interview_joint_retelling` — `Você pediu uma nova lembrança conjunta sem prometer resolução.`
- `choice_non_interview_leave_open` — `Você decidiu que a lacuna podia continuar fechada para novas tentativas.`

## Guardrail
A lata não recebe nova procedência e o silêncio de Dalva permanece interpretável.

---

# Microcopy das quatro marcas

Estas linhas são **flavor copy**, não cronologia histórica.

Elas só devem aparecer quando o gating da campanha já tiver apresentado a respectiva marca.

## Onda

**ID:** `memory_symbol_onda`

`Uma marca num objeto velho; uma cidade tentando decidir quanto pesa uma lembrança.`

**Estado associado:** a existência da marca é CÂNONE; a procedência do objeto permanece ABERTO.

## Sol

**ID:** `memory_symbol_sol`

`A fotografia acende uma segunda pista, não uma resposta.`

**Estado associado:** a descoberta narrativa da marca pode ser CÂNONE quando desbloqueada; sua relação histórica com as demais permanece ABERTO.

## Ferrugem

**ID:** `memory_symbol_ferrugem`

`Documento antigo não é sinônimo de documento verdadeiro.`

**Estado associado:** qualquer lote documental futuro deve preservar autenticação parcial, mistura e incerteza já definidas para Ato IV.

## Estrela

**ID:** `memory_symbol_estrela`

`Quatro marcas podem formar um padrão sem formar uma prova.`

**Estado associado:** a marca pode integrar o padrão narrativo sem confirmar ordem, autoria, origem comum ou camada sobrenatural.

## Regra das marcas

A ordem de apresentação da campanha **não é** declaração de ordem histórica.

Nunca converter:

`Onda -> Sol -> Ferrugem -> Estrela`

em uma cronologia diegética de criação, circulação ou descoberta original.

---

# Notas para futura implementação

Esta wave não cria Resources, schema de save, UI ou código.

Quando uma wave técnica materializar o códice:

1. preservar os IDs `memory_*` como candidatos estáveis de conteúdo;
2. manter título, corpo, procedência, estado e eco de escolha em chaves separadas para localização;
3. desbloquear a entrada-base pelo evento concluído, não pela opção moralmente “correta”;
4. usar `choice_*` apenas para o eco da escolha;
5. nunca promover `RUMOR` ou `ABERTO` para `CÂNONE` por consequência de escolha;
6. evitar concatenação gramatical dinâmica entre rótulo de estado e texto principal;
7. permitir que uma futura camada de arquivo cite mais de uma fonte sem fundi-las em uma “versão verdadeira”.

## Compatibilidade com o estado técnico atual

No momento desta wave, o PR técnico #19 materializa `event_dalva_lucia_primeiro_depoimento` através de um contrato `NarrativeEventDefinition`.

Isso é evidência de implementação, não autoridade para mudar a lore.

Uma futura integração de códice pode consumir estado de campanha já validado, mas a decisão de modelo de dados pertence a uma wave técnica do SIGA.

---

# Critério de aceite narrativo

O Set 01 está pronto para futura implementação quando:

- as seis entradas podem ser exibidas sem retcon;
- cada entrada identifica procedência e estado sem usar prestígio como prova;
- os ecos de escolha registram postura, não verdade histórica;
- as quatro microcopies não estabelecem cronologia histórica;
- nenhuma entrada autentica o Caderno, a lata da Onda ou a origem conjunta das marcas;
- nenhum texto inclui instrução operacional de cultivo, mercado paralelo ou persuasão política;
- a Mulher da Lata e qualquer camada sobrenatural permanecem inconclusivas.
