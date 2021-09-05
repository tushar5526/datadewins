.DEFAULT_GOAL := up
prepare:
	@echo "Installing packages"
	apt-get update
	apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	lsb-release
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	apt-get update
	apt-get install -y docker-ce docker-ce-cli containerd.io
	apt autoremove -y
	apt autoclean -y

up: prepare
	mkdir -p docker docker/db docker/www
	cp index.php docker/www
	docker-compose up
down: 
	@echo "down"
	docker-compose down
teardown: down
	@echo "teardown"
	rm -rf ./docker/*

