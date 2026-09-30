# CAVEMAN — LENTE baseline 2026-09-30

**ORIGEM:** PR #184, checkout `804ec60747783bc4ea46233799ef3549d9d1348d`. Primeiro artefato `11071629916` (workflow `36654219243`; SHA-256 do ZIP: `c05ed5f46267253e3df16f40f794a2b95028376d7c1c12c4cea993055324dcf1`).

**ESTADO:** baseline histórica inspecionada. O run antigo tinha 22 PNG de página + 22 PNG de cena isolada + 11 WebM. A primeira implementação dos vídeos inclui o splash de carregamento, e os metadados antigos usam o SHA sintético de merge do PR; portanto, vídeos/metadados antigos não servem para aceite de movimento nem comparação de head sem reconciliação. A captura corrigida precisa passar de novo.

## O QUE VI

- **Desfecho:** a cena isolada mostra o tableau 3D com muito mais presença do que sua apresentação dentro da página 540×960, onde ele disputa espaço com o plano de fundo escurecido de Operação.
- **Cidade:** a cidade isolada é reconhecível como diorama low-poly, mas prédios de peso/forma próximos disputam a hierarquia da composição; a interface da página também compete pela atenção.
- **Operação:** a sala 3D aparece claramente isolada; na página completa, ações e texto translúcidos podem reduzir a leitura da bancada e do vaso.
- **Vídeos:** o pacote original gravava a tela de carregamento antes do conteúdo. O novo pipeline grava apenas quadros pós-prontidão; falta validar seus resultados no HEAD final.

## TOP 3 A INVESTIGAR (ainda não são direção de arte aprovada)

1. **SCENE-finale-01 / CENA** — revisar hierarquia e tamanho do tableau no Desfecho, mantendo controles, acessibilidade e escolhas finais. Ponto de partida: [issue #185](https://github.com/az1nn/growing-rio/issues/185).
2. **SCENE-city-01 / CENA** — experimentar foco ou hierarquia perto/meio/longe sem descaracterizar a linguagem Rio low-poly; comparar dois tamanhos retrato.
3. **SCENE-operation-01 / CENA** — experimentar transparência/posição da UI sobre o diorama mantendo todos os controles clicáveis e a semântica do jogo.

## FAZER AGORA

1. **CONCLUIR LENTE:** receber os vídeos em quatro segundos úteis, 11 posters iniciais, metadata de head exato, relatório da versão, indexação persistente em `lente-history`.
2. **DECIDIR CENA:** confirmar/revisar/rejeitar a hipótese `SCENE-finale-01` comparando página e cena isolada nos dois tamanhos.
3. **PRODUZIR TESTE:** implementar no menor escopo autorizado, repetir LENTE para uma **nova pasta versionada** e registrar antes/depois no novo CAVEMAN.

**NÃO MEXER:** cânone LORE, escolhas do final, saves, comportamento do jogo e contratos de hotspots 3D da Feature 011. Uma hipótese do LENTE não equivale a aceite do CENA.
