# Runtime Contract

This document defines runtime boundary rules for Hex implementation projects.

## Shared-Volume Permissions

Hex components may run with container-side users or groups chosen to match a shared Docker volume contract, even when that differs from the host user's UID/GID.

Use this pattern when:

- multiple Hex containers must read and write the same named Docker volume
- host-specific UID/GID configuration would make the component harder to run consistently
- the service is intended for trusted local or private deployments

Document the chosen runtime user in the component README, including any security assumption. If a service runs as `root:root` to manage a shared volume, state that it is not intended to be exposed publicly without hardening.

## Internal Ports

Hex components should normally preserve upstream container-internal ports.

Use Compose port bindings for Hex host-facing defaults:

```yaml
ports:
  - "18384:8384/tcp"
```

In this example, `18384` is the host-facing Hex default and `8384` remains the upstream service port inside the container.

Do not change upstream internal ports just to make container log URLs match host URLs. Logs emitted inside a container may describe container-local addresses. Component documentation should tell users which host port to use.

Changing an internal port is appropriate only when there is a functional conflict inside the container or a strong integration reason that cannot be handled at the Compose boundary.

## Ephemeral Stacks

Component containers, Compose networks, and other service runtime objects should be treated as replaceable. Persistent Hex state belongs in documented named volumes or explicitly documented config directories.

Repositories that provide Windows entry points should include standard lifecycle scripts:

- `run.bat` for running the component in the foreground
- `start.bat` for starting the component as a detached service
- `stop.bat` for stopping a detached service
- `down.bat` for removing the component stack with `docker compose down`
- `update.bat` for pulling repository updates and published container images

Task-based development repositories should expose matching `task run`, `task start`, `task stop`, `task down`, and `task update` commands.

Normal run and start commands should not pull images by default. They should use the local image state so startup stays predictable and fast. Update commands should be the explicit refresh path and should run `git pull` followed by `docker compose pull`.

Down commands must not delete shared Hex volumes or persistent user-owned config unless they are clearly named and documented as destructive variants. For the Librarium sync component, taking the stack down must leave the `hex-librarium` Docker volume intact.
