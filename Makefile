## ----------------------------------------------------------------------
## This is the 7-in-7 Makefile.
##
## Here, we define the project targets to be executed in the
## development flow.
##
## Help comments are displayed in the order defined within the Makefile.
## ----------------------------------------------------------------------
##

_GREEN='\033[0;32m'
_NC='\033[0m'

define log
	@printf "${_GREEN}$(1)${_NC}\n"
endef

POSTGRES:=postgres
MONGO:=mongodb
REDIS:=redis
NEO4J:=neo4j
HBASE:=hbase


POSTGRES_CMD:=docker-compose -f ./${POSTGRES}/docker-compose.yml
MONGO_CMD:=docker-compose -f ./${MONGO}/docker-compose.yml
REDIS_CMD:=docker-compose -f ./${REDIS}/docker-compose.yml
NEO4J_CMD:=docker-compose -f ./${NEO4J}/docker-compose.yml
HBASE_CMD:=docker-compose -f ./${HBASE}/docker-compose.yml

ps:
	docker ps

# postgres targets
postgres-up:
	$(POSTGRES_CMD) up

postgres-down:
	$(POSTGRES_CMD) down

postgres-exec:
	cd ${POSTGRES} && docker exec -it -u postgres postgres_postgres_1 /bin/bash

postgres-psql:
	cd ${POSTGRES} && docker exec -it -u postgres postgres_postgres_1 psql

postgres-dump:
	cd ${POSTGRES} && docker exec -it -u postgres postgres_postgres_1 pg_dumpall -c > dumps/dump-$(shell date --iso=seconds).sql

postgres-restore-backup: ## WIP
	cd ${POSTGRES}/dumps && cat $(dump) | docker exec -i -u postgres postgres_postgres_1 psql

# mongodb targets
mongodb-up:
	$(MONGO_CMD) up

mongodb-down:
	$(MONGO_CMD) down

mongodb-exec:
	cd ${MONGO} && docker-compose exec mongo bash

mongodb-book:
	cd ${MONGO} && docker-compose exec mongo mongo -u root -p example --authenticationDatabase admin book

# redis targets
redis-up: # web ui listening on http://127.0.0.1:8081
	$(REDIS_CMD) up

redis-down:
	$(REDIS_CMD) down

redis-replication-mode:
	cd ${REDIS} && docker-compose -f docker-compose-replication.yml up

redis-cli:
	cd ${REDIS} && docker exec -it redis_redis_1 redis-cli

# neo4j targets
neo4j-up:
	$(NEO4J_CMD) up

neo4j-down:
	$(NEO4J_CMD) down

neo4j-exec:
	cd ${NEO4J}

neo4j-cli:
	cd ${NEO4J}

# hbase targets
hbase-up:
	$(HBASE_CMD) up

hbase-down:
	$(HBASE_CMD) down

hbase-shell:
	cd ${HBASE} && docker exec -it hbase hbase shell