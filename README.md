# Hex Librarium

The Librarium is the central repository of all learned things within the Hex ecosystem.

It contains models of every shape and purpose—diffusion, language, restoration, synthesis, and those whose purpose is best not questioned. If it can be loaded, inferred, or otherwise persuaded to produce output, it belongs here.

The Librarium is not a tool, but a shared foundation.  
All Hex-adjacent systems draw from it. None should attempt to redefine it.

## Purpose

- Provide a single, consistent storage location for all model artifacts
- Enable reuse across containers, tools, and workflows
- Standardize structure, naming, and initialization of model volumes
- Avoid duplication, fragmentation, and the quiet horror of “final_v2_really_final.safetensors”

## Scope

The Librarium is intentionally broad:

- Stable Diffusion models (checkpoints, LoRA, embeddings)
- ESRGAN and upscaling models
- LLM weights and runtimes
- Audio, TTS, and multimodal models
- Auxiliary models (taggers, encoders, preprocessors)

If a system requires a model, it should expect to find it here.

## Philosophy

The Librarium persists. Containers do not.

Treat it as a shared artifact, not an implementation detail.
