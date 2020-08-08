SRC_FILES := $(shell find src -name '*.md')

OUT_PDF = $(SRC_FILES:src/%.md=dst/pdf/%.pdf)
OUT_HTML = $(SRC_FILES:src/%.md=dst/html/%.html)

STYLE_FIELS = style/style.css style/jquery.html style/script.html

dst/html/%.html: src/%.md $(STYLE_FIELS)
	pandoc -f markdown -t html5 -c $(shell pwd)/style/style.css -H style/jquery.html -A style/script.html $< -o $@

html: $(OUT_HTML)


dst/pdf/%.pdf: src/%.md $(STYLE_FIELS)
	pandoc -f markdown -t html5 -c $(shell pwd)/style/style.css -H style/jquery.html -A style/script.html $< -o $@

html: $(OUT_HTML)
pdf: $(OUT_PDF)


clean:
	rm dst/html/* dst/pdf/* || true