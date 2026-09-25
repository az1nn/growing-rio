# RB-14 — Campaign Progression Revalidation Matrix

Date: 2026-09-24

## Reconciled product baseline

RB-14 runs on a dedicated integration branch stacked on RB-13 and semantically includes the still-open RB-09, RB-10 and RB-11 product surfaces. This is required because a progression audit against flags alone would not prove that the player can perform the corresponding actions.

The pre-RB-14 integrated head passed the complete repository suite in Validate project #415 before any campaign gate was changed.

## Gate-to-player-action matrix

| Stage | Canonical gate | Player-facing action | Surface | Existing evidence |
| --- | --- | --- | --- | --- |
| Ato I | `arc_o_quarto` | Complete a cultivation cycle and make the first successful sale | Operação -> Mercado | `campaign_progression_test.gd` |
| Ato II | `arc_o_negocio` | Resolve the first memory event, perform the evidence research chain, resolve the Sol closing beat | Arquivo | `act_iv_evidence_bridge_test.gd`, research presentation regressions |
| Ato III | `campaign_business_scale_reached` + `arc_dois_mercados` | Complete a second sale, receive the council invitation, then perform fictional civic engagement | Mercado -> Institucional | `act_iv_evidence_bridge_test.gd`, RB-09 institutional surface |
| Ato IV | `arc_o_sistema` + `research_material_compatibility_reviewed` | Resolve the Archive narrative chain and complete the material compatibility review | Arquivo | `act_iv_evidence_bridge_test.gd` |
| Ato V opening | reconstruction/city/name flags | Resolve reconstruction, city-contribution and naming events | Arquivo | `act_v_reconstruction_opening_test.gd` |
| Pre-finale | `lore_final_form_debate_seen` | Resolve the final-form debate after the natural Ato V opening | Arquivo | `act_v_final_form_eligibility_test.gd` + RB-14 natural-path regression |
| Selection | `selected_ending_id` | Select one currently eligible ending family | canonical campaign command; finale presentation remains RB-15 | `act_v_ending_selection_test.gd` |

## Save/load boundaries

RB-14 requires one uninterrupted natural route to remain equivalent after round-trips at representative milestones:

1. after Ato I first-sale closure;
2. after Ato III council participation readiness;
3. after Ato IV material-evidence review;
4. at pre-finale eligibility;
5. after ending selection.

The dedicated `campaign_revalidation_test.gd` uses only normal campaign actions to reach these states. It deliberately does not call developer setup helpers such as `set_narrative_flag()` or `complete_narrative_arc()`.

## Specs 005-008 disposition

- Feature 005 / Ato IV evidence bridge: **PASS candidate** — natural market, institutional, narrative and research actions reach its handoff.
- Feature 006 / Ato V reconstruction opening: **PASS candidate** — canonical event chain is naturally reachable from the completed evidence review.
- Feature 007 / final-form eligibility: **PASS candidate** only if natural surfaced play yields at least one eligible ending after the debate.
- Feature 008 / ending selection persistence: **PASS candidate** — selection remains one-time, neutral and schema-v11 persisted; RB-14 verifies it after a naturally reached eligible set.

No gate correction is justified unless the RB-14 natural-path regression fails with a concrete mismatch. RB-15 remains frozen until exact-head evidence turns these candidates into PASS.
