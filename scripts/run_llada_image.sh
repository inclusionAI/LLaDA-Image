#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON="${PYTHON:-python}"
OUTPUT_ROOT="${OUTPUT_ROOT:-$REPO_ROOT/outputs}"
MODEL_PATH="${MODEL_PATH:-}"
HF_REPO_ID="${HF_REPO_ID:-}"
HF_REVISION="${HF_REVISION:-main}"
DEVICE="${DEVICE:-cuda}"
HEIGHT="${HEIGHT:-1024}"
WIDTH="${WIDTH:-1024}"
STEPS="${STEPS:-50}"
GUIDANCE_SCALE="${GUIDANCE_SCALE:-5.0}"
SEED="${SEED:-42}"

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Usage: GENERATION_MODE={text|vq|editing} $0 [PROMPT] [INPUT_IMAGE]"
    echo "  Text-to-image: GENERATION_MODE=text $0 \"a red fox in the snow\""
    echo "  MLLM VQ-conditioned: GENERATION_MODE=vq $0 \"a red fox in the snow\""
    echo "  Image editing: GENERATION_MODE=editing $0 \"turn it into a watercolor painting\" /path/to/input.png"
    exit 0
fi

PROMPT="${1:-a cinematic photograph of a red fox in the snow}"
INPUT_IMAGE="${2:-}"
GENERATION_MODE="${GENERATION_MODE:-text}"
RUN_OUTPUT="$OUTPUT_ROOT/images/$(date +%Y%m%d-%H%M%S)"

case "$GENERATION_MODE" in
    text|vq)
        if [[ -n "$INPUT_IMAGE" ]]; then
            echo "INPUT_IMAGE must be omitted when GENERATION_MODE=$GENERATION_MODE" >&2
            exit 2
        fi
        ;;
    editing)
        if [[ -z "$INPUT_IMAGE" ]]; then
            echo "INPUT_IMAGE is required when GENERATION_MODE=$GENERATION_MODE" >&2
            exit 2
        fi
        ;;
    *)
        echo "GENERATION_MODE must be text, vq, or editing" >&2
        exit 2
        ;;
esac

export PYTHONPATH="$REPO_ROOT${PYTHONPATH:+:$PYTHONPATH}"

if [[ -z "$MODEL_PATH" ]]; then
    if [[ -z "$HF_REPO_ID" ]]; then
        echo "Set HF_REPO_ID=<namespace>/<model-repo> or MODEL_PATH=/path/to/model." >&2
        exit 2
    fi
    MODEL_PATH="$("$PYTHON" - "$HF_REPO_ID" "$HF_REVISION" <<'PY'
import sys

from huggingface_hub import snapshot_download

print(snapshot_download(repo_id=sys.argv[1], revision=sys.argv[2]))
PY
)"
fi

if [[ ! -f "$MODEL_PATH/model_index.json" ]]; then
    echo "MODEL_PATH must point to a converted Diffusers model directory containing model_index.json: $MODEL_PATH" >&2
    exit 2
fi

mkdir -p "$RUN_OUTPUT"

"$PYTHON" - \
    "$MODEL_PATH" "$PROMPT" "$INPUT_IMAGE" "$GENERATION_MODE" "$RUN_OUTPUT" \
    "$DEVICE" "$HEIGHT" "$WIDTH" "$STEPS" "$GUIDANCE_SCALE" "$SEED" <<'PY'
import sys

import torch

from diffusers.utils import load_image
from src import LLaDAImagePipeline


(
    model_path,
    prompt,
    input_image,
    generation_mode,
    output_path,
    device,
    height,
    width,
    steps,
    guidance_scale,
    seed,
) = sys.argv[1:]
pipeline = LLaDAImagePipeline.from_pretrained(model_path, torch_dtype=torch.bfloat16, device=device)
kwargs = {
    "prompt": prompt,
    "generation_mode": generation_mode,
    "height": int(height),
    "width": int(width),
    "num_inference_steps": int(steps),
    "guidance_scale": float(guidance_scale),
    "generator": torch.Generator(device=pipeline.transformer.device).manual_seed(int(seed)),
}
if generation_mode == "editing":
    kwargs["image"] = load_image(input_image)

image = pipeline(**kwargs).images[0]
image.save(f"{output_path}/0000.png")
PY

echo "Output: $RUN_OUTPUT"
