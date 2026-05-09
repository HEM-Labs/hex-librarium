# Docker Volume Contracts

These rules define the shared Docker volume contract for Hex components.

For rationale and state categories, see [Persistence and State Management](../persistence-and-state.md).

## Known Volumes

| Volume          | Mount Path       | Purpose                                                         |
|-----------------|------------------|-----------------------------------------------------------------|
| `hex-librarium` | `/hex/librarium` | Shared model artifacts. See [Librarium Contract](librarium.md). |

## Rules

- Use named Docker volumes for shared Hex state.
- Use lowercase kebab-case for shared volume names.
- Prefix shared Hex volumes with `hex-`.
- Mount shared Hex resources under `/hex`.
- Create required shared volumes before starting dependent services.
- Initializers may create missing directories inside a volume.
- Initializers must not delete, rename, or overwrite existing user content without an explicit destructive command.
- Components that manage shared volumes may run with container-side ownership that matches the shared volume contract instead of the host user's UID/GID. Document this in the component README when it is required.
