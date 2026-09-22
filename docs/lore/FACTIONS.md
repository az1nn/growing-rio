# DA LATA — Facções

Todas as facções abaixo são ficcionais.

---

## Casa Clara
**ID:** `faction_casa_clara`  
**Tipo:** varejo licenciado

A Casa Clara começou como uma pequena rede de atendimento especializado e se tornou o rosto mais conhecido do mercado formal da Cidade do Rio.

### O que quer
- fornecedores previsíveis;
- qualidade consistente;
- expansão do mercado regulado;
- redução de riscos reputacionais.

### O que oferece ao jogador
- contratos estáveis;
- Reputation;
- Influence;
- redução indireta de Heat;
- acesso a compradores premium em atos posteriores.

### Contradição
A Casa Clara se apresenta como porta de entrada para pequenos produtores, mas seu crescimento a torna cada vez mais corporativa. Quanto maior ela fica, mais difícil é para operadores pequenos atenderem aos seus padrões.

### NPC âncora
`char_maya` — Maya Santiago.

---

## Rede Paralela
**ID:** `faction_rede_paralela`  
**Tipo:** mercado informal descentralizado

Não possui liderança, sede ou estrutura única. É um nome guarda-chuva usado pelo jogo para relações comerciais fora do mercado formal.

### O que quer
- produto escasso;
- rapidez;
- confiança pessoal;
- capacidade de atender picos de demanda.

### O que oferece
- retorno maior;
- acesso a rumores;
- eventos raros;
- Reputation em circuitos informais.

### Custo
- Heat;
- volatilidade;
- contratos que desaparecem;
- reputação negativa com certos atores formais.

### Regra de representação
A Rede Paralela nunca vira simulador de tráfico. Negociações são abstratas, sem rotas, ocultação, segurança operacional ou evasão.

### NPC âncora
`char_nando` — Nando Trama.

---

## Instituto Aurora
**ID:** `faction_aurora`  
**Tipo:** pesquisa privada / arquivo botânico

Instituição respeitada que mantém um acervo de documentação, variedades históricas e registros sensoriais.

### O que quer
- reconstruir a história botânica da cidade;
- controlar a qualidade da pesquisa;
- proteger sua reputação científica;
- obter financiamento.

### O que oferece
- Research;
- acesso à cadeia de DA LATA;
- autenticação de documentos;
- eventos de laboratório abstratos;
- caminhos de preservação.

### Contradição
O Aurora fala em ciência aberta, mas depende de contratos privados e patentes para sobreviver.

### NPC âncora
`char_lucia` — Dra. Lúcia Vilar.

---

## Cooperativa Raiz do Cedro
**ID:** `faction_raiz_cedro`  
**Tipo:** associação comunitária

Nasceu no Morro do Cedro a partir de pequenos produtores, pacientes, comerciantes e moradores que não queriam ser excluídos da nova economia.

### O que quer
- renda local;
- acesso comunitário;
- formação;
- proteção contra deslocamento econômico;
- memória cultural reconhecida.

### O que oferece
- Community;
- mão de obra qualificada em atos posteriores;
- projetos cooperativos;
- acesso a histórias da cidade;
- redução de conflitos locais.

### Contradição
A cooperativa precisa de dinheiro para existir, mas teme virar apenas fornecedora barata para marcas maiores.

### NPC âncora
`char_joana` — Joana Cedro.

---

## Autoridade Verde Municipal
**ID:** `faction_avm`  
**Tipo:** regulador ficcional

Órgão criado às pressas durante o Período Verde. Herdou regras de diferentes secretarias e ainda opera com normas que nem sempre combinam entre si.

### O que quer
- previsibilidade;
- rastreabilidade abstrata;
- redução de crises públicas;
- legitimidade institucional.

### O que oferece
- licenças e tiers de compliance;
- redução estrutural de Heat;
- acesso a fóruns institucionais;
- mudanças sistêmicas na economia.

### Contradição
O órgão precisa regular um mercado que muda mais rápido do que sua burocracia.

### NPC âncora
`char_caio` — Caio Brandão, servidor técnico de carreira.

---

## Consórcio Atlântico
**ID:** `faction_consorcio_atlantico`  
**Tipo:** conglomerado

Grupo com capital suficiente para operar pesquisa, varejo, marketing e distribuição formal em grande escala.

### O que quer
- consolidar mercado;
- adquirir marcas menores;
- registrar propriedade intelectual;
- transformar DA LATA em ativo comercial.

### O que oferece
- dinheiro;
- expansão rápida;
- infraestrutura;
- contratos de grande porte.

### Custo
- autonomia;
- Community;
- controle narrativo sobre a marca do jogador.

### Contradição
O Consórcio não é um vilão secreto. Ele acredita sinceramente que escala, padronização e capital são a única forma de tornar o setor durável.

### NPC âncora
`char_helena` — Helena Prado.

---

## Arquivo da Maré
**ID:** `faction_arquivo_mare`  
**Tipo:** coletivo cultural

Colecionadores, DJs, jornalistas, fotógrafos, vendedores de sebo e pesquisadores independentes que preservam objetos e relatos da Cidade do Rio.

O nome “Maré” aqui se refere ao movimento do mar e da memória; não representa organização real.

### O que quer
- impedir que a memória seja apagada;
- descobrir fraudes;
- publicar acervos;
- manter certas histórias sem dono.

### O que oferece
- pistas do Caderno de Sal;
- memorabilia;
- eventos culturais;
- versões conflitantes da mesma história.

### Contradição
O próprio coletivo lucra com raridade, leilões e prestígio. Preservar e mercantilizar às vezes são a mesma coisa.

### NPC âncora
`char_rui` — Rui Sal.

---

## Conselho Cívico da Baía
**ID:** `faction_conselho_baia`  
**Tipo:** fórum institucional

Espaço público ficcional onde associações, empresas, pesquisadores e comunidades disputam propostas para a economia verde.

Não é parlamento e não representa nenhum órgão real.

### Função no jogo
Transformar `Influence` em decisões sistêmicas:
- custos de compliance;
- incentivos à pesquisa;
- contratos comunitários;
- regras de publicidade;
- preservação cultural.

### Regra narrativa
Nenhuma proposta deve ser escrita como “a opção correta”. Cada uma altera vencedores, perdedores e incentivos do sistema.

### NPC âncora
`char_isa` — Isa Valente, mediadora do conselho.

---

# Relações principais

```text
                    Instituto Aurora
                         /     \
                        /       \
             Arquivo da Maré -- Consórcio Atlântico
                   |              |
                   |              |
Cooperativa Raiz --+-- JOGADOR --+-- Casa Clara
       do Cedro     |              |
                   |              |
             Rede Paralela -- Autoridade Verde
                         \
                          \
                    Conselho da Baía
```

As linhas representam tensão e intercâmbio, não alianças fixas.

# Regra para design sistêmico

Uma facção só deve entrar no jogo quando possuir:
1. recurso que valoriza;
2. benefício mecânico;
3. custo ou trade-off;
4. pelo menos uma contradição interna;
5. pelo menos um personagem que humanize sua posição.
