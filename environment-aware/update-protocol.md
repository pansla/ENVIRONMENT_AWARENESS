# Update Protocol

This protocol keeps environment notes useful instead of noisy.

## When to update

Update this folder when an environment fact changes the execution path.

Examples:

- a command failed due to a missing dependency
- a port was occupied
- auth worked only in WSL
- a container image lacked a tool
- a bind mount failed under rootless Podman
- a remote changed owner or URL

## What to record

Record:

- date
- repo or task context
- symptom
- failed assumption
- command or check that revealed it
- working alternative
- reusable rule for future agents

## What not to record

Do not record:

- secrets
- full tokens
- private credentials
- large logs
- generated runtime data
- one-off noise that did not affect execution

## Incident entry template

```md
## YYYY-MM-DD: Short title

Context:

Symptom:

Failed assumption:

Resolution:

Reusable rule:
```

## End-of-task rule

Before final response, if an environment issue changed the path, update `incident-log.md`.
