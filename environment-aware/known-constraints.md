# Known Constraints

Last updated: 2026-06-02

## WSL versus Windows

GitHub is authenticated in WSL. Do not assume Windows has the same GitHub auth.

## Host dependency discipline

Do not install dependencies directly on the host unless explicitly requested.

Prefer:

- existing tools already present
- Podman containers
- project-declared dev containers

## Container behavior

Rootless Podman bind mounts may hit ownership problems.

If a containerized service needs persistent writable state, prefer a Podman named volume unless the repo explicitly requires a bind mount.

## Tool assumptions

Do not assume these are installed on the host:

- `sqlite3`
- `ripgrep`
- project-specific CLIs

If a check needs them, document either the container image used or the host tool version observed.

## Port assumptions

Do not assume common ports are free.

Check before binding:

- `3000`
- `2222`
- `4377`
