doc-manu = Eva-JFM_doc-sc.tex Eva-JFM_doc-en.tex Eva-JFM_doc-jp.tex

.PHONY : release
release : Evangelion-JFM.dtx jfm-eva.lua
	luatex Evangelion-JFM.dtx
	lualatex Eva-JFM_doc-sc.tex
	lualatex Eva-JFM_doc-sc.tex
	latexmk -c Eva-JFM_doc-sc.tex
	lualatex Eva-JFM_doc-jp.tex
	lualatex Eva-JFM_doc-jp.tex
	latexmk -c Eva-JFM_doc-jp.tex
	lualatex Eva-JFM_doc-en.tex
	lualatex Eva-JFM_doc-en.tex
	latexmk -c Eva-JFM_doc-en.tex
	rm $(doc-manu)
