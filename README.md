# wit.ansible-tpl

Minimal Ansible template for building reusable roles and playbooks with Molecule testing and Galaxy-ready metadata.
You can find roles created with this template at my GitHub page [Wisniewski IT Solutions](https://github.com/ManfredWisniewski?tab=repositories)

## Features
- **Role-first layout** under `roles/` with Galaxy metadata.
- **Molecule** scenario `default/` for lint, converge, verify, idempotence.
- **Collections/roles management** via Galaxy requirements.
- **Make targets** (optional) for common tasks.
- **GitHub Actions-ready** for running Molecule tests in CI.

## Requirements
- Ansible >= 2.15
- Python >= 3.10
- Molecule + Docker (for local tests)

## Project structure
- `roles/<your_role>/` — role code.
- `roles/<your_role>/meta/main.yml` — Galaxy info.
- `roles/<your_role>/molecule/default/` — Molecule scenario.

## Quickstart
- Clone this repository using the template functionality and give it your name `your_role/`.
- Declare dependencies in:
  - `your_role/meta/main.yml` (role deps, if truly required)
- Install deps:
  ```bash
  ansible-galaxy install -r requirements.yml
  ```
- Add some logic to `your_role/tasks/main.yml`.
## Variables
- Put shared defaults in `your_role/defaults/main.yml`.
- Keep variables modular and prefixed, e.g. `your_role_*`.

## Testing (Molecule)
- Scenario at `your_role/molecule/default/`.
- Collections/roles resolved via Molecule `dependency` step.
- Typical flow:
  ```bash
  molecule test
  # or
  molecule converge
  molecule verify
  ```
## Linting
- `ansible-lint` and `yamllint` can be invoked from the scenario’s `lint` section or manually:
  ```bash
  yamllint .
  ansible-lint .
  ```

## CI
- Run:
  - `ansible-galaxy install -r requirements.yml`
  - `molecule test` inside `your_role/`

## GitHub Actions
- You can add a minimal workflow like:
  ```yaml
  name: Molecule
  on:
    push:
    pull_request:
  jobs:
    test:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - uses: actions/setup-python@v5
          with:
            python-version: '3.x'
        - name: Install dependencies
          run: |
            python -m pip install --upgrade pip
            pip install ansible molecule-plugins[docker] docker ansible-lint yamllint
            ansible-galaxy install -r roles/requirements.yml
        - name: Run Molecule
          working-directory: roles/your_role
          run: |
            molecule test
  ```

## Conventions
- Keep tasks small and idempotent.
- Use `include_role`/`import_tasks` for modularity.
- Tag critical operations, support `--skip-tags`.
- Avoid role hard-dependencies unless absolutely necessary; prefer documenting variables and expectations.

## License
MIT

## Author
Manfred Wisniewski - WIT Solutions
