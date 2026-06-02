# Environment Aware Folder

This folder records how this development environment behaves in practice.

## Purpose

Give future agents the operational context they need before running commands.

## Update trigger

Update this folder when:

- a command fails because the environment differs from assumptions
- a tool is missing from the host
- a container workaround is used
- auth works in one shell but not another
- a service or port conflict changes the plan
- a local runtime path must be ignored or preserved
- a remote changes owner, URL, protocol, or auth method

## Canonical files

- `current-environment.md`: where development happens now
- `known-constraints.md`: facts agents must not ignore
- `tool-inventory.md`: observed tools and versions
- `container-strategy.md`: when to run checks in containers
- `ports-and-services.md`: local services, ports, and health checks
- `auth-and-remotes.md`: GitHub, git, and credential facts
- `incident-log.md`: environment issues encountered and resolutions
- `update-protocol.md`: how to add new facts without making noise
