#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$HOME/repos/pansla}"
SOURCE_REPO="ENVIRONMENT_AWARENESS"

write_environment_aware_files() {
  local repo_dir="$1"
  local repo_name="$2"
  local repo_slug="$3"

  mkdir -p "$repo_dir/environment-aware/templates"

  cat > "$repo_dir/environment-aware/README.md" <<EOF_INNER
# Environment Awareness

This folder records environment-specific facts for \`$repo_name\`.

The source pattern lives in:

\`\`\`text
https://github.com/pansla/ENVIRONMENT_AWARENESS
\`\`\`

## Purpose

Prevent future agents from rediscovering the same WSL, Podman, auth, dependency, port, and permission constraints.

## Required reads

Before running setup, build, test, container, or GitHub commands, read:

- \`current-environment.md\`
- \`known-constraints.md\`
- \`tool-inventory.md\`
- \`ports-and-services.md\`
- \`auth-and-remotes.md\`
- \`incident-log.md\`

## Update rule

When reality changes the implementation path, update this folder.
EOF_INNER

  cat > "$repo_dir/environment-aware/current-environment.md" <<EOF_INNER
# Current Environment

Last updated: 2026-06-02

## Primary environment

Development is on WSL, not Windows.

\`\`\`text
Repo path: ~/repos/pansla/$repo_name
GitHub org: pansla
GitHub repo: $repo_name
GitHub auth: WSL
Container runtime: Podman
Preferred compose command: podman-compose
\`\`\`

## Operating preference

Prefer containerized commands over host installs when the repo supports them.

Do not assume Windows has the same toolchain or GitHub credentials as WSL.
EOF_INNER

  cat > "$repo_dir/environment-aware/known-constraints.md" <<'EOF_INNER'
# Known Constraints

Last updated: 2026-06-02

## WSL-only GitHub auth

GitHub CLI and git auth are configured in WSL. Do not assume Windows has the same credentials.

## Container-first preference

Do not install dependencies directly on the host by default.

Prefer:

- existing tools already present
- Podman containers
- repo-declared container or compose workflows

## Missing host tools observed

```text
rg: not installed during AI_NATIVE_GITHUB onboarding
sqlite3: not installed during AI_NATIVE_GITHUB migration validation
```

Fallbacks used:

- `find`, `grep`, and `sed` when `rg` is missing
- Rust SQLite tests or containerized SQLite when `sqlite3` is missing

## Rootless Podman caution

Rootless Podman bind mounts may not be writable by container users.

If a service needs persistent writable state, prefer a Podman named volume unless the repo explicitly requires a bind mount.
EOF_INNER

  cat > "$repo_dir/environment-aware/tool-inventory.md" <<'EOF_INNER'
# Tool Inventory

Last updated: 2026-06-02

## Observed WSL tools

```text
gh: available and authenticated in WSL
git: available
podman: available
podman-compose: available
node: available for JSON parse checks
```

## Tools observed in some repos

```text
cargo
rustc
rustfmt
```

## Observed missing host tools

```text
rg
sqlite3
```

## Rule

If you rely on a tool version, record the command used to observe it.
EOF_INNER

  cat > "$repo_dir/environment-aware/container-strategy.md" <<'EOF_INNER'
# Container Strategy

Last updated: 2026-06-02

## Default

Prefer Podman for containerized development and validation.

## Pattern

Use short-lived containers for validation:

```sh
podman run --rm -v "$PWD":/work -w /work <image> <command>
```

Use named volumes for long-lived writable service state:

```text
podman volume create <repo>_<service>-data
```

## Known caution

Some language images may not include formatting or auxiliary tools.

If that happens:

1. Do not install on the host by default.
2. Check whether a different container image already exists locally.
3. If an existing host tool is used as fallback, record that fact.
4. Update `incident-log.md`.
EOF_INNER

  cat > "$repo_dir/environment-aware/ports-and-services.md" <<'EOF_INNER'
# Ports And Services

Last updated: 2026-06-02

## Ports to check before binding

```text
3000
2222
4377
```

These ports were used during AI_NATIVE_GITHUB work:

- `3000`: Forgejo HTTP
- `2222`: Forgejo SSH
- `4377`: AgentForge HTTP

## Check commands

```sh
podman ps --format '{{.Names}} {{.Status}} {{.Ports}}'
curl -s -o /tmp/health.out -w '%{http_code}\n' --max-time 10 http://localhost:<port>/
```

## Rule

Before starting a service, check whether the planned port is already occupied or already mapped by Podman.
EOF_INNER

  cat > "$repo_dir/environment-aware/auth-and-remotes.md" <<EOF_INNER
# Auth And Remotes

Last updated: 2026-06-02

## GitHub auth

GitHub is authenticated in WSL.

Observed:

\`\`\`text
gh auth status: authenticated to github.com as hatikva
Git operations protocol: https
Token scopes include repo and workflow
\`\`\`

## Expected remote

\`\`\`text
https://github.com/pansla/$repo_slug.git
\`\`\`

## Rule

Before pushing:

1. Check \`git remote -v\`.
2. Fetch.
3. Compare local \`HEAD\` and upstream.
4. Do not assume Windows has GitHub credentials.
EOF_INNER

  cat > "$repo_dir/environment-aware/incident-log.md" <<'EOF_INNER'
# Incident Log

Newest entries first.

## 2026-06-02: Environment awareness adopted

Context:

This repo adopted the `environment-aware/` pattern from `pansla/ENVIRONMENT_AWARENESS`.

Resolution:

Future agents should read this folder before setup, build, test, container, or GitHub commands.

Reusable rule:

If environment facts change the execution path, update this incident log before finishing the task.

## 2026-06-02: WSL is the authenticated GitHub environment

Context:

Pansla repo work is performed from WSL.

Resolution:

Use WSL for GitHub operations. Do not assume Windows has matching GitHub auth.

## 2026-06-02: Prefer containers over host installs

Context:

AI_NATIVE_GITHUB work established a container-first preference.

Resolution:

Use Podman/containerized validation when a host dependency is missing.
EOF_INNER

  cat > "$repo_dir/environment-aware/update-protocol.md" <<'EOF_INNER'
# Update Protocol

Update this folder when an environment-specific fact changes the execution path.

## Record

- date
- context
- symptom
- failed assumption
- command or observation
- resolution
- reusable rule

## Do not record

- secrets
- full tokens
- private keys
- large generated logs
- runtime databases
- generated build output

## End-of-task rule

If environment friction changed the work path, update `incident-log.md` before final response.
EOF_INNER

  cat > "$repo_dir/environment-aware/templates/incident.md" <<'EOF_INNER'
# Incident Template

## YYYY-MM-DD: Short title

Context:

Symptom:

Failed assumption:

Command or observation:

Resolution:

Reusable rule:
EOF_INNER

  cat > "$repo_dir/environment-aware/templates/environment-fact.md" <<'EOF_INNER'
# Environment Fact Template

## Fact

## Scope

## Observed date

## Observed command

## Impact

## Future agent instruction
EOF_INNER
}

ensure_agents_read_rule() {
  local repo_dir="$1"
  local repo_name="$2"
  local agents="$repo_dir/AGENTS.md"

  if [ ! -f "$agents" ]; then
    cat > "$agents" <<EOF_INNER
# Agent Instructions

This repo uses environment-aware onboarding.

## Read order

Before running setup, build, test, container, or GitHub commands, read:

1. \`README.md\`
2. \`environment-aware/README.md\`
3. \`environment-aware/current-environment.md\`
4. \`environment-aware/known-constraints.md\`
5. \`environment-aware/incident-log.md\`

## Environment rule

Development is on WSL, not Windows.

GitHub is authenticated in WSL.

Prefer Podman containers over host installs unless the project owner explicitly requests a host install.

## Dynamic update rule

If an environment-specific issue changes the execution path, update \`environment-aware/incident-log.md\` before finishing the task.
EOF_INNER
    return
  fi

  if grep -q "environment-aware/" "$agents"; then
    return
  fi

  cat >> "$agents" <<'EOF_INNER'

## Environment Awareness

Before running setup, build, test, container, or GitHub commands, also read:

1. `environment-aware/README.md`
2. `environment-aware/current-environment.md`
3. `environment-aware/known-constraints.md`
4. `environment-aware/incident-log.md`

Development is on WSL, not Windows. GitHub is authenticated in WSL. Prefer Podman containers over host installs unless the project owner explicitly requests a host install.

If an environment-specific issue changes the execution path, update `environment-aware/incident-log.md` before finishing the task.
EOF_INNER
}

for repo_dir in "$ROOT"/*; do
  [ -d "$repo_dir/.git" ] || continue
  repo_name="$(basename "$repo_dir")"
  [ "$repo_name" = "$SOURCE_REPO" ] && continue
  if [ -d "$repo_dir/environment-aware" ]; then
    echo "skipped $repo_name (already has environment-aware/)"
    continue
  fi

  repo_slug="$(git -C "$repo_dir" remote get-url origin 2>/dev/null | sed -E 's#^https://github.com/pansla/##; s#^git@github.com:pansla/##; s#\.git$##')"
  [ -n "$repo_slug" ] || repo_slug="$repo_name"

  write_environment_aware_files "$repo_dir" "$repo_name" "$repo_slug"
  ensure_agents_read_rule "$repo_dir" "$repo_name"
  echo "adopted $repo_name"
done
