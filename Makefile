.PHONY: help test submit gen clean up down make

# デフォルターゲット
help:
	@echo "Available commands:"
	@echo "  make up                - Start Docker container"
	@echo "  make down              - Stop Docker container"
	@echo "  make gen abc001        - Generate contest environment"
	@echo "  make test              - Run tests (select problem with fzf)"
	@echo "  make submit            - Submit problem (select problem with fzf)"
	@echo "  make clean             - Clean generated files"
	@echo ""
	@echo "Example:"
	@echo "  make up"
	@echo "  make gen abc001"
	@echo "  make test"

# テスト実行（fzf でディレクトリ選択可能）
test:
	@PROBLEM_DIR=$$(find src -mindepth 2 -maxdepth 2 -type d 2>/dev/null | fzf --preview 'ls -la {}' --preview-window=top:5); \
	if [ -z "$$PROBLEM_DIR" ]; then \
		echo "Cancelled"; \
		exit 0; \
	fi; \
	docker-compose exec -w /workdir/$$PROBLEM_DIR app atcoder-tools test

# 提出（fzf でディレクトリ選択可能）
submit:
	@PROBLEM_DIR=$$(find src -mindepth 2 -maxdepth 2 -type d 2>/dev/null | fzf --preview 'ls -la {}' --preview-window=top:5); \
	if [ -z "$$PROBLEM_DIR" ]; then \
		echo "Cancelled"; \
		exit 0; \
	fi; \
	docker-compose exec -w /workdir/$$PROBLEM_DIR app atcoder-tools submit -u

# コンテスト環境生成
gen:
	@CONTEST_ID="$(filter-out $@,$(MAKECMDGOALS))"; \
	if [ -z "$$CONTEST_ID" ]; then \
		echo "Error: Contest ID is required"; \
		echo "Usage: make gen abc001"; \
		exit 1; \
	fi; \
	docker-compose exec app atcoder-tools gen $$CONTEST_ID

# ダミーターゲット（引数を吸収）
%:
	@true

# クリーンアップ（確認付き）
clean:
	@echo "Warning: This will delete ALL contest/problem directories in src/"
	@read -p "Are you sure? (type 'yes' to confirm): " confirm; \
	if [ "$$confirm" = "yes" ]; then \
		rm -rf src/*/; \
		echo "Cleaned all directories"; \
	else \
		echo "Cancelled"; \
	fi

# Docker起動
up:
	docker-compose up -d

# Docker停止
down:
	docker-compose down

# サブディレクトリに Makefile を生成
make:
	@cp Makefile.src src/Makefile; \
	echo "Created Makefile in src/"; \
	for dir in src/*/; do \
		if [ -d "$$dir" ]; then \
			cp Makefile.submake "$$dir/Makefile"; \
			echo "Created Makefile in $$dir"; \
		fi; \
	done
