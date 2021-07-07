.PHONY: all
all: ps ;

.PHONY: up
up: ./var/postgres ./var/redis ./var/funkwhale/music ./var/funkwhale/media ./var/funkwhale/static
	docker-compose up -d

.PHONY: down
down:
	docker-compose down

.PHONY: reload
reload:
	$(MAKE) down
	$(MAKE) up

.PHONY: restart
restart:
	docker-compose restart

.PHONY: build
build:
	docker-compose build

.PHONY: pull
pull:
	docker-compose pull

.PHONY: log
log:
	docker-compose logs -f --tail 0

.PHONY: ps
ps:
	docker-compose ps

.PHONY: top
top:
	docker-compose top

# -----------------------------------------------------------------------------

.PHONY: backup
backup:
	sudo bash _helpers/backup.sh $(shell id -g) $(shell id -u) var .env

# -----------------------------------------------------------------------------
# https://makefiletutorial.com/#automatic-variables
./var/postgres ./var/redis ./var/funkwhale/music ./var/funkwhale/media ./var/funkwhale/static:
	mkdir -p "$@"
