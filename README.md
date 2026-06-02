# Environment Awareness

Environment Awareness is a small agent-onboarding pattern for recording how work actually runs in a specific development environment.

The goal is simple: future agents should not rediscover the same WSL, Podman, GitHub auth, port, dependency, permission, or network facts every time they enter a repo.

## Core idea

Every repo should be able to carry an environment-aware folder that records:

- where development actually happens
- which tools are available
- which tools must run through containers
- which credentials exist only in a specific shell
- which ports, volumes, and containers are already in use
- which failures happened and what path worked instead
- which assumptions are unsafe for future agents

This repo defines the pattern and provides a starter template.

## First rule

Do not treat environment notes as static documentation.

They are living operational memory. Update them when reality contradicts the plan.

## Intended folder in downstream repos

```text
environment-aware/
|-- README.md
|-- current-environment.md
|-- known-constraints.md
|-- tool-inventory.md
|-- container-strategy.md
|-- ports-and-services.md
|-- auth-and-remotes.md
|-- incident-log.md
|-- update-protocol.md
`-- templates/
    |-- incident.md
    `-- environment-fact.md
```

## Agent start sequence

When entering a repo that uses this pattern:

1. Read `AGENTS.md`.
2. Read `environment-aware/README.md`.
3. Read `environment-aware/current-environment.md`.
4. Read `environment-aware/known-constraints.md`.
5. Check `environment-aware/incident-log.md` for recent traps.
6. Only then run setup, build, test, container, or GitHub commands.

## What this is not

This is not a replacement for project docs, Dockerfiles, Compose files, CI, or secrets management.

It is the local operational context that helps agents choose the right path through those systems.
