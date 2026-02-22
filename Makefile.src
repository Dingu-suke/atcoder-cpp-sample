.PHONY: help test submit

# src ディレクトリ用 Makefile
ROOT_DIR := $(shell cd $(CURDIR)/.. && pwd)

help:
	@echo "Available commands (in src/):"
	@echo "  make test   - Run tests (select problem with fzf)"
	@echo "  make submit - Submit problem (select problem with fzf)"

test:
	@PROBLEM_DIR=$$(find . -mindepth 2 -maxdepth 2 -type d 2>/dev/null | sed 's|^\./||' | fzf --preview "ls -la $(CURDIR)/{}" --preview-window=top:5); \
	if [ -z "$$PROBLEM_DIR" ]; then \
		echo "Cancelled"; \
		exit 0; \
	fi; \
	docker-compose -f $(ROOT_DIR)/docker-compose.yml exec -w /workdir/src/$$PROBLEM_DIR app atcoder-tools test

submit:
	@PROBLEM_DIR=$$(find . -mindepth 2 -maxdepth 2 -type d 2>/dev/null | sed 's|^\./||' | fzf --preview "ls -la $(CURDIR)/{}" --preview-window=top:5); \
	if [ -z "$$PROBLEM_DIR" ]; then \
		echo "Cancelled"; \
		exit 0; \
	fi; \
	docker-compose -f $(ROOT_DIR)/docker-compose.yml exec -w /workdir/src/$$PROBLEM_DIR app atcoder-tools submit -u
