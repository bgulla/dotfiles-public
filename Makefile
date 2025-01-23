.PHONY: dotfiles bin-local
# .PHONY: all bin dotfiles etc
# Find all files in ./bin
FILES := $(wildcard bin/*)

# Target for creating symlinks
symlinks:
	@mkdir -p ~/bin
	@$(foreach file,$(FILES),ln -sf $(abspath $(file)) ~/bin/;)
all: dotfiles #etc

bin:
	# add aliases for things in bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name "*-backlight" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done
	sudo ln -sf $(CURDIR)/bin/browser-exec /usr/local/bin/xdg-open; \

bin-local:
	# Find all files in ./bin
	@mkdir -p ~/bin
	@$(foreach file,$(FILES),ln -sf $(abspath $(file)) ~/bin/;)

dotfiles:
	git submodule init
	git submodule update
	

	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp" -not -name ".irssi" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	# hacks

#	ln -s ${PWD}/powerlevel10k ${HOME}/powerlevel10k
#	ln -s ${PWD}/oh-my-zsh ${HOME}/.oh-my-zsh

#	ln -sfn $(CURDIR)/.gnupg/gpg.conf $(HOME)/.gnupg/gpg.conf;
#	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;

etc:
	for file in $(shell find $(CURDIR)/etc -type f -not -name ".*.swp"); do \
		f=$$(echo $$file | sed -e 's|$(CURDIR)||'); \
		sudo ln -f $$file $$f; \
	done
	systemctl --user daemon-reload
	sudo systemctl daemon-reload

tmux:
	rm -rf ~/tmux* ~/.tmux* 
	git clone ssh://git@git.lol:2222/brandon/tmux-config.git ~/tmux-config
#	mkdir -p ~/.tmux/plugins
	chmod +x ~/tmux-config/install.sh
	~/tmux-config/install.sh

zsh:
	chsh -s $(which zsh)
