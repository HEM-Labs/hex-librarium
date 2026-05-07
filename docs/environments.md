# Environments

Hex should support local deployment first, then larger multi-node deployments as a composition of the same contracts or networked components.

## Local

A local environment runs one or more Hex projects on a single workstation.
Compared to running components directly on the host, Hex provides:

- Improved isolation and resource management
- Enhanced security through containerization
- Simplified deployment and management
- Updates and recreation of environments without losing models or config
- Opinionated defaults built around targeted use cases

## Multi-Node

Hex provides features that are also useful for smaller lab environments and situations where multiple nodes are available:

- Distributing or orchestrating workloads across multiple nodes
- Synchronization of model data, config or output across nodes
- Streamlined backup of user data, separated from runtime components
