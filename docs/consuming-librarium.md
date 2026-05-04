# Consuming Hex Librarium

External Hex projects should consume the Librarium through the shared Docker volume and the published initializer image.

The shared volume is intentionally declared as external. That lets multiple independent Compose projects attach to the same Docker volume, but it also means Compose will not create the volume automatically.

Every tool or setup script that depends on the Librarium should ensure the volume exists before running Compose:

```sh
docker volume create hex-librarium
```

This command is idempotent. It succeeds whether the volume is new or already present.

## Recommended Compose Pattern

Use the initializer as a one-shot service. This keeps application containers clean and avoids wrapping their entrypoints.

```yaml
services:
  init-librarium:
    image: ghcr.io/hem-labs/hex-librarium-init:0.1.0
    volumes:
      - hex-librarium:/hex/librarium
    restart: "no"

  app:
    depends_on:
      init-librarium:
        condition: service_completed_successfully
    volumes:
      - hex-librarium:/hex/librarium
    environment:
      HEX_LIBRARIUM: /hex/librarium

volumes:
  hex-librarium:
    name: hex-librarium
    external: true
```

The initializer is idempotent. It creates missing directories and exits without deleting, renaming, or overwriting existing content.

## Pinning Versions

Use a semver tag for normal project manifests:

```yaml
image: ghcr.io/hem-labs/hex-librarium-init:0.1.0
```

Use an image digest when a deployment needs exact reproducibility:

```yaml
image: ghcr.io/hem-labs/hex-librarium-init@sha256:<digest>
```

Avoid downloading the script from a raw GitHub URL during image builds. Raw URLs are harder to version, audit, cache, and reproduce.

## Embedding The Initializer

Most projects should use the one-shot service. If a project needs the initializer inside its own image, copy it from the published OCI image:

```dockerfile
COPY --from=ghcr.io/hem-labs/hex-librarium-init:0.1.0 \
  /usr/local/bin/init-librarium \
  /usr/local/bin/init-librarium
```

Then call it from the project image's own startup logic.

## Publishing

The initializer image is published from the `librarium-init` component repository. While this meta repository still contains the component source under `components/librarium-init`, treat that directory as the future repository root for component-level releases.

Create and push a semver tag to publish a release image:

```sh
git tag v0.1.0
git push origin v0.1.0
```

The workflow publishes:

- `ghcr.io/hem-labs/hex-librarium-init:0.1.0`
- `ghcr.io/hem-labs/hex-librarium-init:0.1`
- `ghcr.io/hem-labs/hex-librarium-init:sha-<commit>`

The configured package name uses the lowercase GitHub repository owner because GHCR image names must be lowercase.

For unauthenticated external projects, make the GHCR package public after the first publish. Private packages require downstream projects to authenticate to GHCR before pulling the image.
