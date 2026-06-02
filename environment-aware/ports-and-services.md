# Ports And Services

Last updated: 2026-06-02

## Known ports from AI_NATIVE_GITHUB work

```text
3000: Forgejo HTTP
2222: Forgejo SSH
4377: AgentForge HTTP
```

## Check commands

```sh
podman ps --format '{{.Names}} {{.Status}} {{.Ports}}'
curl -s -o /tmp/health.out -w '%{http_code}\n' --max-time 10 http://localhost:<port>/
```

## Rule

Before starting a service, check whether the planned port is already occupied or already mapped by Podman.
