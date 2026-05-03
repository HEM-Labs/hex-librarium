# Hex Librarium

The Librarium is the central repository of all learned things within the Hex ecosystem.

It contains models of every shape and purpose: diffusion, language, restoration, synthesis, and those whose purpose is best not questioned. If it can be loaded, inferred, or otherwise persuaded to produce output, it belongs here.

The Librarium is not a tool, but a shared foundation.  
All Hex-adjacent systems draw from it. None should attempt to redefine it.

## Contract

- Docker volume name: `hex-librarium`
- Container mount path: `/hex/librarium`
- Environment variable: `HEX_LIBRARIUM=/hex/librarium`
- Directory names use singular lowercase kebab-case

The canonical volume contract and directory structure are defined in [docs/librarium-contract.md](docs/librarium-contract.md).

## Consuming Projects

External Docker projects should import the published initializer image as a one-shot Compose service:

```yaml
services:
  init-librarium:
    image: ghcr.io/hex/librarium-init:0.1.0
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

Because the volume is external and shared across projects, Compose will not create it automatically. Tools that depend on the Librarium should create it during startup or setup:

```sh
docker volume create hex-librarium
```

The command is idempotent. It prints the existing volume name if the volume already exists.

See [docs/consuming-librarium.md](docs/consuming-librarium.md) for version pinning, GHCR notes, and alternative embedding patterns. The reusable script source lives at [scripts/init-librarium.sh](scripts/init-librarium.sh).

## Purpose

- Provide a single, consistent storage location for all model artifacts
- Enable reuse across containers, tools, and workflows
- Standardize structure, naming, and initialization of model volumes
- Avoid duplication, fragmentation, and the quiet horror of `final_v2_really_final.safetensors`

## Scope

The Librarium is intentionally broad:

- Diffusion models: checkpoints, VAEs, LoRAs, embeddings, ControlNets, IP-Adapters, motion modules, text encoders, diffusion backbones
- Image models: upscalers, restoration, detection, segmentation, depth, pose, face analysis, tagging, captioning
- Language models: LLMs, embedding models, rerankers, tokenizers, grammars
- Audio models: speech-to-text, text-to-speech, voice conversion, music generation
- Video and multimodal models
- Auxiliary models: safety classifiers, filters, preprocessors

If a system requires a reusable model artifact, it should expect to find it here.

## Philosophy

The Librarium persists. Containers do not.

Treat it as a shared artifact, not an implementation detail.
