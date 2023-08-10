site: build
	pandoc -s -o build/index.html index.md
	cp script.js build/script.js

build:
	mkdir -p build
