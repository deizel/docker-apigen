SHELL = /bin/sh

DOCKER ?= $(shell which docker)
DOCKER_REPOSITORY := apigen/apigen

.PHONY: images clean help

.SILENT: help

default: help

images: ## Build the image 🚀.
	${DOCKER} build --pull -t ${DOCKER_REPOSITORY}:latest .
	${DOCKER} build --pull -t ${DOCKER_REPOSITORY}:4.0 --build-arg VERSION=4.0.* .

clean: ## Delete any images.
	${DOCKER} images --quiet ${DOCKER_REPOSITORY} | xargs ${DOCKER} rmi -f

help: ## Show this help message.
	echo "usage: make [target] ..."
	echo ""
	echo "targets:"
	fgrep --no-filename "##" ${MAKEFILE_LIST} | fgrep --invert-match $$'\t' | sed -e 's/: ## / - /'
