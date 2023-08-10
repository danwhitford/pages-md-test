SRC_DIR := posts
OUTPUT_DIR := build
MARKDOWN_FILES := $(wildcard $(SRC_DIR)/*.md)
OUTPUT_FILES := $(patsubst $(SRC_DIR)/%.md,$(OUTPUT_DIR)/%.html,$(MARKDOWN_FILES))

$(OUTPUT_DIR)/index.html: build build/banner.html $(OUTPUT_FILES) pages/index.md script.js
	pandoc pages/index.md \
		-s \
		-o $(OUTPUT_DIR)/index.html \
		--include-before-body=$(OUTPUT_DIR)/banner.html
	cp script.js $(OUTPUT_DIR)/script.js

$(OUTPUT_DIR)/banner.html: pages/banner.md
	pandoc pages/banner.md -o $(OUTPUT_DIR)/banner.html

build:
	mkdir -p $(OUTPUT_DIR)

$(OUTPUT_DIR)/%.html: $(SRC_DIR)/%.md $(OUTPUT_DIR)/banner.html
	pandoc $< -o $@ \
		-s \
		--include-before-body=$(OUTPUT_DIR)/banner.html \
		-M document-css=false
