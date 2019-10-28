DOTFILES = $(basename $(wildcard *.dot))

all: \
	$(addsuffix .png, $(DOTFILES)) \
	$(addsuffix .pdf, $(DOTFILES)) \
	graphvizuml.pdf

%.png: %.dot
	dot $< -Tpng -o $@

%.pdf: %.dot
	dot $< -Tpdf -o $@

graphvizuml.pdf: README.md $(addsuffix .pdf, $(DOTFILES))
	sed 's/.png/.pdf/g' README.md | pandoc -t latex -o graphvizuml.pdf --pdf-engine=xelatex --template=report.tex --number-sections --top-level-division=chapter --toc
