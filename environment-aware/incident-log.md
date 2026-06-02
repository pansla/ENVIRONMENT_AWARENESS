# Incident Log

Record environment-specific friction here.

Use newest entries at the top.

## 2026-06-02: SQLite CLI missing on host

Context: validating `AI_NATIVE_GITHUB` SQLite migrations.

Symptom:

```text
sqlite3 not installed; skipped migration apply check
```

Resolution:

Do not install `sqlite3` on the host by default. Run migration validation through a container or through Rust tests using SQLite bindings.

Reusable rule:

```text
If a host CLI is missing and the project is container-first, add a containerized validation path.
```

## 2026-06-02: Rootless Podman bind mount not writable

Context: starting Forgejo rootless container for `AI_NATIVE_GITHUB`.

Symptom:

```text
/var/lib/gitea/git is not writable
docker setup failed
```

Resolution:

Use a Podman named volume for Forgejo writable state instead of a WSL bind mount.

## 2026-06-02: Rust container image missing rustfmt

Context: formatting AgentForge Rust code.

Symptom:

```text
cargo-fmt is not installed for the toolchain
```

Resolution:

Used existing host `rustfmt` because it was already installed. No host install was performed.

Future option:

Use a Rust container image that includes rustfmt, or build a small project dev image.

## 2026-06-02: localhost versus 127.0.0.1 smoke check

Context: AgentForge smoke test in Podman.

Symptom:

Initial `curl http://localhost:4377/health` failed, while `curl http://127.0.0.1:4377/health` succeeded.

Resolution:

Use explicit IPv4 loopback for local smoke tests when `localhost` behaves inconsistently.

## 2026-06-02: GitHub org transfer remote update

Context: `AI_NATIVE_GITHUB` moved from `hatikva` to `pansla`.

Symptom:

Local `origin` still pointed to:

```text
https://github.com/hatikva/AI_NATIVE_GITHUB.git
```

Resolution:

Updated origin to:

```text
https://github.com/pansla/AI_NATIVE_GITHUB.git
```
