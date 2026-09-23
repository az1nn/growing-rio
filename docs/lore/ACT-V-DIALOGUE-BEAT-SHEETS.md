# DA LATA — Ato V Dialogue Beat Sheets

Este documento transforma os cinco eventos canônicos de `ACT-V-NARRATIVE-EVENT-LIBRARY.md` em beat sheets de diálogo para futura materialização data-driven.

## Escopo desta wave

- preservar DA LATA como reconstrução contemporânea, nunca como linhagem histórica recuperada;
- traduzir os cinco contratos narrativos do Ato V em cenas com objetivo, abertura, subtexto, tons de resposta e callbacks;
- manter as sete forças do Ato V capazes e contraditórias, sem solução total;
- preservar Dalva como origem da nomeação presente, não como autenticadora do passado;
- manter Isa como mediadora de processo e trade-offs, não árbitra moral;
- conduzir a narrativa até as seis famílias de ending sem ranqueá-las;
- manter Onda, Sol, Ferrugem e Estrela reunidas apenas no presente;
- não implementar UI, Resources, save, balanceamento, seleção de ending ou lógica de gameplay.

## Convenções

### Voz do jogador

O protagonista continua aberto. Cada resposta expressa postura naquele momento, não uma biografia fixa.

Tons recorrentes:

- **Pragmático** — nomeia custo, prazo e efeito imediato.
- **Cuidadoso** — protege evidência, relação e incerteza.
- **Provocador** — expõe contradições sem caricaturar.
- **Solidário** — reconhece pessoas, reciprocidade e assimetrias.
- **Institucional** — privilegia registro, contestação e legibilidade.
- **Empresarial** — privilegia escala, coordenação e previsibilidade com custos explícitos.
- **Arquivístico** — distingue memória, procedência, evidência e revisão.

Nenhum tom é tratado como resposta correta.

### Regra de callbacks

Callbacks podem mudar:

- ordem de fala;
- confiança inicial;
- temperatura emocional;
- cobrança por coerência;
- qual custo cada personagem enfatiza;
- linhas opcionais de reconhecimento;
- consequência relacional.

Callbacks nunca podem:

- provar linhagem botânica contínua;
- fixar autoria do Caderno de Sal;
- datar definitivamente a Fita do Farol;
- provar origem comum ou ordem histórica das quatro marcas;
- autenticar a lata de Dalva como “original”;
- confirmar a Mulher da Lata;
- transformar Reputation, Cash, Community, Research ou Influence em prova histórica.

---

# 1. Não Existe Original para Voltar

**ID:** `event_reconstrucao_sem_original`  
**Eixos:** evidência + memória + comunicação + legitimidade.

## Objetivo da cena

Encerrar a busca pela “peça definitiva” e converter a ausência de continuidade comprovada em regra produtiva do Ato V: reconstruir exige declarar lacunas, não escondê-las.

## Forma de abertura

O laboratório do Aurora está silencioso. Sobre uma mesa existem cópias, fotografias, notas, um desenho das quatro marcas e uma ficha vazia com o campo “conclusão”.

Lúcia lê o campo e não escreve.

Lúcia:
> “Eu consigo dizer que essas coisas se tocaram. Não consigo dizer que uma linhagem atravessou décadas esperando a gente chegar.”

Rui:
> “Então depois de tudo isso a melhor história é que faltou história?”

Lúcia:
> “Não. A melhor história é a que não precisa mentir para continuar existindo.”

Se Dalva estiver presente, ela não comenta a evidência; apenas gira a lata vazia sobre a mesa.

## Subtexto

### Lúcia
- quer impedir que compatibilidade material seja inflada em continuidade botânica;
- aceita que a reconstrução tenha valor cultural, desde que a linguagem seja defensável;
- teme que uma frase de marketing apague anos de distinções.

### Rui
- não quer perder a força do mito;
- sabe que contradição também é patrimônio;
- testa se “incerteza” será tratada como vergonha ou como parte da narrativa.

### Dalva
- não disputa categorias técnicas;
- funciona como lembrança de que o objeto circulou socialmente antes de virar arquivo;
- nunca oferece prova secreta.

## Família A — Incerteza pública

**Flag:** `choice_reconstruction_public_uncertainty`

### Tom arquivístico
> “A lacuna entra no projeto. O que sabemos e o que não sabemos ficam lado a lado.”

### Tom cuidadoso
> “Se a reconstrução precisa esconder a incerteza para funcionar, ela já começou errada.”

### Tom provocador
> “Talvez o mito aguente melhor uma dúvida declarada do que uma certeza fabricada.”

### Respostas

Lúcia:
> “Isso eu assino.”

Rui:
> “E eu publico com a nota de rodapé maior que o título, se precisar.”

Se Helena for callback contextual:
> “Só não confundam complexidade com impossibilidade de comunicar.”

## Família B — Divulgação em camadas

**Flag:** `choice_reconstruction_layered_disclosure`

### Tom empresarial
> “Resumo curto na frente. Dossiê completo atrás. Nenhuma frase pode contradizer a outra.”

### Tom institucional
> “A versão pública pode ser legível. O registro precisa continuar auditável.”

### Tom pragmático
> “Nem todo mundo vai ler quarenta páginas. Todo mundo precisa poder chegar nelas.”

### Respostas

Lúcia:
> “Camada não pode virar filtro de conveniência.”

Rui:
> “E resumo tem um hábito péssimo de sobreviver ao arquivo.”

Maya, se convocada:
> “Se o resumo for verdadeiro, legibilidade não é fraude.”

## Família C — Pesquisa primeiro

**Flag:** `choice_reconstruction_research_first`

### Tom cuidadoso
> “Sem pressa de batizar uma promessa. Primeiro fechamos o que o projeto pode afirmar.”

### Tom pragmático
> “Atraso custa. Corrigir uma mentira pública custa mais.”

### Tom solidário
> “Enquanto fica fechado, precisamos dizer quem continua tendo acesso.”

### Respostas

Lúcia:
> “Prudência eu consigo defender.”

Joana, se callback:
> “Prudência para quem está dentro ainda pode ser exclusão para quem ficou fora.”

Helena, se callback:
> “Janela econômica também fecha. Isso precisa entrar no custo.”

## Callbacks

- `choice_ferrugem_shared_custody`: Rui pode lembrar que nenhum custodiante encerrou a interpretação do acervo.
- `choice_ferrugem_aurora_custody`: Lúcia assume explicitamente responsabilidade maior sobre linguagem de evidência.
- escolhas anteriores de publicidade alteram quem questiona primeiro o formato de divulgação.
- alta relação com Dalva pode adicionar silêncio confortável; nunca uma revelação.

## Linhas que devem permanecer não ditas

Nunca escrever:

- “encontramos a genética original”;
- “a DA LATA histórica sobreviveu intacta”;
- “compatibilidade prova linhagem”;
- “Dalva sempre soube a verdade”;
- “as quatro marcas eram um sistema original comprovado”.

---

# 2. Sete Partes da Cidade

**ID:** `event_sete_partes_da_cidade`  
**Eixos:** dependência + autoria + coordenação + reciprocidade.

## Objetivo da cena

Mostrar que cada força do Ato V oferece capacidade real e cobra um custo real. A cena deve fazer o jogador escolher como registrar dependências, não quem é “bom” ou “ruim”.

## Forma de abertura

A sequência começa como uma revisita à cidade. Não há caça a sete chaves. Em cada parada, o mesmo quadro recebe uma nova coluna: **contribuição / custo / poder que nasce junto**.

Isa aparece apenas no fechamento, diante do quadro completo.

Isa:
> “Agora está melhor. Não parece uma lista de aliados. Parece uma lista de dependências.”

## Subtexto por força

### Lúcia / Aurora
- oferece critério e limite;
- teme que evidência vire selo de marketing;
- sabe que pesquisa depende de financiamento e governança.

### Rui / Arquivo da Maré
- oferece memória e contradição;
- teme edição excessiva;
- também reconhece que raridade e prestígio podem virar mercado.

### Joana / Raiz do Cedro
- oferece legitimidade social e reciprocidade;
- exige que contribuição gere capacidade durável;
- teme apropriação simbólica sem retorno.

### Maya / Casa Clara
- oferece acesso e legibilidade comercial;
- exige consistência;
- reconhece que padrão pode excluir operador pequeno.

### Helena / Consórcio Atlântico
- oferece capital, escala e infraestrutura;
- espera poder proporcional ao risco assumido;
- não se vê como vilã, mas como coordenadora.

### Nando / Rede Paralela
- oferece circulação cultural, rumor e materiais fora de arquivo;
- recusa representação centralizada;
- preserva autonomia com volatilidade.

### Isa / Conselho
- oferece registro institucional de trade-offs;
- recusa prometer neutralidade sem consequência;
- não controla o resultado.

## Família A — Contribuição e custo atribuídos

**Flag:** `choice_city_contributions_attributed`

### Tom institucional
> “Toda contribuição entra com nome, custo e limite. Patrocínio neutro não existe.”

### Tom solidário
> “Se a cidade colocou coisa aqui, a cidade precisa aparecer no crédito e na contrapartida.”

### Tom arquivístico
> “Procedência para objetos. Procedência para decisões também.”

### Ecos

Joana:
> “Crédito sem capacidade depois ainda é placa na parede.”

Rui:
> “Mas placa sem nome é como arquivo sem procedência.”

Helena:
> “Quanto mais autores, mais lenta a decisão. Registra isso também.”

Isa:
> “Registrado.”

## Família B — Coordenação central

**Flag:** `choice_city_contributions_central_coordination`

### Tom empresarial
> “Um centro decide. Cada acordo declara o que entrega e o que pode bloquear.”

### Tom pragmático
> “Se ninguém tiver última palavra, qualquer desacordo vira paralisação.”

### Tom institucional
> “Centro decisório não pode significar custo invisível.”

### Ecos

Maya:
> “Isso torna entrega possível.”

Helena:
> “E responsabilidade identificável.”

Joana:
> “Identificável para decidir. Quero ver se continua identificável para responder.”

Rui:
> “E quem decide qual versão some quando duas não cabem no mesmo release?”

## Família C — Coalizão distribuída

**Flag:** `choice_city_contributions_distributed`

### Tom solidário
> “Nem tudo precisa morar no mesmo lugar para fazer parte do mesmo projeto.”

### Tom arquivístico
> “Custódias diferentes podem preservar desacordo sem fingir consenso.”

### Tom provocador
> “Talvez a complexidade seja o preço de não transformar sete partes em um dono.”

### Ecos

Lúcia:
> “Distribuição sem protocolo destrói rastreabilidade.”

Maya:
> “E aumenta custo de coordenação.”

Nando:
> “Também evita que uma porta fechada vire a única porta.”

Isa:
> “Então o custo é coordenação. Não chamem de liberdade grátis.”

## Callbacks

- baixa confiança com Helena endurece a negociação, mas não apaga sua capacidade de escala;
- alta Community faz Joana exigir mecanismos mais concretos de reciprocidade;
- alta Research faz Lúcia pedir taxonomia mais estrita;
- boa relação com Nando aumenta franqueza, nunca transforma a Rede Paralela em organização única;
- alta Influence muda acesso ao debate, nunca controle sobre Isa ou Conselho.

## Linhas que devem permanecer não ditas

Nunca escrever:

- “esta facção é a única que merece DA LATA”;
- “o mercado formal é moralmente superior”;
- “o mercado paralelo é a verdadeira essência”;
- “o Conselho pode garantir o resultado”;
- instruções de logística, ocultação, evasão ou operação ilícita.

---

# 3. O Nome que Já Estava Lá

**ID:** `event_nome_da_lata`  
**Eixos:** identidade + memória + precisão + pertencimento.

## Objetivo da cena

Canonizar o nome **DA LATA** como decisão presente e coletiva, preservando a frase de Dalva como corte de tensão — nunca como autenticação histórica.

## Forma de abertura

No Morro do Cedro, Lúcia projeta um código provisório de projeto.

Lúcia:
> “É feio porque precisa sobreviver a formulário, versão e auditoria.”

Rui abre um caderno.

Rui:
> “Tenho uma alternativa curta.”

Joana, se presente:
> “Quantas palavras?”

Rui:
> “Vinte e três, contando o subtítulo.”

Dalva:
> “Chama de DA LATA e para de frescura.”

Silêncio.

Rui fecha o caderno.

## Subtexto

### Dalva
- corta a abstração;
- reconhece o nome como algo vivo no presente;
- não reivindica autoria nem procedência.

### Lúcia
- quer que o nome não ultrapasse o dossiê;
- percebe que precisão técnica e identidade pública podem coexistir.

### Rui
- ama a densidade do mito;
- aceita ser vencido pelo nome simples porque ele carrega contradição suficiente.

### Joana
- pergunta quem pode usar o nome e em quais condições;
- desloca a conversa de estética para governança.

## Família A — Memória junto

**Flag:** `choice_name_memory_forward`

### Tom arquivístico
> “DA LATA. E a história fragmentada acompanha o nome.”

### Tom solidário
> “Se o nome vai circular, as pessoas que mantiveram essa memória também circulam com ele.”

### Tom provocador
> “Nome curto. Rodapé longo.”

### Respostas

Rui:
> “Agora sim você está falando minha língua.”

Lúcia:
> “Desde que o rodapé não vire decoração.”

Dalva:
> “Vocês conseguiram complicar até concordar.”

## Família B — Evidência junto

**Flag:** `choice_name_evidence_forward`

### Tom cuidadoso
> “DA LATA. Sem chamar reconstrução de original.”

### Tom institucional
> “O nome pode ser simples. A reivindicação precisa continuar precisa.”

### Tom pragmático
> “Se alguém perguntar ‘é a mesma?’, a resposta já está pronta: não sabemos e não vendemos isso como fato.”

### Respostas

Lúcia:
> “Então o nome não muda a evidência.”

Rui:
> “Mas muda o que a cidade vai lembrar primeiro.”

Dalva:
> “A cidade sempre lembra primeiro o que cabe na boca.”

## Família C — Governança junto

**Flag:** `choice_name_governance_forward`

### Tom institucional
> “DA LATA. Agora precisamos decidir quem pode falar por esse nome.”

### Tom solidário
> “E quem consegue participar sem pedir licença para um dono único.”

### Tom empresarial
> “Nome sem regra de uso vira conflito de escala antes de virar produto.”

### Respostas

Joana:
> “Agora começou a conversa difícil.”

Rui:
> “A fácil era só achar o nome?”

Dalva:
> “A fácil era parar de inventar nome ruim.”

## Callbacks

- `choice_city_contributions_attributed`: Joana pode exigir que o nome carregue a matriz de autoria/contribuição.
- `choice_city_contributions_central_coordination`: Helena ou Maya podem perguntar quem responde oficialmente pelo nome.
- `choice_city_contributions_distributed`: Rui pode defender múltiplos usos com origem comum documentada.
- o histórico com Dalva muda intimidade e humor, nunca conteúdo probatório.

## Linhas que devem permanecer não ditas

Nunca escrever:

- “Dalva revelou o nome verdadeiro”;
- “esse era o nome original de 1987”;
- “a lata de Dalva prova a origem”;
- “DA LATA sempre foi uma marca histórica única”;
- “o nome encerra o mistério”.

---

# 4. Que Forma Fica de Pé

**ID:** `event_forma_da_lata`  
**Eixos:** governança + escala + autonomia + memória + execução.

## Objetivo da cena

Transformar os endings em propostas de forma organizacional sem anunciar vencedor moral. Cada proposta deve declarar capacidade, custo, concentração de decisão e memória que tende a dominar.

## Forma de abertura

A mesa do Conselho tem seis pastas, nenhuma intitulada “melhor opção”.

Isa escreve no quadro:

1. o que preserva;
2. o que torna possível;
3. quem decide;
4. quem perde autonomia;
5. qual memória fica mais visível;
6. qual custo continua existindo.

Isa:
> “Se uma proposta não consegue preencher as seis linhas, ela ainda é slogan.”

Caio, se presente:
> “Ou minuta.”

Isa:
> “Minuta ainda pode ser corrigida.”

## Subtexto

### Isa
- protege comparabilidade e registro;
- quer impedir que retórica esconda assimetrias;
- não endossa forma final.

### Maya
- defende acesso formal e previsibilidade;
- teme complexidade que inviabilize oferta.

### Nando
- protege autonomia e circulação não centralizada;
- aceita que volatilidade permaneça custo.

### Lúcia
- protege limites de evidência e integridade do arquivo;
- não exige que pesquisa controle todo o projeto.

### Joana
- cobra reciprocidade, capacidade distribuída e memória social;
- aceita coordenação quando custo e retorno são explícitos.

### Rui
- protege pluralidade narrativa;
- teme que governança vire edição definitiva da memória.

### Helena
- defende escala, propriedade clara e capacidade executiva;
- assume perda de autonomia como troca, não como acidente.

### Caio
- traduz promessas em regras, transições e exceções;
- não moraliza o desenho institucional.

## Família A — Origem fragmentária obrigatória

**Flag:** `choice_final_form_fragmentary_origin_clause`

### Tom arquivístico
> “Qualquer forma final precisa declarar que a origem é fragmentária e a reconstrução é contemporânea.”

### Tom cuidadoso
> “Se crescer exige apagar a lacuna, o crescimento está mudando o objeto.”

### Ecos

Lúcia:
> “Isso protege a distinção central.”

Helena:
> “E aumenta o custo de comunicação. Eu aceito discutir custo, não fingir que não existe.”

Rui:
> “Uma marca que carrega a própria nota de rodapé. Gosto.”

## Família B — Reciprocidade obrigatória

**Flag:** `choice_final_form_reciprocity_clause`

### Tom solidário
> “Contribuição coletiva precisa gerar autoria, retorno e capacidade depois do lançamento.”

### Tom institucional
> “Contrapartida precisa ser verificável, não agradecimento.”

### Ecos

Joana:
> “Aí dá para discutir número, prazo e governança sem chamar isso de favor.”

Maya:
> “Só não façam um mecanismo tão complexo que ninguém pequeno consiga entrar.”

Helena:
> “Reciprocidade sem capacidade financeira vira promessa bonita.”

## Família C — Execução antes de promessa

**Flag:** `choice_final_form_execution_clause`

### Tom pragmático
> “Não prometemos abertura, escala ou preservação sem capacidade concreta para sustentar.”

### Tom empresarial
> “Compromisso sem operação é dívida futura.”

### Ecos

Helena:
> “Finalmente.”

Joana:
> “Desde que ‘capacidade’ não signifique só capital.”

Lúcia:
> “E preservação também precisa de orçamento.”

Caio:
> “E regra de transição.”

## Família D — Sem dono único da narrativa

**Flag:** `choice_final_form_no_single_narrative_owner`

### Tom arquivístico
> “Pode existir operador principal. Não pode existir proprietário único da história.”

### Tom provocador
> “Quem compra infraestrutura não compra o passado junto.”

### Tom institucional
> “Direito de decidir operação e direito de editar memória são poderes diferentes.”

### Ecos

Rui:
> “Essa diferença precisa sobreviver ao contrato.”

Helena:
> “Então definam onde termina uma decisão de marca e começa uma decisão de arquivo.”

Isa:
> “Boa. Agora existe uma fronteira discutível em vez de uma palavra bonita.”

## Afinidades sem veredito

As falas podem reconhecer coerência entre estado acumulado e propostas, sem dizer qual ending é superior:

- **Marca Nacional** — escala, varejo formal e coordenação;
- **Rede Viva** — reciprocidade, Community e governança distribuída;
- **Noite Sem Rótulo** — autonomia, circulação paralela abstrata e baixa institucionalização;
- **Arquivo Público** — Research, procedência e acesso ao acervo;
- **Atlântico** — capital, escala e aceitação de decisão concentrada;
- **O Verão Volta** — composição entre Research, Community, Reputation e Influence, preservando os dois mercados.

## Callbacks

- decisões da Audiência do Ato IV alteram a linguagem de Isa e Caio;
- a matriz de contribuições do evento anterior define quais custos já estão reconhecidos;
- a escolha de nomeação muda o primeiro eixo de discussão: memória, evidência ou governança;
- relações altas tornam discordâncias mais francas, não eliminam contradições.

## Linhas que devem permanecer não ditas

Nunca escrever:

- “este é o final certo”;
- “O Verão Volta é o true ending”;
- “Isa aprova esta proposta”;
- “o Conselho escolhe o futuro por você”;
- “uma forma institucional resolve todos os trade-offs”;
- qualquer referência a partidos, candidatos, eleições ou persuasão política real.

---

# 5. A Lata do Presente

**ID:** `event_da_lata_handoff`  
**Eixos:** síntese + despedida + memória + continuidade aberta.

## Objetivo da cena

Entregar o arco às codas dos endings sem adicionar nova prova histórica. O fechamento precisa afirmar que DA LATA existe no presente e que o mistério continua parcialmente aberto.

## Forma de abertura

As quatro marcas aparecem juntas num suporte contemporâneo pela primeira vez:

**Onda. Sol. Ferrugem. Estrela.**

Rui:
> “Bonito ver assim.”

Lúcia:
> “Assim, agora.”

Rui:
> “Você não perde uma.”

Lúcia:
> “É por isso que você me chama.”

Dalva observa a composição e empurra a lata antiga alguns centímetros para o lado, como se recusasse a deixá-la virar centro absoluto da imagem.

## Subtexto

### Lúcia
- confirma somente o presente verificável;
- aceita que a reconstrução tenha vida além do laboratório;
- protege a frase “assim, agora”.

### Rui
- já percebe que novas versões nascerão;
- aceita que memória viva não é o mesmo que falsificação;
- continua atento a quem ganha poder de editar.

### Dalva
- trata DA LATA como coisa viva do presente;
- recusa transformar seu objeto em relíquia sagrada;
- preserva humor e ambiguidade.

### Jogador
- não escolhe novamente o ending;
- reconhece o custo e a forma já construídos;
- pode definir o tom da despedida.

## Família de resposta — reconhecer construção

### Tom cuidadoso
> “Não recuperamos o passado. Construímos algo que consegue dizer de onde vieram as lacunas.”

### Tom pragmático
> “Funciona agora. E sabemos o que custou para ficar de pé.”

### Tom solidário
> “Tem muita gente dentro desse nome. Quero que continue aparecendo.”

### Tom arquivístico
> “As quatro marcas estão juntas no presente. O arquivo continua dizendo exatamente isso.”

### Tom provocador
> “Daqui a dez anos alguém vai contar tudo errado.”

Rui:
> “Daqui a dez minutos.”

Dalva:
> “Então fala menos e deixa espaço para a próxima versão.”

## Handoff por ending

### Marca Nacional

Maya pode olhar a embalagem final ao lado da lata antiga.

Maya:
> “Duas embalagens. Duas épocas. Nenhuma precisa fingir que é a outra.”

O contraste encerra a cena sem condenar escala nem romantizar origem.

### Rede Viva

Joana recebe uma versão do selo comum e pergunta quem será o próximo operador a reinterpretá-lo.

Joana:
> “Se continuar vivo, vai mudar. A regra é não apagar quem mudou junto.”

### Noite Sem Rótulo

Nando vê uma cópia simples das quatro marcas.

Nando:
> “Se tentarem prender isso num lugar só, já começou a escapar.”

A fala nunca inclui instrução operacional de mercado paralelo.

### Arquivo Público

Lúcia fecha uma caixa de conservação enquanto Rui abre uma consulta pública do acervo.

Lúcia:
> “Preservar não é congelar interpretação.”

Rui:
> “Ainda bem.”

### Atlântico

Helena observa a primeira execução em grande escala.

Helena:
> “Agora existe capacidade para durar.”

Rui, opcional:
> “E capacidade para editar. Não esquece a segunda frase.”

Helena:
> “Por isso ela está no contrato.”

### O Verão Volta

A cena mantém a coda canônica:

- lançamento sem reivindicação de pureza histórica;
- origem fragmentária publicada;
- tempestade;
- manhã seguinte;
- criança encontra uma lata vazia na areia;
- quatro símbolos dentro;
- corte para preto.

Nenhum personagem identifica a lata. Nenhum arquivo a autentica. Nenhuma narração confirma o sobrenatural.

## Callbacks

- `choice_reconstruction_public_uncertainty` pode aparecer em material final visível;
- `choice_reconstruction_layered_disclosure` pode reaparecer como resumo + arquivo;
- `choice_reconstruction_research_first` muda o alívio de Lúcia ao chegar ao lançamento;
- a matriz de contribuições define quem aparece ou é citado na coda;
- a escolha de nomeação altera a frase final do jogador;
- as cláusulas da forma final mudam o vocabulário de governança da despedida.

## Linhas que devem permanecer não ditas

Nunca escrever:

- “finalmente encontramos a verdadeira DA LATA”;
- “a lata da praia prova que o mito era real”;
- “a Mulher da Lata deixou o objeto”;
- “as quatro marcas sempre pertenceram ao mesmo conjunto”;
- “esta coda confirma a origem histórica”;
- “este ending é melhor que os outros”.

---

# Guardrails de voz do Ato V

## Dalva
- frases curtas, concretas e frequentemente bem-humoradas;
- corta grandiloquência sem virar caricatura;
- nunca autentica história por autoridade pessoal;
- pode reconhecer memória sem transformá-la em prova.

## Lúcia
- separa evidência, interpretação e comunicação;
- aceita reconstrução como projeto válido;
- corrige linguagem maior que a evidência;
- não monopoliza memória.

## Rui
- produz frases memoráveis e versões concorrentes;
- sabe que narrativa pode contaminar verificação;
- defende contradição sem confundir rumor com fato.

## Joana
- pergunta quem recebe crédito, retorno e capacidade;
- liga memória a território e reciprocidade;
- não exige pureza econômica.

## Maya
- busca legibilidade, previsibilidade e acesso;
- reconhece custo de padronização;
- não reduz tudo a marketing.

## Helena
- pensa em escala, tempo, propriedade e execução;
- assume trade-offs de concentração;
- não é escrita como vilã secreta.

## Nando
- protege autonomia e circulação distribuída;
- não fala por toda a Rede Paralela;
- nunca fornece instrução ilícita operacional.

## Isa
- compara propostas pelo que preservam, habilitam e custam;
- exige registro de poder e trade-off;
- não endossa ending;
- não representa política real.

## Caio
- traduz promessa em regra, transição e exceção;
- burocracia é restrição sistêmica, não piada de incompetência;
- pode identificar incompatibilidades sem declarar solução moral.

---

# Continuidade preservada

## CÂNONE

- DA LATA é reconstrução contemporânea.
- O nome final é DA LATA.
- Dalva fornece a frase de nomeação presente.
- As sete forças oferecem capacidades reais e custos reais.
- A forma institucional final não possui ranking moral.
- Onda, Sol, Ferrugem e Estrela podem ser reunidas no presente.
- As seis famílias de ending permanecem válidas.
- O Verão Volta permanece composto, não “verdadeiro”.

## RUMOR

Permanecem rumor:

- alegações de “original” histórico;
- versões incompatíveis sobre o Caderno;
- interpretações sobre a Fita do Farol;
- Mulher da Lata;
- leituras sobrenaturais das quatro marcas.

## ABERTO

Permanecem abertos:

- autoria/composição do Caderno de Sal;
- data e identidade da voz da Fita do Farol;
- ordem histórica das quatro marcas;
- origem comum das quatro marcas;
- procedência definitiva da lata de Dalva;
- continuidade genética desde o verão original;
- status sobrenatural e identidade da Mulher da Lata.

---

# Critério de aceite narrativo

A wave está pronta quando:

1. os cinco eventos possuem objetivo, abertura, subtexto, famílias de resposta, callbacks e linhas proibidas;
2. todas as flags preservam o significado já definido na event library;
3. reconstrução nunca vira prova de linhagem;
4. Dalva nomeia o projeto no presente sem autenticar o passado;
5. as sete forças mantêm capacidade e contradição;
6. Isa nunca vira árbitra moral;
7. os endings continuam sem ranking e O Verão Volta não vira “true ending”;
8. Onda, Sol, Ferrugem e Estrela permanecem historicamente não ordenadas;
9. o sobrenatural continua aberto;
10. nenhum diálogo introduz instrução real de cultivo, mercado paralelo ou persuasão política real.
