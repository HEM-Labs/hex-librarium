# Naming

## Repositories

- Use the `hex-` prefix for implementation repos.
- Use lowercase kebab-case.

## Docker Resources

- Use lowercase kebab-case.
- Prefix shared resources with `hex-`.
- Keep stable contract names short and explicit.

Examples:

- `hex-librarium`
- `hex-librarium-init`
- `hex-librarium-syncthing`

## Filesystem Paths

- Use lowercase kebab-case.
- Mount shared Hex resources under `/hex`.
- Use semantic names for shared directories, not tool-specific folder names.

## Runtime Commands

- Use the bare action name for interactive foreground commands.
- Use `start-` and `end-` prefixes for detached service lifecycle commands.
- Keep the subject name consistent across foreground and service commands.

Examples:

- `sync` runs syncing interactively in the foreground.
- `start-sync` starts syncing as a detached service.
- `end-sync` stops the detached syncing service.
