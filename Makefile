COMPOSE_FILE=docker-compose.yml
.PHONY: compile_all compile_translator_ru compile_translator_it compile_translator_en compile_translator_fr compile_translator_es collect_text help_tran

up:
	@docker-compose -f $(COMPOSE_FILE) up -d

down:
	@docker-compose -f $(COMPOSE_FILE) down

restart:
	@docker-compose -f $(COMPOSE_FILE) down
	@docker-compose -f $(COMPOSE_FILE) up -d

build:
	@docker compose -f $(COMPOSE_FILE) build

ps:
	@docker-compose -f $(COMPOSE_FILE) ps

logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f

clean:
	@docker-compose -f $(COMPOSE_FILE) down --rmi all --volumes --remove-orphans

app-shell:
	@docker-compose -f $(COMPOSE_FILE) exec app bash

postgres-shell:
	@docker-compose -f $(COMPOSE_FILE) exec postgres bash

test:
	@docker-compose -f $(COMPOSE_FILE) exec app pytest
language_compiler:
	pybabel compile -d ./src/middleware/i18n_middleware_example/locales
help:
	@echo "Usage: make [command]"
	@echo "Commands:"
	@echo "  up             Поднять контейнеры"
	@echo "  down           Остановить и удалить контейнеры"
	@echo "  restart        Перезапустить контейнеры"
	@echo "  build          Собрать контейнеры"
	@echo "  ps             Показать статус контейнеров"
	@echo "  logs           Просмотр логов в реальном времени"
	@echo "  clean          Остановить контейнеры и удалить образы и тома"
	@echo "  app-shell      Запуск bash внутри контейнера app"
	@echo "  postgres-shell Запустить bash внутри контейнера postgres"
	@echo "  test           Запустить тесты"


alembic_revision:
	alembic revision --autogenerate -m "Init migration"

alembic_upgrade:
	alembic upgrade head

alembic_downgrade:
	alembic downgrade