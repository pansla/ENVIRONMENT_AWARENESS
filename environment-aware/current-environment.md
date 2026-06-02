# Current Environment

Last updated: 2026-06-02

## Primary development environment

Development is on WSL, not Windows.

```text
OS context: WSL Linux shell
Repo root convention: ~/repos/pansla/<repo>
GitHub auth context: WSL
Container runtime: Podman
Preferred container orchestration: podman-compose
```

## Repo location convention

Pansla repositories live under:

```text
~/repos/pansla
```

## Known adjacent repo example

`AI_NATIVE_GITHUB` currently lives at:

```text
~/repos/pansla/AI_NATIVE_GITHUB
```

## Operating preference

When a project can run in containers, prefer Podman containers over host installs.
