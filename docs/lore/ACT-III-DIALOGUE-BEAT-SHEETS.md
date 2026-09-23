# DA LATA — Ato III Dialogue Beat Sheets

Este documento transforma os seis eventos canônicos de `ACT-III-NARRATIVE-EVENT-LIBRARY.md` em beat sheets de diálogo para futura materialização data-driven.

## Escopo desta wave

- preservar integralmente os estados `CÂNONE`, `RUMOR` e `ABERTO` do Ato III;
- dar voz própria a Bento, Lúcia, Rui, Helena, Nando, Maya, Joana e Caio sem transformá-los em árbitros morais;
- oferecer 2–3 tons de resposta do jogador por escolha já definida;
- preparar callbacks de Ato II sem convertê-los em prova histórica;
- registrar explicitamente o que não pode ser dito;
- manter contratos, mercado paralelo e instituições em nível ficcional e abstrato;
- não implementar UI, Resources, save, balanceamento ou lógica de campanha.

## Convenções

### Voz do jogador

O protagonista continua aberto. As falas expressam postura, não biografia fixa.

Tons recorrentes:

- **Pragmático** — resolve custo imediato e explicita trade-off.
- **Cuidadoso** — preserva evidência, relação ou incerteza.
- **Provocador** — pressiona contradição sem virar caricatura.
- **Solidário** — reconhece pessoas e contexto sem canonizar uma posição moral.
- **Institucional** — privilegia registro, regra e legibilidade.
- **Empresarial** — fala em escala, previsibilidade e controle sem implicar superioridade ética.

Nenhum tom é “correto”.

### Regra de callbacks

Callbacks podem mudar:

- abertura;
- confiança;
- ironia;
- intensidade;
- linhas opcionais;
- forma de apresentar custo ou risco.

Callbacks nunca mudam o passado nem convertem `choice_*` em evidência sobre o Caderno de Sal, a Fita do Farol, as quatro marcas ou qualquer “original”.

---

# 1. A Fita do Farol

**ID:** `event_bento_fita_farol`  
**Eixos:** memória + pesquisa + reputação + risco.

## Objetivo da cena

Fazer o jogador decidir como uma evidência incompleta entra em circulação sem permitir que a cena resolva data, voz ou prioridade histórica.

## Abertura

Bento deixa a fita sobre a mesa antes de colocar o áudio.

Bento:
> "Escuta primeiro. Depois inventa teoria."

O trecho chia, oscila e finalmente entrega quatro palavras com clareza suficiente:

> "Onda. Sol. Ferrugem. Estrela."

Rui interrompe o silêncio:

> "Se isso sair hoje, amanhã aparece metade da cidade lembrando que já ouviu."

Lúcia:
> "E metade dessas lembranças vai nascer amanhã."

Bento olha para o jogador:

> "Então decide o que a gente faz com uma coisa que existe, mas ainda não sabe quem é."

## Subtexto

### Bento
- quer reconhecer a voz, mas não quer perder o controle da fita original;
- teme que exposição transforme herança privada em propriedade narrativa alheia;
- não pretende usar a fita como certificado de verdade.

### Lúcia
- aceita que o conteúdo audível é evidência;
- recusa confundir conteúdo com cronologia ou autoria;
- observa se o jogador consegue circular incerteza sem apagá-la.

### Rui
- vê valor em abrir a investigação para a cidade;
- sabe que circulação produz fonte e ruído ao mesmo tempo;
- teme que cautela institucional demais enterre material relevante.

## Escolha A — Aurora primeiro

### Tom institucional
> "Copia, documenta e deixa a original com o Bento. Depois a gente fala em público."

### Tom cuidadoso
> "Se a fita vai sobreviver à história, primeiro ela precisa sobreviver à pressa."

### Tom pragmático
> "Dá uma janela curta pro Aurora. Sem virar gaveta permanente."

### Respostas
- **Lúcia:** aprova o procedimento e exige que a cópia receba a etiqueta “data não verificada”.
- **Bento:** concorda quando fica explícito que o original não muda de custódia.
- **Rui:** aceita, mas avisa que uma janela curta precisa ser realmente curta para não matar possíveis fontes.

### Callback de Ato II
Se `choice_four_marks_parallel_discovery` existir, Lúcia pode dizer:
> "Você já preferiu registrar uma disputa a fabricar uma fila. Faz a mesma coisa com a data."

## Escolha B — Publicar com a incerteza no mesmo destaque

### Tom provocador
> "Se a dúvida ficar escondida na legenda, não publica. Se ela estiver no título, publica."

### Tom pragmático
> "Solta um trecho. A chamada precisa dizer o que a fita prova e o que ela não prova."

### Tom solidário
> "A cidade pode reconhecer a voz. Só não pode receber a pergunta como se fosse resposta."

### Respostas
- **Rui:** ganha energia com a abertura da investigação.
- **Lúcia:** aceita se nenhuma reprodução remover a incerteza.
- **Bento:** demonstra esperança e desconforto ao mesmo tempo.

### Callback de Ato II
Se `choice_four_marks_publish_dispute` existir, Rui pode dizer:
> "Você já sabe publicar uma dúvida sem maquiar como conclusão."

## Escolha C — Esperar uma segunda fonte

### Tom cuidadoso
> "A fita já mudou as perguntas. Não precisa mudar a manchete hoje."

### Tom institucional
> "Registra, preserva e espera uma fonte independente."

### Tom pragmático
> "Segura agora. Se outra peça aparecer, a gente reabre."

### Respostas
- **Bento:** vê respeito pelo limite.
- **Lúcia:** considera a escolha metodologicamente defensável.
- **Rui:** lembra que algumas fontes só se apresentam depois da circulação pública.

### Callback de Ato II
Se `choice_non_interview_leave_open` existir, Rui pode dizer:
> "Você realmente tem talento para deixar uma lacuna respirar."

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- "a fita é anterior ao Caderno";
- "essa é a voz de M.V.";
- "Bento herdou a prova definitiva";
- "as quatro marcas nasceram juntas";
- "Lúcia autenticou a cronologia";
- qualquer parâmetro real de cultivo.

---

# 2. O “Original”

**ID:** `event_falso_original`  
**Eixos:** memória + reputação + legitimidade + mercado.

## Objetivo da cena

Mostrar que uma alegação comercial pode virar fato cultural contemporâneo sem adquirir autenticidade histórica.

## Abertura

Uma foto da vitrine já está em todos os lugares antes de Lúcia chegar.

No vidro, em letras grandes:

> "O ORIGINAL DE 1987"

Rui:
> "Mesmo se for falso, agora é verdadeiro como acontecimento."

Lúcia:
> "Acontecimento presente. Não evidência passada."

Maya:
> "E até alguém explicar isso, cliente e parceiro vão tratar as duas frases como a mesma coisa."

## Subtexto

### Lúcia
- quer separar objeto, narrativa e procedência;
- não precisa provar fraude material para rejeitar a alegação de linhagem;
- teme que repetição vire falsa autenticação.

### Rui
- se interessa pela velocidade com que o mito cria novos artefatos;
- quer preservar o episódio sem legitimar a propaganda;
- percebe que desmentir também amplifica.

### Maya
- pensa no efeito prático da ambiguidade sobre marca e confiança;
- não quer que “DA LATA” se torne uma palavra comercial definida por quem gritar primeiro;
- busca linguagem pública compreensível.

## Escolha A — Catalogar como artefato contestado

### Tom institucional
> "Registra o anúncio como prova do presente. A alegação histórica fica separada."

### Tom cuidadoso
> "Guarda a peça e guarda a dúvida junto."

### Tom pragmático
> "Isso já virou parte do caso. Só não virou origem."

### Respostas
- **Lúcia:** aprova a separação das camadas.
- **Rui:** gosta de tratar o episódio como memória fabricada em tempo real.
- **Maya:** aceita, mas lembra que arquivo lento não resolve toda confusão pública.

### Callback
Se o jogador catalogou a pista de Nando como não verificada:
> Nando, em linha opcional futura: "Engraçado como procedência vira importante quando a vitrine é bonita."

## Escolha B — Explicar publicamente história, marca e evidência

### Tom institucional
> "História é uma coisa. Marca é outra. Evidência é outra. A gente precisa dizer isso sem coroar ninguém."

### Tom pragmático
> "Corrige a equivalência, não tenta vencer a história."

### Tom provocador
> "Se marketing virou certificado, o problema não é só essa vitrine."

### Respostas
- **Maya:** valoriza a clareza.
- **Lúcia:** apoia a distinção metodológica.
- **Rui:** adverte que um pronunciamento formal demais pode fazer o jogador parecer proprietário do mito.

### Callback
Se `choice_rui_cedro_context_without_veto` existir, Rui pode perguntar:
> "Você quer dar contexto ou quer controlar a legenda da cidade?"

## Escolha C — Não amplificar

### Tom cuidadoso
> "Registra e não alimenta. Nem todo ruído precisa de resposta maior."

### Tom pragmático
> "Se a gente responder em cadeia nacional, a vitrine ganha uma campanha grátis."

### Tom provocador
> "Talvez o anúncio esteja esperando exatamente a nossa indignação."

### Respostas
- **Rui:** entende e destaca o custo narrativo do silêncio.
- **Lúcia:** aceita se houver preservação documental.
- **Maya:** lembra que a ambiguidade comercial seguirá circulando.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- que o item é comprovadamente falso;
- que o item é comprovadamente autêntico;
- que existe linhagem contínua desde 1987;
- que o jogador pode autenticar “a genética original”;
- que a marca pertence historicamente ao jogador.

---

# 3. Nome em Contrato

**ID:** `event_helena_nome_em_contrato`  
**Eixos:** dinheiro + identidade + escala + legitimidade.

## Objetivo da cena

Fazer o jogador negociar escala e controle narrativo sem transformar capital em corrupção automática nem autonomia em pureza automática.

## Abertura

Helena projeta duas páginas.

A primeira fala de expansão.

A segunda fala de uso de nome, símbolos e narrativa.

Helena:
> "A primeira página paga a conta. A segunda impede que outra pessoa escreva a história enquanto você está pagando a conta."

Se Maya estiver presente:
> "Também pode impedir você de reescrever quando descobrir que errou."

Se Joana estiver presente:
> "Ou pode transformar a cidade em cláusula."

Helena:
> "Pode. Por isso existe negociação."

## Subtexto

### Helena
- acredita que identidade sem governança será capturada por alguém;
- prefere regras explícitas a uma disputa informal de poder;
- respeita contraproposta mais do que recusa performática.

### Maya
- enxerga a vantagem de escala e previsibilidade;
- teme que identidade fixa cedo demais vire dívida futura;
- quer separar operação de reivindicação histórica.

### Joana
- teme extração cultural sem reciprocidade;
- não exige veto total;
- quer mecanismos narrativos que reconheçam origem e contestação.

## Escolha A — Piloto com limites narrativos

### Tom empresarial
> "Escala pode entrar. Autenticidade histórica não entra no pacote."

### Tom institucional
> "O piloto precisa dizer por escrito o que a marca não está reivindicando."

### Tom pragmático
> "Testa distribuição. Não testa propriedade sobre memória."

### Respostas
- **Helena:** considera uma contraproposta séria.
- **Maya:** vê uma ponte viável.
- **Joana:** se presente, pergunta como o limite será verificado quando a campanha crescer.

### Callback
Se o jogador já separou história/marketing no falso original, Helena pode dizer:
> "Você já decidiu que narrativa comercial não é certificado. Então põe isso na arquitetura do acordo."

## Escolha B — Atribuição compartilhada

### Tom solidário
> "Se a história gera valor, a memória não pode aparecer sem quem a sustenta."

### Tom institucional
> "Uso ampliado exige atribuição plural e espaço para contestação."

### Tom empresarial
> "Mais centros de decisão custam velocidade. Ainda assim, podem reduzir risco de captura."

### Respostas
- **Helena:** aceita a lógica, critica a eficiência.
- **Joana:** valoriza reciprocidade, sem declarar solução perfeita.
- **Maya:** lembra que governança distribuída também pode paralisar.

### Callback
Se o jogador apoiou uma trilha conjunta Maya/Joana no Ato II, Joana pode dizer:
> "Você já viu o trabalho que dá transformar participação em estrutura. Não vende isso como detalhe."

## Escolha C — Recusar exclusividade

### Tom pragmático
> "Eu prefiro perder escala a fingir que posso fechar uma história que ainda está aberta."

### Tom empresarial
> "Sem exclusividade. Se isso reduz o valuation da parceria, a gente precifica o custo."

### Tom provocador
> "Organizar não precisa significar cercar."

### Respostas
- **Helena:** registra o custo econômico sem insultar a escolha.
- **Maya:** questiona sustentabilidade.
- **Nando:** em callback futuro, pode reconhecer coerência sem tratar a decisão como aliança automática.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- que Helena quer roubar a história da cidade;
- que aceitar capital torna o jogador corrupto;
- que rejeitar exclusividade torna o jogador moralmente superior;
- que qualquer contrato ficcional equivale a aconselhamento jurídico real;
- que o jogador possui autenticidade histórica de DA LATA.

---

# 4. Sem Dono, Sem Escala

**ID:** `event_nando_sem_dono_sem_escala`  
**Eixos:** autonomia + escala + risco + comunidade.

## Objetivo da cena

Dramatizar o custo de coordenação em uma rede descentralizada sem oferecer estrutura operacional do mercado paralelo.

## Abertura

Nando coloca um folheto dobrado na mesa, sem marcas de empresa reconhecível.

Nando:
> "Todo mundo quer juntar as pontas quando descobre que ponta separada não dá gráfico bonito."

Rui, se presente:
> "E gráfico bonito costuma conseguir dinheiro."

Nando:
> "Esse é o argumento deles."

O jogador:
> "E o seu?"

Nando:
> "Se todo mundo passa a responder pelo mesmo nome, quem responde pelo nome começa a mandar."

## Subtexto

### Nando
- teme que coordenação temporária vire autoridade permanente;
- sabe que fragmentação cobra preço em previsibilidade;
- não quer romantizar precariedade.

### Rui
- acha fascinante uma identidade coletiva que resiste a virar instituição;
- percebe o paradoxo de comunicar uma marca sem produzir dono;
- não deve mapear ou explicar logística da rede.

## Escolha A — Manter independência

### Tom solidário
> "Se a relação só funciona sem centro, não inventa um centro para parecer profissional."

### Tom pragmático
> "Menos previsível, mais independente. Assume o custo."

### Tom provocador
> "Escala que exige um dono talvez esteja vendendo outra coisa."

### Respostas
- **Nando:** ganha confiança.
- **Maya:** em callback, pode apontar baixa previsibilidade sem deslegitimar Nando.

## Escolha B — Identidade temporária sem autoridade central

### Tom pragmático
> "Coordena o nome para um objetivo e dá data de validade ao arranjo."

### Tom institucional
> "Sem porta-voz permanente, sem autoridade presumida, sem transformar exceção em estrutura."

### Tom provocador
> "Marca que tem medo de virar instituição precisa provar que sabe acabar."

### Respostas
- **Nando:** aceita testar, desconfiado.
- **Rui:** chama a ideia de “marca com botão de autodestruição”, sem descrevê-la operacionalmente.

### Callback
Se o jogador usou piloto no evento Maya/Joana:
> Nando: "Você gosta de piloto. O difícil é lembrar de pousar."

## Escolha C — Reduzir dependência

### Tom empresarial
> "Crescer também é escolher quais dependências eu não quero aprofundar."

### Tom pragmático
> "Mantém a relação. Tira o circuito do centro da operação."

### Tom cuidadoso
> "Não preciso transformar toda porta aberta em caminho principal."

### Respostas
- **Nando:** respeita clareza e lembra que formalização também cria dependência.
- **Maya:** em callback, valoriza previsibilidade sem transformar Nando em adversário.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- rotas, pontos, fornecedores, ocultação, evasão ou sourcing;
- liderança central canônica da Rede Paralela;
- que Nando ensina o jogador a operar ilicitamente;
- que o mercado formal ou paralelo é moralmente superior;
- que escolher um lado elimina o outro da cidade.

---

# 5. Prateleira Sem Improviso

**ID:** `event_maya_prateleira_sem_improviso`  
**Eixos:** reputação + identidade + escala + comunidade.

## Objetivo da cena

Fazer o jogador decidir quanto contexto sobrevive à padronização necessária para escalar.

## Abertura

Maya abre uma apresentação de campanha e passa rápido demais pelos primeiros slides.

Joana, se presente, pede para voltar.

Na tela:

> "Do Cedro para a cidade: uma origem autêntica."

Joana:
> "Autêntica para quem?"

Maya:
> "Foi exatamente por isso que eu não aprovei."

Ela muda para outra versão:

> "Improviso que virou excelência."

Maya fecha o notebook.

> "E essa conseguiu ser pior."

## Subtexto

### Maya
- sabe que linguagem simples ajuda escala;
- recusa transformar contradição em slogan perfeito;
- teme que complexidade demais torne a marca indecifrável.

### Joana
- aceita visibilidade do Cedro, mas não como cenário;
- quer reciprocidade e capacidade de contestação;
- não quer transformar a origem comunitária em selo obrigatório.

## Escolha A — Padronizar o comercial, arquivar o contexto

### Tom pragmático
> "Padroniza promessa de compra. Não padroniza a memória para caber na embalagem."

### Tom institucional
> "Separa comunicação comercial de arquivo narrativo, mas mantém ponte explícita entre os dois."

### Tom cuidadoso
> "Arquivo separado só funciona se não virar porão."

### Respostas
- **Maya:** vê solução praticável.
- **Joana:** se presente, exige que o contexto continue acessível e contestável.

### Callback
Se o jogador catalogou o falso original:
> Maya: "Você já separou artefato de alegação. Aqui é parecido: produto de história."

## Escolha B — Cedro visível na expansão

### Tom solidário
> "Se o crescimento usa a origem, a origem precisa aparecer como relação, não decoração."

### Tom pragmático
> "Conta de onde veio e deixa claro o que mudou desde então."

### Tom provocador
> "Se a campanha precisa apagar contradição para funcionar, talvez a campanha esteja errada."

### Respostas
- **Joana:** valoriza visibilidade com possibilidade de contestação.
- **Maya:** aceita desde que a narrativa não vire promessa operacional impossível.

### Callback
Se `choice_rui_cedro_context_without_veto` existir:
> Joana: "Contexto não é rodapé. Você já aprendeu isso uma vez."

## Escolha C — Expansão menor

### Tom empresarial
> "Eu prefiro uma promessa menor que ainda seja verdadeira."

### Tom cuidadoso
> "Se o tamanho exige uma versão de nós que eu não reconheço, reduz o tamanho."

### Tom pragmático
> "Cresce menos agora e mantém margem para mudar depois."

### Respostas
- **Maya:** considera coerente, mas comercialmente limitado.
- **Helena:** em callback futuro, pode chamar de capacidade ociosa, não de erro moral.

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- que Casa Clara é o caminho correto;
- que origem comunitária dá autoridade absoluta sobre toda narrativa;
- parâmetros reais de produção ou compliance;
- que reduzir escala é moralmente superior;
- que representar o Cedro autentica qualquer alegação sobre 1987.

---

# 6. A Regra que Mudou sem Mudar

**ID:** `event_caio_regra_que_mudou`  
**Eixos:** legitimidade + dinheiro + adaptação + institucionalização.

## Objetivo da cena

Mostrar como interpretação institucional produz custo e incerteza sem transformar burocracia em vilão nem participação em controle político.

## Abertura

Caio coloca duas versões impressas da mesma orientação lado a lado.

Caio:
> "Oficialmente, nada mudou."

Maya, se presente:
> "Então por que todo mundo está recalculando prazo?"

Caio:
> "Porque esclarecer uma frase também muda o que as pessoas acham que a frase exige."

Helena, se presente:
> "Essa é uma maneira elegante de dizer que mudou."

Caio:
> "É uma maneira precisa de dizer que o texto não mudou."

## Subtexto

### Caio
- quer previsibilidade sem fingir que norma é perfeitamente coerente;
- sabe que operadores maiores absorvem ambiguidade melhor;
- não quer virar atalho pessoal para decisão institucional.

### Maya
- teme inconsistência entre operadores e parceiros;
- quer clareza que possa ser repetida;
- percebe custo desigual de adaptação.

### Helena
- privilegia previsibilidade mesmo quando custa dinheiro;
- vê incerteza regulatória como custo de escala;
- não deve aparecer como voz moral oficial.

### Joana
- se presente, destaca como interpretação opaca favorece quem possui mais capacidade;
- não exige resultado específico do processo.

## Escolha A — Adaptar cedo

### Tom empresarial
> "Se a leitura nova pode virar padrão, eu compro previsibilidade agora."

### Tom institucional
> "Adapta com registro explícito de que a orientação é interpretação, não nova história."

### Tom pragmático
> "Custa caixa. Compra menos surpresa."

### Respostas
- **Caio:** reconhece responsabilidade sistêmica.
- **Helena:** considera compatível com escala.
- **Joana:** se presente, lembra que nem todos conseguem pagar pelo mesmo grau de cautela.

## Escolha B — Usar a transição

### Tom pragmático
> "Se a janela existe, eu vou usar a janela."

### Tom cuidadoso
> "Não vou fingir certeza antes do próprio sistema fechar a leitura."

### Tom institucional
> "Documenta a decisão e reavalia quando a transição acabar."

### Respostas
- **Caio:** considera a escolha válida dentro do sistema.
- **Maya:** teme fragmentação temporária entre parceiros.

## Escolha C — Pedir esclarecimento público

### Tom institucional
> "Se a contradição afeta muita gente, a resposta precisa ser pública e legível."

### Tom solidário
> "Interpretação não pode depender de quem consegue chegar mais perto da sala certa."

### Tom pragmático
> "Leva a pergunta para o processo. Mesmo que custe tempo."

### Respostas
- **Caio:** valoriza converter conflito privado em regra legível.
- **Helena:** registra o custo de demora.
- **Joana:** se presente, vê redução de assimetria de acesso sem assumir que o resultado será favorável.

### Callback para transição ao Ato IV
Caio pode dizer, perto do convite ao Conselho:
> "Participar não é mandar. É entrar num lugar onde a contradição fica visível para mais gente."

## Linhas que devem permanecer não ditas

Nunca escrever falas que impliquem:

- contato, pressão ou persuasão sobre político real;
- suborno, favor pessoal ou evasão de regra;
- que Caio controla sozinho a AVM;
- que Influence significa domínio sobre pessoas;
- que uma opção é civicamente ou moralmente superior;
- aconselhamento jurídico ou regulatório real.

---

# Callbacks cruzados do Ato III

## Fita → Original

Se a fita foi publicada com incerteza, Rui pode apontar que o falso original imita a linguagem visual das quatro marcas mais rapidamente do que novas evidências aparecem.

Objetivo: mostrar circulação cultural acelerada sem provar causalidade histórica.

## Original → Helena

Se o jogador explicou publicamente a diferença entre história, marca e evidência, Helena pode enquadrar sua proposta como tentativa de impedir que terceiros capturem essa ambiguidade.

Objetivo: tornar a oferta racional sem legitimá-la automaticamente.

## Maya → Helena

Se o jogador reduziu a expansão da Casa Clara, Helena pode argumentar que o Consórcio oferece infraestrutura para absorver complexidade; Maya pode responder que infraestrutura também impõe enquadramento.

Objetivo: conectar escala a identidade sem criar vencedor.

## Nando → Helena

Se o jogador preservou relações independentes, Nando pode reagir à proposta de exclusividade com:
> "Você já sabe o que acontece quando um nome começa a querer dono."

Isso é comentário relacional, não instrução operacional.

## Caio → Conselho

Qualquer escolha no evento de Caio pode mudar a formulação do convite ao Conselho:

- adaptação cedo → reconhecimento de capacidade de absorver regras;
- transição → reconhecimento de leitura estratégica de sistema;
- esclarecimento público → reconhecimento de participação institucional.

Nenhuma variante implica que o jogador foi convidado por ter feito a escolha “correta”.

---

# Guardrails de localização e implementação futura

Quando estas beat sheets forem materializadas:

1. usar IDs de texto estáveis por evento, beat e tom;
2. separar texto exibido de flags, relações e sinais sistêmicos;
3. manter `choice_*` como postura/consequência, nunca como prova histórica;
4. variantes de callback devem ser opcionais e não bloquear o evento-base;
5. preservar distinções semânticas entre “prova”, “alegação”, “rumor”, “registro”, “interpretação” e “não verificado”;
6. não traduzir “original” de forma que implique autenticação técnica;
7. a Fita do Farol sempre deve manter data e voz não verificadas;
8. nenhum texto deve exigir conhecimento operacional de cultivo ou mercado paralelo;
9. instituições permanecem ficcionais e sistêmicas;
10. nenhum diálogo deve mencionar políticos, partidos ou órgãos reais;
11. falas do jogador devem permanecer curtas o suficiente para interfaces de escolha;
12. respostas de NPC podem variar por relação, mas não por retcon de fatos;
13. o convite ao Conselho deve continuar dependente de progressão de campanha, não de uma resposta moralmente privilegiada.

# Status canônico

Esta wave **não altera os fatos históricos da ficção**. Ela materializa intenção dramática, voz, subtexto, opções de resposta e callbacks para seis eventos já canônicos do Ato III.

- **CÂNONE adicionado:** os seis eventos possuem beat sheets de diálogo e guardrails de fala.
- **RUMOR preservado:** a Fita pode anteceder a circulação pública conhecida do Caderno; itens “originais” podem carregar histórias parciais ou falsas; versões sobre as quatro marcas continuam em disputa.
- **ABERTO preservado:** data e voz da Fita, relação fita/Caderno, ordem/origem das marcas, autoria do Caderno, autenticidade histórica de itens específicos, procedência da lata da Onda e qualquer camada sobrenatural.
