all: local

local:
	mkdocs serve

deploy:
	mkdocs gh-deploy -v
