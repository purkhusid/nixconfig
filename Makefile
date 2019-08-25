SHELL := /bin/bash

.PHONY: install-all install-nix install-darwin install-home
install-nix: ## Install nix and update submodules
	./install-nix.sh
install-darwin: ## Install darwin
	./install-nix-darwin.sh
install-home: ## Install home-manager
	./install-home-manager.sh
install-config:
	./install-config.sh