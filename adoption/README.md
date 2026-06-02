# Adoption

Copy `environment-aware/` into a downstream repo.

Then add this read rule to the repo's `AGENTS.md`:

```md
Before running setup, build, test, container, or GitHub commands, read:

1. `environment-aware/README.md`
2. `environment-aware/current-environment.md`
3. `environment-aware/known-constraints.md`
4. `environment-aware/incident-log.md`
```

## Recommended first downstream adoption

Apply this pattern to `AI_NATIVE_GITHUB` before continuing later phases.

That repo has already produced useful incidents around:

- WSL-only GitHub auth
- missing host `sqlite3`
- rootless Podman volume permissions
- container image tool gaps
- IPv4 loopback smoke tests
