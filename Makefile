include .env
.PHONY: project-start project-stop


project-start: ## start
	docker-compose up --build -d

 project-stop: ## stop
	docker-compose stop