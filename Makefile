APP_URL ?= https://app.prompton.ai
HOME_URL ?= https://prompton.ai
DOCS_URL ?= https://docs.prompton.ai
TAG ?= prompton-home:local

.PHONY: build serve docker
build:
	APP_URL=$(APP_URL) HOME_URL=$(HOME_URL) DOCS_URL=$(DOCS_URL) ./build.sh
serve: build
	cd dist && python3 -m http.server 8089
docker:
	docker build --build-arg APP_URL=$(APP_URL) --build-arg HOME_URL=$(HOME_URL) --build-arg DOCS_URL=$(DOCS_URL) -t $(TAG) .
