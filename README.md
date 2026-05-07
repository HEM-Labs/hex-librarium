# Hex

This repository is the architecture map and documentation root for the Hex ecosystem.

Hex is a local-first AI workspace made from focused repositories that share stable contracts for model storage, containers, naming, releases, and runtime state.

## Start Here

- [Project principles](docs/principles.md) — design goals and integration philosophy.
- [Contracts](docs/contracts/README.md) - compliance rules for implementation projects.
- [Persistence and state](docs/persistence-and-state.md) — where state belongs and why.
- [Naming](docs/naming.md) — repository, Docker, and filesystem names.
- [Environments](docs/environments.md) — local and multi-node deployment shape.
- [Release process](docs/release-process.md) — release, changelog, and container publishing expectations.
- [Glossary](docs/glossary.md) — shared terms.

## Core Shape

Hex is not a monorepo or a single application.  
Component repositories implement specific responsibilities and integrate through documented contracts.

### Librarium

The librarium is the local model repository for Hex, providing a shared location for model artifacts and data.
Models added to the librarium are available to other components and can be optionally synched with other
nodes for collaboration and sharing.

| Repository                                                                     | Purpose                                                                                      |
|--------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| [hex-librarium-init](https://github.com/HEM-Labs/hex-librarium-init)           | (Infra) Initializer for the `hex-librarium` volume                                           |
| [hex-librarium-syncthing](https://github.com/HEM-Labs/hex-librarium-syncthing) | (Infra) Synchronize the librarium with other nodes using [Syncthing](https://syncthing.net/) |

