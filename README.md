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

External projects should initialize the volume with the published init image as a one-shot Compose service. See [docs/consuming-librarium.md](docs/consuming-librarium.md).

Create or update the directory structure inside the volume with:

```sh
/usr/local/bin/init-librarium
```

The reusable script lives at [scripts/init-librarium.sh](scripts/init-librarium.sh). The root [compose.yml](compose.yml) includes a `librarium-init` service for local testing.

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
