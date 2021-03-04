front = front-matter/
body  = body-matter/
end   = end-matter/

portada.dir = $(front)portada/

classes  = $(wildcard $(body)*/*.tex)  $(wildcard $(body)*.tex)
assets   = $(wildcard $(front)*.tex) $(portada.dir)portada.pdf

flags = -interaction=nonstopmode -halt-on-error
draft = -draftmode

main.pdf: main.tex $(classes) $(assets) main.bbl main.ind main.gls
	pdflatex $(flags) $<

.PHONY: draft
draft: main.tex $(classes)
	pdflatex $(flags) $(draft) "\newcommand{\myref}[1]{\ref{#1}}\input{$<}"

.PHONY: clean
clean:
	find ./ -name "main.*" -not -name "main.tex" -exec rm {} \;
	find ./$(portada.dir) -name "portada.*" -not -name "portada.tex" -exec rm {} \;

$(portada.dir)portada.pdf: $(portada.dir)portada.tex $(portada.dir)UABLogo.pdf
	pdflatex -output-directory $(portada.dir) $(flags) $<

$(portada.dir)UABLogo.pdf: | $(portada.dir)UABLogo.eps
	epstopdf $<

$(portada.dir)UABLogo.eps:
	cp ../UABLogo.eps $@
	echo "Building UABLogo.eps!!!!!!"

main.bbl: | main.bcf
	biber main #&& rm main.blg

main.ind: $(end)indexstyle.ist | main.idx
	makeindex -q -s $< -o $@ $|

main.gls: $(end)glossarystyle.gst | main.glo
	makeindex -q -s $< -o $@ $|

main.bcf main.idx main.glo: bibindexgloss

SHELL := /bin/bash

.PHONY: bibindexgloss
bibindexgloss:
	@if ([ ! -f main.bcf ] || [ ! -f main.idx ] || [ ! -f main.glo ]) \
	then \
		pdflatex $(flags) $(draft) "\newcommand{\myref}[1]{\ref{#1}}\input{main.tex}"; \
	fi

