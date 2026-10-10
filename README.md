Präsentationen
==============

Dieses Repo enthält verschiedene Präsentationen vom [FAU FabLab](https://fablab.fau.de), alle als PDF
mit der Beamer-Vorlage des FAU FabLab (Beispiel: `innovationslabor/innovationslabor.tex`).

| Präsentation | Quelltext |
|---|---|
| Vorstellung für das Innovationslabor (englisch) | `innovationslabor/innovationslabor.tex` |
| Das Kassenterminal des FAU FabLab | `kassenterminal.tex` |
| Kurzvorstellung für Workshops | `kurzvorstellung_fuer_workshops.tex` |
| Vorstellung beim Mathe-Repetitorium | `matherep/matherep.tex` |
| Vorstellung beim MechSys-Praktikum | `mechsys_praktikum/mechsys_praktikum.tex` |
| Vorstellung beim Physik-Projektpraktikum | `physik_projektpraktikum/physik_projektpraktikum.tex` |
| Vorstellung bei der StuZuKo | `stuzuko/stuzuko.tex` |
| Poster „Mitmachen“ (A0) | `poster/poster_mitmachen.tex` |
| Poster „Vorstellung des FAU FabLabs“ (A0) | `poster/poster_vorstellung.tex` |
| Poster „Fabrication Laboratories“ (A0, englisch, DAAD 2019) | `poster/poster_fablabs.tex` |
| Vektorzeichnen mit Inkscape | `vektorzeichnen_mit_inkscape.tex` |

Download
--------

Eine GitHub Action baut die PDFs bei jedem Push. Auf dem Hauptbranch entsteht dabei ein
[Release](https://github.com/fau-fablab/presentations/releases/latest) mit Datums-Version (`vJJJJ.MM.TT`),
den einzelnen PDFs und `output.tar.gz` mit allen PDFs.

[![PDF bauen](https://github.com/fau-fablab/presentations/actions/workflows/pdf.yml/badge.svg)](https://github.com/fau-fablab/presentations/actions/workflows/pdf.yml)

Auschecken und bauen
--------------------

```shell
git clone --recursive git@github.com:fau-fablab/presentations.git
cd presentations
make
```

Benötigt werden `make`, `latexmk` und TeX Live mit Beamer. Die PDFs landen in `output/`.
Eine neue Präsentation wird im `Makefile` unter `TARGET` (Datei im Hauptordner) oder `SUBDIRS`
(`ordner/ordner.tex`) eingetragen.

Die Vorlage liegt in `latex_templates/theme/`. Poster (A0 hoch, Corporate Design der FAU) bestehen aus dem Master `latex_templates/poster/fablabposter.sty` mit dem Layout (die Gestaltungsregeln stehen im Kopf dieser Datei) und einzelnen Teilen unter `poster/teile/<poster>/`, die `poster/poster_<name>.tex` zusammensetzt; Teile für mehrere Poster liegen unter `poster/teile/gemeinsam/`. Ein neues Poster wird im `Makefile` unter `POSTER` eingetragen. Die FAU-Wortmarke in `latex_templates/poster/fau/` stammt aus der FAU-Postervorlage `Poster_A3_FAU_Tech_DE.potx`. Das Logo des FAU FabLab mit FAU-Schriftzug kommt aus dem
Untermodul [logo](https://github.com/fau-fablab/logo). Bei einem bestehenden Klon das Untermodul mit
`git submodule update --init --recursive` laden.

Lizenz
------

Die einzelnen Bildlizenzen sind unter img/ in den jeweiligen .copyright.txt Dateien zu finden. Der Text der Präsentationen und FAU-FabLab-eigene Bilder sind unter CC-BY-SA 3.0 veröffentlicht. Das Resultat kann einzelne Bilder enthalten, die nicht unter dieser Lizenz stehen, und steht deshalb nicht vollständig unter CC-Lizenz!
