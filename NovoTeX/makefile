#!/bin/bash
filename = Main

all:
	make pdf
	make read

pdf:
	pdflatex -src -interaction=nonstopmode -halt-on-error -shell-escape ${filename}.tex

draft:
	pdflatex -src -interaction=nonstopmode -halt-on-error -draftmode ${filename}.tex

myrefOff:
	pdflatex -src -interaction=nonstopmode -halt-on-error -draftmode "\newcommand{\myref}[1]{\ref{#1}}\input{${filename}.tex}"

myrefFix:
	make clean
	make myrefOff
	make pdf

index:
	makeindex -q ${filename} # Make it so it outputs to /BackMatter

bibliography:
	biber ${filename}

main:
	make myrefOff
	make bibliography
	make draft
	make index
	make pdf

pdfPortada:
	( cd FrontMatter/Portada/ && pdflatex -synctex=1 -interaction=nonstopmode portada.tex )

portada:
	make pdfPortada
	make pdfPortada

clean:
	find ./ -name "${filename}.*" -not -name "${filename}.tex" -exec rm {} \;

cleanportada:
	find ./FrontMatter/Portada/ -name "portada.*" -not -name "portada.tex" -exec rm {} \;

cleanFull:
	make clean
	make cleanportada

read:
# 	zathura Main.pdf
	okular Main.pdf

full:
	make cleanportada
	make portada
	make clean
	make main
# 	make read
