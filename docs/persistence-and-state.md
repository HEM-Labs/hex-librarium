# Hex Persistence and State Management

Persistent state belongs in named volumes or explicit bind mounts.
Containers can be recreated, upgraded, or replaced without losing model artifacts or user data.

Generally, application state falls into one of these patterns:

### Ephemeral

Temporary, volatile, lost on restart, gone with the wind.

Hex tries to encapsulate as much of the ephemeral state within component containers to help keep
execution clean, lean, and isolated.

- Application state
- I/O caches
- OS/Container functions

### Configuration

Provided configuration that shapes the behavior of a component, bound to a folder in the host OS.

The typical approach for configuration is to export configuration as bind-mounts in the project
folder for easy management and possible versioning of configuration files.

The typical pattern is that a component project will contain one or more `x-config` folders in project root.

- Are not tracked by project version control
- Can still be versioned by creating an inner repository or linking to an external repository
- Will have a default configuration generated on the first run if no user-supplied config is found
- May contain sensitive information such as certificates or keys
- Do not benefit from mmap optimization — use the volume pattern for large files.

### Volumes

Shared, named volumes mounted directly into each component and **not** bound to the host OS.

- Examples:
    - Hex Librarium — Shared volume for models, weights, etc.
- Can be shared between components without duplicating large files
- By not binding to the host filesystem `mmap` can provide 10-20x faster load times for large files

### Caches

Similar to volumes, but not user-facing and considered partially ephemeral.

- Examples:
    - Huggingface cache
    - Torch cache
- Caches should be clearable without breaking a component's functionality.
- Some tools, like A1111, download smaller models such as taggers/upscalers into an OS-level cache.
    - Where possible, Hex should redirect commonly used models to volumes instead, but retain the caches as a fallback option for new models.
- Managed through named volumes to provide run-to-run persistance.
