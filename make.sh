## RadioNoiseE, 2023.
## Evangelion Japanese Font Metric

# Init
echo "--Make: Running--"

# Literate Programming - Strip out En/Sc docu
luatex Evangelion-JFM.dtx

# Complie respectively
lualatex Eva-JFM_doc-sc.tex
lualatex Eva-JFM_doc-sc.tex
lualatex Eva-JFM_doc-jp.tex
lualatex Eva-JFM_doc-jp.tex
lualatex Eva-JFM_doc-en.tex
lualatex Eva-JFM_doc-en.tex

# Clean-up (requires LaTeXmk)
latexmk -c Eva-JFM_doc-sc.tex
latexmk -c Eva-JFM_doc-jp.tex
latexmk -c Eva-JFM_doc-en.tex
rm Eva-JFM_doc-sc.tex Eva-JFM_doc-en.tex Eva-JFM_doc-jp.tex

# Terminate
echo "--Make: Documentations and run-time files generated--"
