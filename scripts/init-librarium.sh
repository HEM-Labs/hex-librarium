#!/bin/sh
set -eu

LIBRARIUM_ROOT="${HEX_LIBRARIUM:-/hex/librarium}"

if [ -t 1 ] && [ "${NO_COLOR:-}" = "" ]; then
  BOLD="$(printf '\033[1m')"
  DIM="$(printf '\033[2m')"
  GREEN="$(printf '\033[32m')"
  CYAN="$(printf '\033[36m')"
  RESET="$(printf '\033[0m')"
else
  BOLD=""
  DIM=""
  GREEN=""
  CYAN=""
  RESET=""
fi

banner() {
  printf '%s\n' ""
  printf '%s\n' "${RESET}${BOLD}Hex Librarium${RESET} ${DIM}volume initializer${RESET}"
  printf '%s\n' "${DIM}root: ${LIBRARIUM_ROOT}${RESET}"
  printf '\n'
}

ensure_dir() {
  path="${LIBRARIUM_ROOT}/$1"

  if [ -d "$path" ]; then
    printf '%s %s\n' "${CYAN}[=]${RESET}" "$path"
  else
    mkdir -p "$path"
    printf '%s %s\n' "${GREEN}[+]${RESET}" "$path"
  fi
}

banner

for dir in \
  "diffusion/checkpoint" \
  "diffusion/vae" \
  "diffusion/vae-approx" \
  "diffusion/lora" \
  "diffusion/lycoris" \
  "diffusion/embedding" \
  "diffusion/hypernetwork" \
  "diffusion/controlnet" \
  "diffusion/ip-adapter" \
  "diffusion/motion-module" \
  "diffusion/clip-vision" \
  "diffusion/text-encoder" \
  "diffusion/diffusion-model" \
  "diffusion/component" \
  "diffusion/scheduler" \
  "image/upscaler" \
  "image/upscaler/esrgan" \
  "image/upscaler/real-esrgan" \
  "image/upscaler/swinir" \
  "image/upscaler/dat" \
  "image/upscaler/plksr" \
  "image/upscaler/rcan" \
  "image/upscaler/ldsr" \
  "image/upscaler/scunet" \
  "image/restoration" \
  "image/restoration/codeformer" \
  "image/restoration/gfpgan" \
  "image/background-removal" \
  "image/segmentation" \
  "image/segmentation/ultralytics" \
  "image/segmentation/sam" \
  "image/segmentation/clipseg" \
  "image/detection" \
  "image/detection/ultralytics" \
  "image/detection/onnx" \
  "image/depth" \
  "image/pose" \
  "image/pose/dwpose" \
  "image/pose/openpose" \
  "image/pose/mediapipe" \
  "image/face" \
  "image/face/insightface" \
  "image/face/mediapipe" \
  "image/tagging" \
  "image/tagging/deepbooru" \
  "image/captioning" \
  "image/captioning/blip" \
  "language/llm" \
  "language/embedding" \
  "language/reranker" \
  "language/tokenizer" \
  "language/grammar" \
  "audio/speech-to-text" \
  "audio/text-to-speech" \
  "audio/voice-conversion" \
  "audio/music-generation" \
  "audio/separation" \
  "video/generation" \
  "video/interpolation" \
  "video/tracking" \
  "video/segmentation" \
  "multimodal/vision-language" \
  "multimodal/image-text" \
  "multimodal/audio-language" \
  "multimodal/clip" \
  "safety/classifier" \
  "safety/filter" \
  "manifest"
do
  ensure_dir "$dir"
done

printf '\n%s\n' "${DIM}[+] created  [=] already present${RESET}"

exec "$@"
