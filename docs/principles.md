# Hex Project Principles

## Opinionated Design

Hex components should take an opinionated view to defaults and dependencies.
A lot of tools are designed to be widely compatible, but often trade optimization for flexibility.
Hex components should aim to optimize around a particular use case, even if that use case is just being 'general'.
For example, Hex may provide component variants such as:

* `hex-a1111-general` - Aimed to be generally useful, baseline optimization.
* `hex-a1111-flux` - Optimized for Flux architecture, and using Flux attention.
* `hex-a1111-sageattention-sdxl` - Optimized for SDXL architecture, and using sage attention.

## Contracts Over Coupling

Components must integrate through stable, documented contracts: Docker volume names, mount paths, environment variables, network names, labels, directory layouts, and published images.

## Containers Are Replaceable

Persistent state belongs in named volumes or explicit bind mounts.
Containers can be recreated, upgraded, or replaced without losing model artifacts or user data.
See [Persistence and State Management](persistence-and-state.md) for specifics on how to manage persistent state.

## Shared Artifacts Need Shared Names

Common resources use canonical names. For example, the Librarium volume is `hex-librarium` and is mounted at `/hex/librarium`.

## Idempotent Setup

Initializers and setup scripts should be safe to run more than once.
They may create missing state, but should not delete, rename, or overwrite user content without an explicit destructive command.

## Upstream Compatibility

Hex adapters should translate Hex contracts into upstream tool layouts.

The shared contract should not be renamed to match one frontend's preferred structure.
I.e., Librarium content should be symlinked into a tool's local folder structure, rather than restructure the librarium itself.

The same rule applies to container images. Prefer preserving upstream container internals and using Compose bindings, environment variables, or adapter scripts at the Hex boundary. For example, host-facing ports should usually be mapped at the Compose layer instead of changing the port an upstream service listens on inside its container.
