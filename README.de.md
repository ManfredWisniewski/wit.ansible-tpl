# wit.ansible-tpl (Deutsch)

Minimales Ansible-Template zum Erstellen wiederverwendbarer Rollen und Playbooks mit Molecule-Tests und Galaxy‑fähigen Metadaten.
Einige Rollen, die mit dieser Vorlage erstellt wurden gibt es hier: [Wisniewski IT Solutions](https://github.com/ManfredWisniewski?tab=repositories)

## Funktionen
- **Rollenfokussiertes Layout** unter `roles/` mit Galaxy‑Metadaten.
- **Molecule**‑Szenario `default/` für Lint, Converge, Verify, Idempotence.
- **Collections/Rollen‑Verwaltung** über Galaxy‑Requirements.
- **Make‑Targets** (optional) für gängige Aufgaben.
- **GitHub Actions‑bereit** zum Ausführen von Molecule‑Tests im CI.

## Voraussetzungen
- Ansible >= 2.15
- Python >= 3.10
- Molecule + Docker (für lokale Tests)

## Projektstruktur
- `roles/<your_role>/` — Rollencode.
- `roles/<your_role>/meta/main.yml` — Galaxy‑Infos.
- `roles/<your_role>/molecule/default/` — Molecule‑Szenario.

## Schnellstart
- Klone dieses Repository über die Template‑Funktion und gib ihm deinen Rollennamen `your_role/`.
- Deklariere Abhängigkeiten in:
  - `your_role/meta/main.yml` (Rollendependencies, nur wenn wirklich nötig)
- Abhängigkeiten installieren:
  ```bash
  ansible-galaxy install -r requirements.yml
  ```
- Füge Logik in `your_role/tasks/main.yml` hinzu.

## Variablen
- Gemeinsame Defaults in `your_role/defaults/main.yml` ablegen.
- Variablen modular halten und präfixen, z. B. `your_role_*`.

## Testen (Molecule)
- Szenario unter `your_role/molecule/default/`.
- Collections/Rollen werden über den Molecule‑Schritt `dependency` aufgelöst.
- Typischer Ablauf:
  ```bash
  molecule test
  # oder
  molecule converge
  molecule verify
  ```

## Linting
- `ansible-lint` und `yamllint` können über den Lint‑Abschnitt des Szenarios oder manuell ausgeführt werden:
  ```bash
  yamllint .
  ansible-lint .
  ```

## CI
- Ausführen:
  - `ansible-galaxy install -r requirements.yml`
  - `molecule test` im Verzeichnis `your_role/`

## GitHub Actions
- Minimaler Workflow:
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

## Konventionen
- Tasks klein und idempotent halten.
- Für Modularität `include_role`/`import_tasks` verwenden.
- Kritische Operationen taggen, `--skip-tags` unterstützen.
- Harte Rollendependencies vermeiden, wenn möglich. Lieber Variablen/Erwartungen dokumentieren.

## Lizenz
MIT

## Autor
Manfred Wisniewski - WIT Solutions
