texe:=luatex
texc:=lualatex
docs:=Eva-JFM_doc-sc.tex Eva-JFM_doc-en.tex Eva-JFM_doc-jp.tex


man: Evangelion-JFM.dtx
	$(texe) Evangelion-JFM.dtx

zhcn: man
	$(texc) Eva-JFM_doc-sc.tex
	$(texc) Eva-JFM_doc-sc.tex

jajp: man
	$(texc) Eva-JFM_doc-jp.tex
	$(texc) Eva-JFM_doc-jp.tex

ennl: man
	$(texc) Eva-JFM_doc-en.tex
	$(texc) Eva-JFM_doc-en.tex

doc: zhcn jajp ennl

clean:
	latexmk -c
	rm -f $(docs)

.DEFAULT_GOAL=doc
.PHONY: clean
