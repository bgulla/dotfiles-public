.PHONY: all bin dotfiles etc

all: dotfiles #etc
krew: install-krew install-krew-plugins


dotfiles:
	git submodule init
	git submodule update
	

	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp" -not -name ".irssi" -not -name ".gnupg" -not -name ".krewplugins"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	# hacks

docker-build: 
	docker build -t bgulla/dotfiles -f Dockerfile .

run:
	docker run --rm -it bgulla/dotfiles zsh

install-krew:
	sh ./scripts/install/krew-install.sh

install-krew-plugins:
	kubectl krew install < ./.krewplugins

install-k8s-tools:
	for script_file in scripts/install/*.sh; do \
		if [ -f "$$script_file" ]; then \
			echo "[running ${script_file}]" \
			/bin/sh "$$script_file"; \
		fi \
	done
