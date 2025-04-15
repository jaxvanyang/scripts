lint:
	shellcheck **/*.sh
	ruff check

fmt:
	shfmt -w **/*.sh
	black **/*.py
