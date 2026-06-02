# Agent Instructions

This repository defines an environment-aware onboarding pattern.

## Operating rule

Before editing or running project commands, read:

1. `README.md`
2. `onboarding/README.md`
3. `environment-aware/README.md`
4. `environment-aware/current-environment.md`
5. `environment-aware/known-constraints.md`
6. `environment-aware/update-protocol.md`

## Dynamic context rule

If you hit an environment-specific problem, update `environment-aware/incident-log.md` before finishing the task.

Examples:

- dependency missing on host
- tool only authenticated in WSL
- container image missing a component
- port already occupied
- rootless Podman bind-mount permission issue
- remote URL changed after GitHub org transfer
- command works in container but not on host

## Host discipline

Prefer containerized checks when a repo declares container-first development.

Do not install host dependencies unless the project owner explicitly asks for that.

## GitHub discipline

Record where GitHub is authenticated. For this environment, the known default is:

```text
GitHub CLI and GitHub git auth are available in WSL, not Windows.
```
