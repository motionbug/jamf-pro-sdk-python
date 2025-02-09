SHELL := /bin/bash
.PHONY: docs

install:
	python3 -m pip install --editable '.[dev]'

uninstall:
	python3 -m pip uninstall -y -r <(python3 -m pip freeze)

clean:
	rm -rf build/ dist/ src/*.egg-info **/__pycache__ .coverage .pytest_cache/ .ruff_cache/

test:
	pytest

lint:
	black --check src tests
	ruff check src tests

format:
	black src tests # You can have it any color you want...
	ruff check --select I001 --fix src tests # Only fixes import order

build:
	python3 -m build --sdist --wheel

docs:
	rm -f docs/reference/_autosummary/*.rst
	sphinx-build -b html docs/ build/docs/
