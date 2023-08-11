PAGES_DIR := pages
PARTIALS_DIR := partials
SCRIPT_DIR := scripts
OUTPUT_DIR := build

POSTS_FILES := $(wildcard $(PAGES_DIR)/*.md)
POSTS_OUTPUT_FILES := $(patsubst $(PAGES_DIR)/%.md,$(OUTPUT_DIR)/%.html,$(POSTS_FILES))

SCRIPT_FILES := $(wildcard $(SCRIPT_DIR)/*.js)
OUTPUT_SCRIPT_FILES := $(patsubst scripts/%.js,$(OUTPUT_DIR)/%.js,$(SCRIPT_FILES))

PARTIAL_FILES := $(wildcard $(PARTIALS_DIR)/*.md)
OUTPUT_PARTIAL_FILES := $(patsubst $(PARTIALS_DIR)/%.md,$(OUTPUT_DIR)/%.html,$(PARTIAL_FILES))

# Build the site based on dependencies
.PHONY: site
site: $(OUTPUT_DIR) $(POSTS_OUTPUT_FILES) $(OUTPUT_PARTIAL_FILES) $(OUTPUT_SCRIPT_FILES)

# Build the individual pages as standalone html files
$(OUTPUT_DIR)/%.html: $(PAGES_DIR)/%.md $(OUTPUT_DIR) $(OUTPUT_PARTIAL_FILES)
	pandoc $< -o $@ \
		-s \
		--include-before-body=$(OUTPUT_DIR)/banner.html \
		-M document-css=false

# Copy the scripts to the output directory
$(OUTPUT_DIR)/%.js: scripts/%.js $(OUTPUT_DIR)
	cp $< $@

# Build the partials as HTML fragments
$(OUTPUT_DIR)/%.html: $(PARTIALS_DIR)/%.md $(OUTPUT_DIR)
	pandoc $< -o $@

# Create the output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Clean the output directory
.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)
