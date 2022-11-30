include docker.env
-include docker.env.local
export

all: help

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


DC=docker-compose -p secupay-test --env-file docker.env

build: ## Build app
	$(DC) build --no-cache --progress plain

start-app: ## Starts applications with docker
	$(DC) up -d --force-recreate

stop-app: ## Stop applications
	$(DC) down

bash-app: ## Go to the shell
	$(DC) exec -- app bash
	$(DC) down

test-app: ## Run tests
	$(DC) exec -- app php vendor/bin/codecept run

test-coverage-app: ## Run tests coverage
	$(DC) exec -- app php vendor/bin/codecept run --coverage --coverage-html


php-cs-fix: ## Run CS fixer and fix
	@docker run --rm -it --volume $(PWD):/app -w /app --user $(id -u):$(id -g) miroff/php-cs-fixer:3.11.0 php-cs-fixer fix -v
