SRC_DIR := posts
OUTPUT_DIR := build
MARKDOWN_FILES := $(wildcard $(SRC_DIR)/*.md)
OUTPUT_FILES := $(patsubst $(SRC_DIR)/%.md,$(OUTPUT_DIR)/%.html,$(MARKDOWN_FILES))
SCRIPT_FILES := $(wildcard scripts/*.js)
OUTPUT_SCRIPT_FILES := $(patsubst scripts/%.js,$(OUTPUT_DIR)/%.js,$(SCRIPT_FILES))

$(OUTPUT_DIR)/index.html: $(OUTPUT_DIR) $(OUTPUT_DIR)/banner.html $(OUTPUT_FILES) pages/index.md $(OUTPUT_SCRIPT_FILES)
	pandoc pages/index.md \
		-s \
		-o $(OUTPUT_DIR)/index.html \
		-M document-css=false \
		--include-before-body=$(OUTPUT_DIR)/banner.html

$(OUTPUT_DIR)/banner.html: pages/banner.md
	pandoc pages/banner.md -o $(OUTPUT_DIR)/banner.html

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

$(OUTPUT_DIR)/%.html: $(SRC_DIR)/%.md $(OUTPUT_DIR)/banner.html
	pandoc $< -o $@ \
		-s \
		--include-before-body=$(OUTPUT_DIR)/banner.html \
		-M document-css=false

$(OUTPUT_DIR)/%.js: scripts/%.js
	cp $< $@
