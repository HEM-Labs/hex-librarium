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
