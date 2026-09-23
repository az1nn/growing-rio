# LORE HANDOFF — DA LATA

## Verified repository
- Repository: `az1nn/growing-rio`
- Default branch: `master`
- Verified merged lore commit: `ac4723b761e842049648cc898213d650d2c0f796`
- Ato III dialogue PR: **#24 — MERGED**
- Validated PR #24 head: `cafbef486e41c0d0ac34e8e65239e31a4107e62a`
- PR #24 gate: `Validate project` **run #112 / 35861815845 — SUCCESS**
- PR #24 merge commit: `ac4723b761e842049648cc898213d650d2c0f796`
- Active lore PR: **none**
- Lore skill: `.agents/skills/lore/SKILL.md`

## Route
**LORE-ADVANCE**

The Ato III dialogue-beat-sheet wave is complete, validated on its exact head and merged into live `master`. The branch was reconciled against concurrent repository progress before PR creation, so the merged lore wave was based on the then-current technical state rather than on the older handoff snapshot.

## Completed this wave
- Added `docs/lore/ACT-III-DIALOGUE-BEAT-SHEETS.md`.
- Expanded all six canonical Ato III event contracts into dialogue-ready narrative sheets:
  - `event_bento_fita_farol`;
  - `event_falso_original`;
  - `event_helena_nome_em_contrato`;
  - `event_nando_sem_dono_sem_escala`;
  - `event_maya_prateleira_sem_improviso`;
  - `event_caio_regra_que_mudou`.
- Defined scene objectives, openings and character subtext.
- Added 2–3 player response tones for each existing choice without declaring a morally correct route.
- Added optional Ato II -> Ato III and Ato III -> Ato III consequence echoes.
- Added explicit "must remain unsaid" constraints protecting `RUMOR` and `ABERTO`.
- Added localization/data-driven implementation guardrails.
- Added Council-transition dialogue guidance without making the invitation depend on one privileged moral answer.
- Indexed the new document from `docs/lore/README.md`.
- Audited every `choice_*` callback reference against canonical event-library flags.
- Corrected inferred callback names before merge so the final document references only established flags.
- Validated exact PR #24 head successfully and merged the wave.

## Canon delta

### Added
- **CÂNONE:** the six established Ato III events now have stable dialogue-level scene contracts: dramatic objective, opening shape, participant subtext, response-tone families, consequence echoes and speech guardrails.
- **CÂNONE:** character voice at these beats is constrained so no NPC becomes the game's moral narrator.
- **CÂNONE:** Council-transition dialogue may reflect how the player handled institutional ambiguity, but the invitation itself is not a reward for one politically or morally preferred answer.
- Stable dialogue/localization guidance now exists for future data-driven materialization.

### Revised
- No established historical fact or protected mystery was intentionally replaced.
- `docs/lore/README.md` now indexes `ACT-III-DIALOGUE-BEAT-SHEETS.md`.
- Cross-act callback references were reconciled to canonical flags already defined by the event libraries:
  - `choice_four_marks_parallel_discovery`;
  - `choice_four_marks_publish_dispute`;
  - `choice_non_interview_leave_open`;
  - `choice_rui_cedro_context_without_veto`.
- The lore branch was rebased/reconciled onto live `master` before PR creation after concurrent technical work advanced the repository.

### Preserved open
- Exact date of the Fita do Farol.
- Identity of the voice on the Fita do Farol.
- Whether the tape predates public circulation of the Caderno de Sal.
- Relationship between the tape and the Caderno.
- Historical order/common origin of Onda, Sol, Ferrugem and Estrela.
- Authorship/composition of the Caderno de Sal.
- Historical authenticity of any specific item marketed as “original”.
- Provenance/date of the Onda-marked can delivered by Dalva.
- Supernatural status and stable identity of the Mulher da Lata.
- Continuous historical lineage between the real 1987 episode and the fictional DA LATA reconstruction remains explicitly unproven.
- Final institutional form of DA LATA remains reserved for later campaign resolution.

## Continuity checks
- Characters: **CONSISTENT** — Bento, Lúcia, Rui, Helena, Nando, Maya, Joana and Caio retain established motives and contradictions; nobody is converted into a moral arbiter.
- Factions: **CONSISTENT** — Consórcio, Casa Clara, Rede Paralela, Aurora, Raiz do Cedro and AVM keep visible benefits, costs and internal tensions.
- Districts: **CONSISTENT** — Orla da Vigia, Arco Norte, Mercado da Madrugada and Morro do Cedro retain their established narrative functions.
- Campaign: **CONSISTENT** — the six dialogue sheets remain inside `arc_dois_mercados`; the Fita escalates the mystery, the market manufactures memory in real time, and the Council invitation remains the act transition.
- Chronology: **CONSISTENT** — no dialogue establishes a date or priority that the evidence does not support.
- Historical boundary: **CONSISTENT** — no fictional dialogue authenticates a continuous 1987 lineage or inserts fictional actors into the real historical episode.
- Implemented narrative data: **NO LORE DRIFT OBSERVED** — concurrent technical narrative-presentation work had already landed on `master` before this lore branch was reconciled. PR #24 changed only lore documentation/indexing and did not mutate UI, Resources, save state, gameplay or campaign logic.
- Callback flags: **CONSISTENT** — final referenced `choice_*` identifiers were checked against canonical event-library definitions before merge.

## Active gate
- **None for this lore wave.**
- PR #24 exact-head `cafbef486e41c0d0ac34e8e65239e31a4107e62a` passed `Validate project` run #112.
- PR #24 merged as `ac4723b761e842049648cc898213d650d2c0f796`.
- Live repository state still overrides this handoff if subsequent work appears.

## Next lore action
1. Reconcile live `master`, this handoff and any newer lore work.
2. If no newer lore wave supersedes this state, keep **LORE-ADVANCE**.
3. Create the first **Ato IV — O Sistema narrative-event library**, decomposing the macro campaign into event-level contracts rather than dialogue sheets first.
4. The wave should cover the smallest coherent Ato IV narrative set required by existing canon, including:
   - the **Ferrugem** document-lot conflict, where material may be authentic, recent or undatable;
   - the **Audiência** as a fictional systemic confrontation among already-established factions, without real politicians, parties or targeted persuasion;
   - Isa Valente's introduction only to the extent already supported by canon;
   - consequence echoes from Ato III without treating prior choices as moral correctness;
   - the transition from “which version is true?” toward “who gets to shape what is remembered?”.
5. Preserve mixed evidence states and do not authenticate the Caderno, the four-mark chronology, the historical “original” or any continuous lineage.
6. Keep the Ato IV wave narrative-only under standalone `lore`; Resource/UI/system implementation belongs to SIGA.

## Boundaries
- `lore` advances only narrative/lore work.
- Cultivation remains abstract and non-instructional.
- Parallel-market activity remains abstract and non-operational.
- Institutional politics remains fictional and systemic.
- No real politicians, parties, elections or targeted political persuasion.
- No ending, faction or institutional response is labelled morally correct.
- Real history remains separated from fictional canon.
- Chat/model memory is never canonical lore state.
- Persistent continuation state belongs only in this repository.
