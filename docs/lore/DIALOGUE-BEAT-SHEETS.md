# DA LATA — Dialogue Beat Sheets

Este documento transforma os seis eventos canônicos de `NARRATIVE-EVENT-LIBRARY.md` em beat sheets de diálogo para futura implementação.

## Escopo desta wave

- preservar o significado e as classificações `CÂNONE`, `RUMOR` e `ABERTO`;
- dar voz própria aos personagens sem transformá-los em narradores da moral do jogo;
- oferecer 2–3 tons de resposta do jogador por escolha;
- manter falas curtas o suficiente para futura localização;
- preparar callbacks que possam reaparecer em eventos posteriores;
- registrar explicitamente o que **não pode ser dito** para não fechar mistérios ainda abertos;
- não introduzir instruções operacionais de cultivo, mercado paralelo ou persuasão política.

## Convenções de escrita

### Voz do jogador

O protagonista continua aberto. As opções de fala devem expressar postura, não biografia fixa.

Tons recorrentes:

- **Pragmático** — resolve o problema imediato sem fingir neutralidade absoluta.
- **Cuidadoso** — protege incerteza, relação ou evidência antes de acelerar.
- **Provocador** — pressiona contradições sem virar insulto gratuito.
- **Solidário** — reconhece custo humano/comunitário sem transformar um NPC em porta-voz moral.
- **Institucional** — privilegia registro, regra ou processo, sempre com custo dramático visível.

Nenhum tom é moralmente rotulado como correto.

### Regra de subtexto

Subtexto nunca deve repetir literalmente o valor temático do personagem. O personagem fala sobre o problema concreto; a tensão temática emerge da cena.

### Regra de consequência

Um callback de diálogo pode:

- mudar confiança;
- alterar calor emocional da cena;
- abrir ou fechar uma linha opcional;
- lembrar uma escolha anterior;
- mudar a forma de apresentar uma pista.

Ele não pode transformar uma escolha anterior em prova histórica.

---

# 1. O primeiro depoimento

**ID:** `event_dalva_lucia_primeiro_depoimento`  
**Eixos:** memória + evidência + legitimidade do arquivo.

## Objetivo da cena

Fazer o jogador escolher **como registrar uma contradição** sem permitir que a escolha resolva qual símbolo foi citado primeiro.

## Abertura

Lúcia coloca duas folhas lado a lado. Uma está organizada, datada e limpa. A outra tem uma anotação marginal feita depois.

Dalva olha as duas e diz, sem dramatizar:

> "Aconteceu uma conversa. O resto vocês estão tentando pôr em fila."

Lúcia responde que colocar em fila é justamente o que o arquivo precisa evitar quando a fila não existe.

## Subtexto

### Dalva
- quer proteger a textura da memória contra uma versão "bonita demais";
- testa se o jogador sabe suportar uma resposta incompleta;
- não quer que sua lembrança vire certificado de procedência.

### Lúcia
- quer registrar a contradição para impedir falsificação por simplificação;
- está menos interessada em "vencer" Dalva do que em proteger o arquivo de certeza fabricada;
- observa se o jogador entende diferença entre testemunho e prova.

## Escolha A — Registrar as duas versões lado a lado

### Tom pragmático
**Intenção:** "Se as duas existem, o arquivo precisa mostrar as duas."

Possível formulação:
> "A divergência é parte do registro. Deixa as duas."

### Tom cuidadoso
**Intenção:** proteger a memória de uma síntese prematura.

Possível formulação:
> "Não escolhe por elas. Marca a diferença e segue."

### Tom provocador
**Intenção:** questionar a obsessão por ordem.

Possível formulação:
> "Talvez o erro seja achar que alguém precisa ter dito primeiro."

### Resposta de Dalva
Aprova a ausência de pressão, mas avisa que uma contradição registrada ainda pode ser explorada por quem quer espetáculo.

### Resposta de Lúcia
Aprova a precisão e pede uma nota explícita: "ordem não estabelecida".

### Callback
Em `event_rui_lucia_quatro_marcas`, Lúcia pode lembrar:
> "Você já preferiu registrar a disputa em vez de fabricar prioridade."

## Escolha B — Priorizar o depoimento oral mais recente

### Tom solidário
**Intenção:** reconhecer memória viva como algo que continua mudando.

> "Se ela está aqui para corrigir a própria lembrança, isso também importa."

### Tom pragmático
**Intenção:** usar a fala atual como versão principal sem apagar a anterior.

> "A versão atual entra na frente. A anterior continua anexada."

### Tom provocador
**Intenção:** desafiar a rigidez documental.

> "Arquivo também envelhece. Pessoa viva pode responder."

### Resposta de Dalva
Aceita melhor a formulação quando a escolha não vira "Dalva confirmou".

### Resposta de Lúcia
Concorda apenas com a condição de que a divergência permaneça visível.

### Callback
Lúcia pode, mais tarde, perguntar se o jogador continua confortável quando outra pessoa usa "memória viva" para defender uma versão conveniente.

## Escolha C — Congelar a interpretação

### Tom institucional
**Intenção:** não priorizar nenhuma versão sem nova evidência.

> "Registra a divergência e não conclui nada por enquanto."

### Tom cuidadoso
**Intenção:** impedir que urgência narrativa produza certeza.

> "A gente não perde nada deixando isso em aberto."

### Tom pragmático
**Intenção:** separar arquivo de decisão.

> "Guarda as duas. A pesquisa continua sem escolher uma."

### Resposta de Dalva
Considera sensato, mas ironiza a necessidade institucional de declarar oficialmente que não sabe.

### Resposta de Lúcia
Vê disciplina metodológica.

### Callback
Rui pode chamar essa escolha de "o dia em que você arquivou um ponto de interrogação".

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- "Onda veio primeiro";
- "Estrela veio primeiro";
- "essa lata é original";
- "Dalva confirmou a procedência";
- "Lúcia provou a ordem das marcas".

---

# 2. A porta estreita

**ID:** `event_maya_joana_porta_estreita`  
**Eixos:** legitimidade + comunidade + institucionalização.

## Objetivo da cena

Fazer o jogador intervir numa negociação em que ambos os lados têm custos reais, sem transformar Maya ou Joana em posição moral oficial do jogo.

## Abertura

Maya entrega uma nova versão do programa. Joana não lê o título; vai direto às condições.

Joana:
> "Melhorou a porta. Continua estreita."

Maya:
> "Se eu tirar a moldura inteira, ninguém sabe mais o que está comprando."

O jogador entra quando ambas admitem que o modelo anterior falhou em alguma coisa, mas discordam sobre o quê.

## Subtexto

### Maya
- quer provar que estrutura e acesso podem coexistir;
- teme que exceção demais desmoralize o programa;
- não quer ser reduzida à "cara simpática" de uma instituição.

### Joana
- quer capacidade real no território, não apenas convite;
- teme que transparência seja usada como desculpa para manter barreiras;
- respeita Maya o suficiente para continuar a conversa.

## Escolha A — Manter o padrão e tornar os custos explícitos

### Tom institucional
> "Se o requisito fica, o custo precisa ficar impossível de esconder."

### Tom pragmático
> "Não promete acesso barato. Mostra exatamente o preço de entrar."

### Tom provocador
> "Porta estreita pelo menos não pode fingir que é larga."

### Resposta de Maya
Aprova previsibilidade.

### Resposta de Joana
Aceita honestidade, mas ressalta que clareza de exclusão ainda é exclusão para alguns.

### Callback
Joana pode mais tarde lembrar:
> "Você sempre gostou de chamar custo pelo nome."

## Escolha B — Criar uma trilha de capacidade antes do contrato

### Tom solidário
> "Antes de cobrar prontidão, dá um caminho para chegar nela."

### Tom pragmático
> "Quebra o salto em etapas. Quem avança prova que consegue sustentar."

### Tom institucional
> "Define marcos claros. Flexibilidade sem regra vira favor."

### Resposta de Maya
Aceita experimentar, mas teme criar dois padrões.

### Resposta de Joana
Vê reciprocidade concreta, porém cobra continuidade.

### Callback
Maya pode, em evento futuro, citar essa escolha ao discutir escalabilidade:
> "Você abriu uma trilha. Agora me diz quando ela deixa de ser piloto."

## Escolha C — Separar o piloto do programa principal

### Tom cuidadoso
> "Não mexe no programa inteiro com uma hipótese. Testa pequeno."

### Tom pragmático
> "Piloto com começo, fim e critério de saída."

### Tom provocador
> "Piloto que nunca vira programa é só fotografia."

### Resposta de Maya
Gosta do limite de risco.

### Resposta de Joana
Aceita somente se houver critério para não virar vitrine permanente.

### Callback
A palavra "piloto" pode reaparecer com tensão quando instituições tentarem usar experimentos como substituto de compromisso.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- que a Casa Clara é o caminho "correto";
- que a cooperativa deve ter veto sobre o mercado;
- números, subsídios ou desenho regulatório real;
- instruções de lobby ou persuasão política;
- que uma das duas "vence" a discussão.

---

# 3. Contexto não é controle

**ID:** `event_rui_cedro_contexto`  
**Eixos:** comunidade + narrativa + reputação.

## Objetivo da cena

Mostrar a diferença entre pedir contexto e exigir controle editorial.

## Abertura

Rui chega com a edição já circulando. Joana chega com uma cópia marcada à mão.

Joana:
> "Você não mentiu."

Rui:
> "Ótimo começo."

Joana:
> "Também não contou quem estava carregando a história nas costas."

Rui para de sorrir antes de responder.

## Subtexto

### Rui
- sabe que a crítica é parcialmente justa;
- teme transformar consulta em autorização prévia;
- prefere uma história imperfeita em circulação a uma história perfeita enterrada.

### Joana
- não quer editar Rui;
- quer impedir que o Cedro vire cenário sem sujeitos;
- testa se o jogador entende que visibilidade pode extrair valor.

## Escolha A — Entregar contexto adicional sem pedir revisão prévia

### Tom pragmático
> "Eu te passo o que faltou. O texto continua sendo seu."

### Tom solidário
> "Inclui quem faz o trabalho. Não precisa pedir permissão para contar."

### Tom provocador
> "Independência editorial não exige cegueira voluntária."

### Resposta de Rui
Aceita material sem abrir mão da decisão final.

### Resposta de Joana
Reconhece avanço, mas não chama de reparação completa.

### Callback
Rui pode usar uma fonte indicada pelo jogador em edição posterior, lembrando explicitamente que "contexto não é crédito automático".

## Escolha B — Pedir uma nota pública sobre as limitações da história

### Tom institucional
> "Não reescreve. Só registra o enquadramento que ficou de fora."

### Tom cuidadoso
> "Uma nota de limite vale mais do que fingir cobertura total."

### Tom provocador
> "Se a matéria tem recorte, assume o recorte."

### Resposta de Rui
Aceita, mas observa que o jogador está começando a entender poder narrativo.

### Resposta de Joana
Valoriza a transparência sem tratar a nota como solução estrutural.

### Callback
Rui pode depois perguntar:
> "Você quer contexto ou quer controlar a legenda?"

## Escolha C — Recusar intermediação

### Tom pragmático
> "Essa conversa já existia antes de mim. Continuem sem me usar de árbitro."

### Tom cuidadoso
> "Eu posso ouvir, mas não vou virar selo de legitimidade de nenhum dos dois."

### Tom provocador
> "Se vocês precisam de mim para conversar, o problema é maior que a matéria."

### Resposta de Rui
Respeita a recusa de controle.

### Resposta de Joana
Pode ler como coerência ou conveniência, conforme confiança acumulada.

### Callback
A recusa pode reduzir a disponibilidade de linhas em que NPCs pedem mediação direta, sem bloquear o evento principal.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- que Joana controla a cobertura do Cedro;
- que Rui é narrador neutro absoluto;
- que o jogador autentica a versão de qualquer um;
- que "representar a comunidade" equivale a falar por todos.

---

# 4. Procedência insuficiente

**ID:** `event_nando_procedencia_insuficiente`  
**Eixos:** autonomia + evidência + memória + risco.

## Objetivo da cena

Permitir que o jogador preserve uma pista sem convertê-la em autenticação.

## Abertura

Nando coloca a fotografia sobre a mesa e não solta imediatamente.

Nando:
> "Não estou pedindo certificado."

Lúcia:
> "Ótimo. Porque você não trouxe procedência."

Nando finalmente solta a foto:
> "Trouxe uma coisa que talvez mereça não ser jogada fora."

## Subtexto

### Nando
- quer provar que informação útil pode chegar pela via errada;
- não quer se submeter ao papel de testemunha confiável;
- testa se o jogador confunde origem informal com falsidade automática.

### Lúcia
- reconhece plausibilidade visual, mas recusa salto probatório;
- teme que circulação pública crie uma falsa cadeia de procedência;
- não trata Nando como mentiroso; trata a evidência como insuficiente.

## Escolha A — Catalogar como pista não verificada

### Tom institucional
> "Entra no arquivo como origem incerta. Nem mais, nem menos."

### Tom pragmático
> "A gente guarda o que sabe e marca o que não sabe."

### Tom solidário
> "Não precisa acreditar em você para não descartar a pista."

### Resposta de Nando
Aceita o meio-termo.

### Resposta de Lúcia
Aprova a separação entre preservação e autenticação.

### Callback
Em pesquisas posteriores, a imagem pode reaparecer como referência cruzada, sempre com etiqueta de procedência incerta.

## Escolha B — Encaminhar ao Arquivo da Maré como rumor

### Tom pragmático
> "Isso pode render fonte antes de render prova."

### Tom provocador
> "Se vai circular de qualquer jeito, melhor circular com a dúvida escrita."

### Tom solidário
> "Memória pública também pode guardar coisa que ciência ainda não consegue fechar."

### Resposta de Nando
Gosta da velocidade.

### Resposta de Lúcia
Alerta que visibilidade cria ecos difíceis de separar da fonte original.

### Callback
Rui pode dizer mais tarde:
> "Rumor etiquetado continua sendo rumor. Mas às vezes alguém reconhece a etiqueta."

## Escolha C — Guardar sem publicar nem autenticar

### Tom cuidadoso
> "Fica guardado até aparecer algo independente."

### Tom institucional
> "Sem cadeia suficiente, sem circulação por enquanto."

### Tom pragmático
> "Não vou perder a pista. Também não vou inflar."

### Resposta de Nando
Aceita com irritação controlada.

### Resposta de Lúcia
Aprova a cautela.

### Callback
Se uma evidência independente surgir, a fotografia pode reaparecer; ela continua sem provar que Nando viu uma página autêntica antes de `T0`.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- "Nando viu o Caderno verdadeiro";
- "a foto prova a página";
- "Lúcia autenticou porque reconheceu detalhes";
- conteúdo operacional ou parâmetros reais de cultivo.

---

# 5. Quem viu primeiro

**ID:** `event_rui_lucia_quatro_marcas`  
**Eixos:** evidência + narrativa + reputação + memória.

## Objetivo da cena

Transformar disputa de prioridade em conflito sobre método, crédito e memória sem escolher vencedor.

## Abertura

Rui toca alguns segundos de uma gravação antiga. A frase é clara; a data, menos.

Lúcia coloca ao lado uma anotação com data semelhante.

Rui:
> "Eu falei primeiro."

Lúcia:
> "Você publicou primeiro."

Rui:
> "Essa é uma diferença muito conveniente."

Lúcia:
> "É uma diferença verificável."

## Subtexto

### Rui
- acredita que tornar uma descoberta pública também faz parte da descoberta;
- teme que arquivos absorvam crédito de quem trabalha fora deles;
- quer uma história forte, mas sabe que a evidência não resolve a prioridade.

### Lúcia
- quer impedir que visibilidade substitua cronologia;
- reconhece que crédito importa;
- teme que uma boa narrativa force uma linha temporal inexistente.

## Escolha A — Registrar descoberta simultânea e independente

### Tom cuidadoso
> "Os dois chegaram perto demais no tempo para inventar uma fila segura."

### Tom pragmático
> "Registra caminhos diferentes, mesma janela."

### Tom provocador
> "Talvez vocês estejam brigando por uma precisão que o arquivo não tem."

### Resposta de Rui
Aceita, chamando a solução de pouco cinematográfica.

### Resposta de Lúcia
Aprova por não fabricar prioridade.

### Callback
Rui pode fazer piada recorrente sobre "descoberta simultânea, segundo o cartório".

## Escolha B — Publicar a disputa como parte da própria história

### Tom narrativo
> "A divergência é a matéria. Publica sem escolher vencedor."

### Tom pragmático
> "Mostra as duas peças juntas. A incerteza entra no título, não na nota de rodapé."

### Tom provocador
> "Se vocês discordam com documento na mão, a cidade merece ver isso."

### Resposta de Rui
Ganha energia com a ideia.

### Resposta de Lúcia
Aceita se a incerteza tiver o mesmo destaque que a disputa.

### Callback
A publicação pode aumentar a chegada de novas pistas e ruído, sem alterar o status de cânone.

## Escolha C — Tratar prioridade como irrelevante para a pesquisa

### Tom institucional
> "Crédito fica registrado. A pesquisa segue atrás das ocorrências."

### Tom pragmático
> "Quem viu primeiro não muda o padrão que precisamos rastrear."

### Tom provocador
> "Vocês estão medindo ego com régua de arquivo."

### Resposta de Lúcia
Concorda com o foco metodológico.

### Resposta de Rui
Resiste à ideia de que crédito seja detalhe, lembrando que memória também é disputa de autoria.

### Callback
Em Ato IV, uma discussão sobre propriedade cultural pode ecoar a distinção entre "quem identificou", "quem publicou" e "quem possuía".

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- que Rui percebeu primeiro;
- que Lúcia percebeu primeiro;
- uma data definitiva para surgimento das quatro marcas;
- que a disputa autentica o Caderno de Sal.

---

# 6. A entrevista que não foi

**ID:** `event_dalva_rui_entrevista_que_nao_foi`  
**Eixos:** memória + narrativa + privacidade + reputação.

## Objetivo da cena

Transformar a ausência de gravação em escolha sobre arquivo, reencontro e limite — sem sugerir que o silêncio de Dalva escondia necessariamente uma revelação.

## Abertura

O jogador lê primeiro a anotação de Rui e depois o bilhete de Dalva.

Rui:
> "Eu tenho certeza de que ela sabia quando parou de falar."

Dalva:
> "Eu tenho certeza de que ele decidiu isso depois."

Rui:
> "Tinha uma lata na mesa."

Dalva:
> "Tinha um monte de coisa na mesa."

## Subtexto

### Dalva
- quer que silêncio continue podendo ser apenas silêncio;
- não quer que recusa de gravação seja convertida em pista automaticamente;
- gosta de Rui, mas desconfia da máquina narrativa dele.

### Rui
- acredita que a noite teve importância porque ele lembra sua forma;
- sabe que ausência é terreno fértil para autoengano;
- quer preservar a história sem forçar Dalva a repetir o passado.

## Escolha A — Arquivar as duas versões sem síntese

### Tom cuidadoso
> "Duas versões. Nenhuma legenda fechando a diferença."

### Tom institucional
> "Arquiva separado, com a mesma referência de data."

### Tom solidário
> "Vocês não precisam concordar para a noite ter valor."

### Resposta de Dalva
Aprecia não virar enigma resolvido.

### Resposta de Rui
Aceita que sua versão sobreviva sem ser coroada como principal.

### Callback
O arquivo pode virar referência em Ato IV quando o jogo discutir quem controla enquadramentos de memória.

## Escolha B — Pedir que os dois recontem a noite juntos

### Tom solidário
> "Não para corrigir. Só para ouvir o que acontece quando vocês lembram juntos."

### Tom pragmático
> "Conversa nova, registro novo. Sem promessa de resolver a antiga."

### Tom provocador
> "Se a melhor entrevista nunca aconteceu, talvez a continuação não precise ser entrevista."

### Resposta de Rui
Gosta do potencial narrativo.

### Resposta de Dalva
Aceita somente se gravação não for condição.

### Callback
Uma futura cena pode referir a nova conversa, mas nunca produzir uma gravação completa da noite de `T-4`.

## Escolha C — Deixar a história sem nova tentativa

### Tom cuidadoso
> "Nem toda lacuna precisa ser aberta de novo."

### Tom pragmático
> "Já existe material suficiente para registrar que vocês lembram diferente."

### Tom provocador
> "Talvez insistir agora só produza uma versão mais ensaiada."

### Resposta de Dalva
Valoriza o limite.

### Resposta de Rui
Transforma a própria ausência em observação narrativa, sem acusar o jogador.

### Callback
Rui pode mais tarde reconhecer que algumas histórias ficam melhores documentadas quando ninguém tenta concluí-las.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- que a lata da noite era comprovadamente original;
- que Dalva ocultou uma revelação;
- que Rui sabe o que ela "realmente quis dizer";
- que existe gravação completa da conversa de `T-4`.

---

# Callbacks cruzados sugeridos

Estes callbacks são opcionais e não criam dependências obrigatórias entre eventos.

## Memória vs. prioridade

Se o jogador escolheu preservar versões paralelas em `event_dalva_lucia_primeiro_depoimento`, Lúcia pode usar linguagem semelhante em `event_rui_lucia_quatro_marcas`.

Objetivo: dar sensação de continuidade de postura, não premiar uma moral.

## Processo vs. capacidade

Se o jogador escolheu a trilha de capacidade em `event_maya_joana_porta_estreita`, Joana pode mais tarde desafiar instituições que usam "piloto" como permanência.

Objetivo: tornar escolhas institucionais memoráveis sem converter o jogo em simulação regulatória real.

## Circulação vs. ruído

Se o jogador encaminhou a foto de Nando ao Arquivo da Maré, Rui pode receber novas fontes e também falsas confirmações.

Objetivo: mostrar que circulação produz informação e ruído ao mesmo tempo.

## Contexto vs. autoria

Se o jogador pediu uma nota pública a Rui no evento do Cedro, Rui pode lembrar essa postura na disputa das quatro marcas.

Objetivo: conectar enquadramento editorial à disputa de crédito sem dizer que uma prática resolve a outra.

## Limite vs. curiosidade

Se o jogador deixou a entrevista Dalva/Rui em aberto, Dalva pode confiar mais em perguntas futuras que aceitem resposta incompleta.

Objetivo: dar consequência relacional sem transformar silêncio em moeda mecânica automática.

---

# Guardrails de implementação futura

Quando estas beat sheets forem convertidas para Resources/event data:

1. armazenar texto por IDs estáveis, sem hardcode em serviços de campanha;
2. separar texto exibido de `lore_flags`, sinais sistêmicos e relações;
3. permitir variantes de abertura/callback sem duplicar o evento inteiro;
4. manter `choice_*` como registro da postura do jogador, nunca como prova histórica;
5. nenhuma escolha deve eliminar permanentemente personagem central do Ato II;
6. nenhuma escolha deve resolver autoria do Caderno, origem conjunta das marcas, procedência da lata da Onda ou identidade da Mulher da Lata;
7. tradução futura deve preservar a distinção entre "não confirmado", "rumor", "disputa" e "prova";
8. o supernatural permanece inconclusivo;
9. cultivo e mercado paralelo continuam abstratos e não operacionais;
10. política institucional continua ficcional e sistêmica.

# Status canônico

Esta wave **não altera fatos históricos da ficção**. Ela materializa voz, subtexto e opções de resposta para eventos já canônicos.

- **CÂNONE adicionado:** as seis cenas agora possuem intenção dramática, subtexto e guardrails de diálogo definidos.
- **RUMOR preservado:** Nando pode ter visto uma página; nenhuma fala confirma.
- **ABERTO preservado:** ordem inicial das marcas, prioridade Rui/Lúcia, interpretação da noite Dalva/Rui e demais lacunas continuam sem resolução.
