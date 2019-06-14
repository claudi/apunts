#!/bin/bash
filename=Main
# \newcommand{\myref}[1]{\ref{#1}}
all:
	make pdf

pdf:
	pdflatex -src -interaction=nonstopmode ${filename}.tex

myrefOff:
	pdflatex -src -interaction=nonstopmode "\newcommand{\myref}[1]{\ref{#1}}\input{${filename}.tex}"

myrefFix:
	make clean
	make myrefOff
	make pdf

main:
	make myrefOff
	makeindex ${filename}
	biber ${filename}
	make myrefOff
	make pdf

pdfportada:
	( cd FrontMatter/Portada/ && pdflatex -synctex=1 -interaction=nonstopmode portada.tex )

portada:
	make pdfportada
	make pdfportada

clean:
	find ./ -name "${filename}.*" -not -name "${filename}.tex" -exec rm {} \;

cleanportada:
	find ./FrontMatter/Portada/ -name "portada.*" -not -name "portada.tex" -exec rm {} \;

read:
	zathura Main.pdf

full:
	make cleanportada
	make portada
	make clean
	make main
# 	make read
