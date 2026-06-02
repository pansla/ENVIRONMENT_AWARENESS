# Container Strategy

Last updated: 2026-06-02

## Default

Prefer Podman for containerized development and validation.

## Why

This avoids host installs and makes future agent runs more reproducible.

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

Some language images may not include formatting or auxiliary tools. If that happens:

1. Do not install on the host by default.
2. Check whether a different container image already exists locally.
3. If an existing host tool is used as fallback, record that fact.
4. Update `incident-log.md`.
