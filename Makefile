SRC_FILES := $(shell find src -name '*.md' | sort -n)

OUT_PDF = $(SRC_FILES:src/%.md=dst/pdf/%.pdf)
OUT_HTML = $(SRC_FILES:src/%.md=dst/html/%.html)

STYLE_FIELS = style/style.css style/jquery.html style/script.html

dst/html/%.html: src/%.md $(STYLE_FIELS)
	pandoc -s -f markdown -t html5 -c $(shell pwd)/style/style.css -H style/jquery.html -A style/script.html $< -o $@

dst/pdf/all.pdf: ${SRC_FILES} $(STYLE_FIELS)
	pandoc -s -f markdown -t html5 -c $(shell pwd)/style/style.css -H style/jquery.html -A style/script.html --pdf-engine-opt="--debug-javascript"  --pdf-engine-opt="toc" ${SRC_FILES} -o $@

dst/pdf/%.pdf: src/%.md $(STYLE_FIELS)
	pandoc -s -f markdown -t html5 -c style/style.css -H style/jquery.html -A style/script.html \
		--pdf-engine-opt="--debug-javascript" \
		--pdf-engine-opt="--keep-relative-links" \
	  	$< -o $@

dst/html/all.html: ${SRC_FILES} $(STYLE_FIELS)
	pandoc -s -f markdown -t html5 -c $(shell pwd)/style/style.css -H style/jquery.html -A style/script.html ${SRC_FILES} -o $@

html: $(OUT_HTML) dst/html/all.html
pdf: $(OUT_PDF) dst/pdf/all.pdf

clean:
	rm dst/html/*.html dst/pdf/*.pdf || true