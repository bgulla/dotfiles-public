.PHONY: all bin dotfiles etc

all: dotfiles #etc

dotfiles:
	git submodule init
	git submodule update
	

	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp" -not -name ".irssi" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	# hacks

docker: 
	docker build -t bgulla/dotfiles -f Dockerfile .

