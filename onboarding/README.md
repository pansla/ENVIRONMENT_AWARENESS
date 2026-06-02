# Onboarding

This repo is a reusable pattern for improving AI-agent efficiency across repositories.

## Project in one sentence

Capture environment-specific operational facts in a structured, dynamic folder so future agents avoid repeated setup mistakes.

## Why it exists

Agents often lose time because they assume:

- a dependency is installed on the host
- GitHub auth works in every shell
- a port is available
- Docker behavior matches Podman behavior
- bind mounts work the same in rootless containers
- generated runtime files are safe to commit

Those assumptions are often false. This pattern gives agents a place to record the truth.

## Adoption model

Downstream repos can copy the `environment-aware/` folder and keep it current.

The folder should be treated as canonical operational memory, while generated logs, runtime data, and secrets remain uncommitted.

## Minimum useful version

A repo has a useful environment-aware setup when it contains:

- `environment-aware/README.md`
- `environment-aware/current-environment.md`
- `environment-aware/known-constraints.md`
- `environment-aware/incident-log.md`
- `environment-aware/update-protocol.md`
