# Hex Librarium Contract

This document defines the shared model volume used by Hex projects.

## Canonical Interface

- Docker volume name: `hex-librarium`
- Container mount path: `/hex/librarium`
- Environment variable: `HEX_LIBRARIUM=/hex/librarium`

All Hex containers that need model artifacts should mount the named volume at the same path.

```yaml
volumes:
  hex-librarium:
    name: hex-librarium

services:
  example:
    volumes:
      - hex-librarium:/hex/librarium
    environment:
      HEX_LIBRARIUM: /hex/librarium
```

The directory structure is created inside the mounted volume by [scripts/init-librarium.sh](../scripts/init-librarium.sh).

Containers can copy this script into an image and use it as an entrypoint or call it before launching the project-specific process:

```dockerfile
COPY scripts/init-librarium.sh /usr/local/bin/init-librarium
RUN chmod +x /usr/local/bin/init-librarium
ENTRYPOINT ["init-librarium"]
```

The script is idempotent. It only creates missing directories and does not remove, rename, or overwrite existing content.

## Scope

The Librarium stores reusable model artifacts and closely-bound model metadata.

It may contain:

- model weights
- model configs required to load those weights
- tokenizers, vocabularies, merges, processors, and schedulers
- sidecar metadata describing source, license, version, checksum, trigger words, or compatibility
- small preview images that identify a model

It must not contain:

- generated outputs
- training datasets
- transient caches
- application settings
- virtual environments
- source checkouts
- logs
- databases
- secrets, tokens, or private credentials

Downloaded package-manager caches, such as Hugging Face cache directories, should stay outside the Librarium unless a project deliberately promotes specific artifacts into the canonical structure.

## Naming Rules

- Directory names use lower kebab-case.
- Directory names are singular nouns where practical.
- Directories are grouped by the contract a model fulfills, not by the tool that first created the folder.
- Backend or runtime-specific subfolders may be used under a contract directory when tools cannot safely scan mixed model formats.
- Vendor-specific names belong below a canonical contract directory, not at the top level.
- Model filenames should keep their upstream names unless there is a strong reason to rename them.
- Sidecar metadata should use the same base filename as the artifact where practical.

Examples:

- `diffusion/checkpoint/dreamshaper-xl.safetensors`
- `diffusion/lora/character-style.safetensors`
- `language/llm/mistral-7b-instruct-q4-k-m.gguf`
- `image/upscaler/real-esrgan/real-esrgan-x4plus.pth`
- `image/detection/ultralytics/face_yolov8n.pt`
- `image/segmentation/ultralytics/person_yolov8n-seg.pt`

## Directory Structure

```text
/hex/librarium
  diffusion/
    checkpoint/
    vae/
    vae-approx/
    lora/
    lycoris/
    embedding/
    hypernetwork/
    controlnet/
    ip-adapter/
    motion-module/
    clip-vision/
    text-encoder/
    diffusion-model/
    component/
    scheduler/
  image/
    upscaler/
      esrgan/
      real-esrgan/
      swinir/
      dat/
      plksr/
      rcan/
      ldsr/
      scunet/
    restoration/
      codeformer/
      gfpgan/
    background-removal/
    segmentation/
      ultralytics/
      sam/
      clipseg/
    detection/
      ultralytics/
      onnx/
    depth/
    pose/
      dwpose/
      openpose/
      mediapipe/
    face/
      insightface/
      mediapipe/
    tagging/
      deepbooru/
    captioning/
      blip/
  language/
    llm/
    embedding/
    reranker/
    tokenizer/
    grammar/
  audio/
    speech-to-text/
    text-to-speech/
    voice-conversion/
    music-generation/
    separation/
  video/
    generation/
    interpolation/
    tracking/
    segmentation/
  multimodal/
    vision-language/
    image-text/
    audio-language/
    clip/
  safety/
    classifier/
    filter/
  manifest/
```

## Diffusion

`diffusion/checkpoint` is for bundled primary diffusion model checkpoints. These are files a UI loads as the main generation model, often containing some combination of denoiser, text encoder, VAE, config, and metadata. Examples include Stable Diffusion 1.x, SDXL, SD3, FLUX packaged checkpoints, and Stable Video Diffusion checkpoints.

`diffusion/vae` is for full variational autoencoder weights used with diffusion pipelines.

`diffusion/vae-approx` is for lightweight approximate VAE models, such as A1111/ReForge `VAE-approx` artifacts used for previews or fast latent decoding.

`diffusion/lora` is for LoRA adapter weights.

`diffusion/lycoris` is for LyCORIS adapter weights.

`diffusion/embedding` is for textual inversion embeddings and similar prompt-token embeddings.

`diffusion/hypernetwork` is for Stable Diffusion hypernetwork weights.

`diffusion/controlnet` is for ControlNet model weights.

`diffusion/ip-adapter` is for IP-Adapter model weights.

`diffusion/motion-module` is for AnimateDiff-style motion modules and related temporal diffusion adapters.

`diffusion/clip-vision` is for CLIP vision models used by diffusion workflows, commonly by IP-Adapter or image prompt pipelines.

`diffusion/text-encoder` is for diffusion text encoders, including CLIP, T5, and similar encoders that are part of generation pipelines.

`diffusion/diffusion-model` is for standalone denoiser or backbone weights, including UNet, DiT, MMDiT, transformer, and similar architecture-specific model files.

`diffusion/component` is for diffusion pipeline components that are reusable but do not fit a more specific directory yet. This is the semantic home for vague tool folders such as A1111/ReForge `Components`; prefer a more specific directory when one exists.

`diffusion/scheduler` is for reusable scheduler definitions or scheduler-side artifacts when a project needs to share them.

## Image

`image/upscaler` is for image upscaling models. Backend subfolders keep scanner behavior predictable:

- `image/upscaler/esrgan` for ESRGAN-compatible models
- `image/upscaler/real-esrgan` for RealESRGAN models
- `image/upscaler/swinir` for SwinIR models
- `image/upscaler/dat` for DAT models
- `image/upscaler/plksr` for PLKSR models
- `image/upscaler/rcan` for RCAN models
- `image/upscaler/ldsr` for LDSR models
- `image/upscaler/scunet` for ScuNET models

`image/restoration` is for face and image restoration models. Use `image/restoration/codeformer` for CodeFormer and `image/restoration/gfpgan` for GFPGAN.

`image/background-removal` is for matting and background removal models.

`image/detection` is for models that return bounding boxes or object regions. Use `image/detection/ultralytics` for YOLO/Ultralytics `.pt` models such as ADetailer `face_yolov8n.pt` and `hand_yolov8n.pt`. Use `image/detection/onnx` for ONNX detector models.

`image/segmentation` is for models that return masks or instance silhouettes. Use `image/segmentation/ultralytics` for YOLO segmentation models such as `person_yolov8n-seg.pt`, `image/segmentation/sam` for Segment Anything models, and `image/segmentation/clipseg` for CLIPSeg models.

`image/depth` is for depth estimation models and depth preprocessors.

`image/pose` is for body, hand, face landmark, and pose estimation models. Use `image/pose/dwpose`, `image/pose/openpose`, or `image/pose/mediapipe` when the backend matters.

`image/face` is for face analysis, recognition, alignment, swap, and identity models. Use `image/face/insightface` for InsightFace models and `image/face/mediapipe` for Mediapipe face models.

`image/tagging` is for image taggers and classifiers used to label image content. Use `image/tagging/deepbooru` for DeepDanbooru and torch-deepdanbooru models.

`image/captioning` is for image captioning and interrogation models. Use `image/captioning/blip` for BLIP captioning models.

## Language

`language/llm` is for text generation model weights, including GGUF and transformer model directories.

`language/embedding` is for text embedding models used for retrieval or semantic search.

`language/reranker` is for cross-encoder or reranking models.

`language/tokenizer` is for shared tokenizer artifacts when they are stored independently of a model directory.

`language/grammar` is for grammar files and constrained decoding definitions.

## Audio

`audio/speech-to-text` is for transcription and ASR models.

`audio/text-to-speech` is for TTS models.

`audio/voice-conversion` is for voice conversion and voice cloning models.

`audio/music-generation` is for music and audio generation models.

`audio/separation` is for source separation and stem-splitting models.

## Video

`video/generation` is for video-native generation models that are not better represented as diffusion checkpoints or motion modules.

`video/interpolation` is for frame interpolation models.

`video/tracking` is for object, pose, or identity tracking models.

`video/segmentation` is for video segmentation models.

## Multimodal

`multimodal/vision-language` is for models whose primary interface combines visual and language understanding.

`multimodal/image-text` is for image-text encoders, retrievers, and contrastive models.

`multimodal/audio-language` is for audio-language models.

`multimodal/clip` is for standalone CLIP-family models that are not specifically diffusion text encoders or diffusion CLIP vision components.

## Safety

`safety/classifier` is for moderation, safety, quality, or policy classifiers.

`safety/filter` is for reusable filtering models or model artifacts used to block or transform unsafe content.

## Manifest

`manifest` is for repository-level indexes and compatibility metadata. This is the right place for generated indexes, checksums, known aliases, license summaries, and tool adapter metadata.

## Tool Adapter Notes

Project-specific adapters should translate from this structure to the layout expected by a tool. Do not rename the shared directories to match a single tool's conventions. The Librarium is the stable Hex contract; tool layouts are integration details.

For A1111/ReForge-style layouts:

```text
models/Stable-diffusion      -> diffusion/checkpoint
models/VAE                   -> diffusion/vae
models/VAE-approx            -> diffusion/vae-approx
models/Lora                  -> diffusion/lora
models/hypernetworks         -> diffusion/hypernetwork
models/ControlNet            -> diffusion/controlnet
models/text_encoder          -> diffusion/text-encoder
models/text_encoders         -> diffusion/text-encoder
models/Components            -> diffusion/component
models/adetailer             -> image/detection/ultralytics and image/segmentation/ultralytics
models/ESRGAN                -> image/upscaler/esrgan
models/RealESRGAN            -> image/upscaler/real-esrgan
models/SwinIR                -> image/upscaler/swinir
models/DAT                   -> image/upscaler/dat
models/PLKSR                 -> image/upscaler/plksr
models/RCAN                  -> image/upscaler/rcan
models/LDSR                  -> image/upscaler/ldsr
models/ScuNET                -> image/upscaler/scunet
models/Codeformer            -> image/restoration/codeformer
models/GFPGAN                -> image/restoration/gfpgan
models/deepbooru             -> image/tagging/deepbooru
models/torch_deepdanbooru    -> image/tagging/deepbooru
models/BLIP                  -> image/captioning/blip
models/CLIP                  -> multimodal/clip or diffusion/text-encoder, depending on use
models/insightface           -> image/face/insightface
models/svd                   -> diffusion/checkpoint
models/diffusers             -> semantic destination based on contained components
```

For ComfyUI Impact/Subpack-style detector layouts:

```text
models/ultralytics/bbox      -> image/detection/ultralytics
models/ultralytics/segm      -> image/segmentation/ultralytics
ultralytics_bbox             -> image/detection/ultralytics
ultralytics_segm             -> image/segmentation/ultralytics
```

ADetailer can scan extra `.pt` model paths, while ComfyUI Impact/Subpack distinguishes `bbox` and `segm` models. Keep the Librarium split by capability, then let the A1111/ReForge adapter expose both Ultralytics directories to ADetailer and the ComfyUI adapter expose them separately.
