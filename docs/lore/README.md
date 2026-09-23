# DA LATA — Lore Index

Esta pasta é a fonte canônica de narrativa do jogo.

## Palavra mágica: `lore`

O comando standalone `lore` ativa a skill repo-local:

`.agents/skills/lore/SKILL.md`

Ela usa o protocolo VERIFY-FIRST inspirado no SIGA, mas restringe toda continuação a trabalho narrativo.

Fluxo:

```text
RECONCILE -> DECIDE -> EXECUTE -> PERSIST
```

Rotas:

```text
LORE-RESUME
LORE-WATCH
LORE-ADVANCE
LORE-BLOCKED
```

O estado persistente de continuação fica em:

`docs/lore/LORE-HANDOFF.md`

Chat/model memory nunca substitui o estado canônico do repositório.

## Regra de cânone

A lore usa três estados:

- **CÂNONE** — pode orientar implementação, diálogo, eventos, arte e progressão.
- **RUMOR** — existe dentro do mundo, mas pode ser falso, exagerado ou contraditório.
- **ABERTO** — espaço deliberadamente não resolvido para futuras versões.

Quando um sistema do jogo conflitar com a lore, a mudança deve ser consciente: ou o sistema é ajustado, ou o documento de lore é atualizado no mesmo PR.

## Documentos

- [LORE-BIBLE.md](./LORE-BIBLE.md) — mundo, temas, mito central e regras narrativas.
- [CHRONOLOGY.md](./CHRONOLOGY.md) — linha temporal histórica/diegética até a abertura do Ato I.
- [FACTIONS.md](./FACTIONS.md) — grupos econômicos, comunitários, institucionais e culturais.
- [CHARACTERS.md](./CHARACTERS.md) — elenco recorrente e suas tensões.
- [CHARACTER-RELATIONSHIPS.md](./CHARACTER-RELATIONSHIPS.md) — história relacional canônica antes de `T0`.
- [DISTRICTS.md](./DISTRICTS.md) — geografia ficcionalizada da Cidade do Rio.
- [CAMPAIGN.md](./CAMPAIGN.md) — arcos dos cinco atos e finais.
- [NARRATIVE-EVENT-LIBRARY.md](./NARRATIVE-EVENT-LIBRARY.md) — primeira biblioteca de eventos de Ato I/Ato II derivada das relações pré-T0.
- [DIALOGUE-BEAT-SHEETS.md](./DIALOGUE-BEAT-SHEETS.md) — beat sheets de diálogo, subtexto, tons de resposta e callbacks para os seis eventos canônicos de Ato II.
- [HISTORICAL-INSPIRATION.md](./HISTORICAL-INSPIRATION.md) — separação entre referência histórica real e ficção do jogo.
- [LORE-HANDOFF.md](./LORE-HANDOFF.md) — estado verificável de continuação narrativa.

## Princípios narrativos

1. **Rio reconhecível, não documental.** A Cidade do Rio é uma versão ficcionalizada da cidade real.
2. **Ninguém controla a cidade inteira.** Poder é fragmentado entre mercado, comunidade, instituições, memória e reputação.
3. **Legal e paralelo não significam automaticamente bem e mal.** Ambos têm vantagens, custos e contradições.
4. **A memória é recurso.** Arquivos, relatos, objetos e rumores têm peso narrativo.
5. **DA LATA é mito antes de ser cultivar.** O endgame trata da tentativa de reconstruir uma lenda cultural.
6. **Política é sistêmica e fictícia.** Sem partidos, políticos reais ou persuasão direcionada.
7. **Mercado paralelo é abstrato.** Sem logística, rotas, ocultação, evasão ou instrução operacional real.
8. **Cultivo permanece abstrato.** A narrativa nunca vira manual de cultivo.

## IDs narrativos

Conteúdo futuro deve preferir IDs estáveis para integração com Resources:

- personagem: `char_*`
- facção: `faction_*`
- distrito: `district_*`
- arco: `arc_*`
- evento: `event_*`
- memória/artefato: `memory_*`

Exemplo: `char_dalva`, `faction_aurora`, `district_baia_velha`.

## Tom

Drama econômico + sátira institucional + folclore urbano + realismo mágico discreto.

A Cidade do Rio deve parecer quente, contraditória, musical, burocrática, inventiva e sempre em movimento. A lenda nunca é tratada como verdade simples: cada personagem conhece uma versão diferente.
