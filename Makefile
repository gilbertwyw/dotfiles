.PHONY: bundle-check bundle-cleanup bundle-dump bundle-install bundle-list

bundle-list:
	brew bundle list

bundle-check:
	brew bundle check

bundle-cleanup:
	brew bundle cleanup

bundle-dump:
	brew bundle dump --force

bundle-install:
	brew bundle install -v --no-lock
