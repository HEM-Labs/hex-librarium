# Image Versioning Contract

These rules define image naming and versioning for Hex component containers.

For release process details, see [Release Process](../release-process.md).

## Image Names

- Publish component images to the GitHub Container Registry.
- Use the owning repository path under `ghcr.io/hem-labs`.
- Use lowercase kebab-case image names.
- Keep the image name aligned with the repository name.

Examples:

- `ghcr.io/hem-labs/hex-librarium-init`
- `ghcr.io/hem-labs/hex-librarium-syncthing`

## Tags

- Publish semver release tags:
  - `X.Y.Z`
  - `X.Y`
- Publish `latest` for the latest stable release.
- Publish `sha-<commit>` for traceability.
- Use image digests when exact reproducibility is required.

Digest form:

```text
ghcr.io/hem-labs/<repo>@sha256:<digest>
```
