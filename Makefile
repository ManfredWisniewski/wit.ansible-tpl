.PHONY: deps lint test converge verify create destroy idempotence

# Path to Galaxy requirements for this repository
REQS=../requirements.yml

# Install Ansible Galaxy dependencies (collections/roles)
deps:
	ansible-galaxy install -r $(REQS)

# Run linters
yaml ?= .
lint:
	yamllint $(yaml)
	ansible-lint .

# Molecule shortcuts for this role
test:
	molecule test

converge:
	molecule converge

verify:
	molecule verify

create:
	molecule create

destroy:
	molecule destroy

idempotence:
	molecule idempotence
