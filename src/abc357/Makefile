.PHONY: help test submit

# サブディレクトリ用 Makefile
CONTEST_DIR := $(shell basename $(CURDIR))
ROOT_DIR := $(shell cd $(CURDIR)/../../.. && pwd)

help:
	@echo "Available commands (in $(CONTEST_DIR)):"
	@echo "  make test       - Run tests (select problem with fzf)"
	@echo "  make submit     - Submit problem (select problem with fzf)"

test:
	@PROBLEM_DIR=$$(find . -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sed 's|^\./||' | fzf --preview "ls -la $(CURDIR)/{}" --preview-window=top:5); \
	if [ -z "$$PROBLEM_DIR" ]; then \
		echo "Cancelled"; \
		exit 0; \
	fi; \
	docker-compose -f $(ROOT_DIR)/docker-compose.yml exec -w /workdir/src/$(CONTEST_DIR)/$$PROBLEM_DIR app atcoder-tools test

submit:
	@PROBLEM_DIR=$$(find . -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sed 's|^\./||' | fzf --preview "ls -la $(CURDIR)/{}" --preview-window=top:5); \
	if [ -z "$$PROBLEM_DIR" ]; then \
		echo "Cancelled"; \
		exit 0; \
	fi; \
	docker-compose -f $(ROOT_DIR)/docker-compose.yml exec -w /workdir/src/$(CONTEST_DIR)/$$PROBLEM_DIR app atcoder-tools submit -u
