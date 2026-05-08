# Hex Contracts

Contracts are the compliance surface for Hex implementation repositories.

Use these documents when you need the rule without the explanation.

## Contract Documents

- [Docker Volume Contracts](volumes.md) - shared volumes, mount paths, and initializer behavior.
- [Librarium Contract](librarium.md) - canonical model volume structure and model placement rules.
- [Image Versioning Contract](image-versioning.md) - container image names and tags.

## General Rules

- Integrate through documented contracts, not direct coupling between repositories.
- Keep shared names stable once published.
- Prefer explicit Docker volumes, bind mounts, environment variables, networks, labels, and image tags over hidden host state.
- Preserve user-owned content unless a destructive command is explicit.
- Link explanatory documentation from contract documents instead of repeating the rationale.
