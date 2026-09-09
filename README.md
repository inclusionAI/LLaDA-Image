<h1 align="center">LLaDA-Image: Building Strong Image Generators with Fully Open Training Recipes</h1>

<p align="center">
  Welcome to the official repository for LLaDA-Image, a unified model for high-quality image generation and editing.
</p>

<p align="center">
  <a href="https://github.com/inclusionAI/LLaDA-Image"><img src="https://img.shields.io/badge/GitHub-LLaDA--Image-181717?logo=github" alt="GitHub"></a>
    <a href="https://arxiv.org/pdf/2609.03796"><img src="https://img.shields.io/badge/arXiv-Report-B31B1B?logo=arxiv" alt="arXiv"></a><br>
  <a href="https://huggingface.co/inclusionAI/LLaDA-Image"><img src="https://img.shields.io/badge/Hugging%20Face-Base-FFD21E?logo=huggingface" alt="LLaDA-Image Base on Hugging Face"></a>
  <a href="https://huggingface.co/inclusionAI/LLaDA-Image-FP8"><img src="https://img.shields.io/badge/Hugging%20Face-Base--FP8-FFD21E?logo=huggingface" alt="LLaDA-Image Base FP8 Version on Hugging Face"></a>
  <a href="https://huggingface.co/inclusionAI/LLaDA-Image-Turbo"><img src="https://img.shields.io/badge/Hugging%20Face-Turbo-FFD21E?logo=huggingface" alt="LLaDA-Image Turbo on Hugging Face"></a>
  <a href="https://huggingface.co/inclusionAI/LLaDA-Image-Turbo-FP8"><img src="https://img.shields.io/badge/Hugging%20Face-Turbo--FP8-FFD21E?logo=huggingface" alt="LLaDA-Image Turbo FP8 Version on Hugging Face"></a><br>
    <a href="https://modelscope.cn/models/inclusionAI/LLaDA-Image"><img src="https://img.shields.io/badge/🤖%20Model%20Scope-Base-624aff" alt="LLaDA-Image Base on Modelscope"></a>
  <a href="https://modelscope.cn/models/inclusionAI/LLaDA-Image-FP8"><img src="https://img.shields.io/badge/🤖%20Model%20Scope-Base--FP8-624aff" alt="LLaDA-Image Base FP8 Version on Modelscope"></a>
  <a href="https://modelscope.cn/models/inclusionAI/LLaDA-Image-Turbo"><img src="https://img.shields.io/badge/🤖%20Model%20Scope-Turbo-624aff" alt="LLaDA-Image Turbo on Modelscope"></a>
  <a href="https://modelscope.cn/models/inclusionAI/LLaDA-Image-Turbo-FP8"><img src="https://img.shields.io/badge/🤖%20Model%20Scope-Turbo--FP8-624aff" alt="LLaDA-Image Turbo FP8 Version on Modelscope"></a>
</p>

<p align="center">
  <img src="./assets/demo.jpg" alt="LLaDA-Image realistic image generation showcase" width="100%">
  <br>
  <em>Photorealistic image generation with natural lighting, lifelike details, and coherent scenes.</em>
</p>

<p align="center">
  <img src="./assets/demo_p2.jpg" alt="LLaDA-Image text rendering and poster generation showcase" width="100%">
  <br>
  <em>High-quality text rendering and creative poster generation across diverse visual styles.</em>
</p>

<p align="center">
  <img src="./assets/edit_demo.jpg" alt="LLaDA-Image editing showcase" width="100%">
  <br>
  <em>Instruction-guided image editing with faithful content preservation and precise visual changes.</em>
</p>

## Introduction

LLaDA-Image is a competitive 6B-parameter open-source unified image generation and editing model family. It includes **LLaDA-Image**, a 50-step Base model for high-quality text-to-image generation and instruction-guided editing, and **LLaDA-Image-Turbo**, a 4-step distilled model for fast generation and editing. Both variants support practical text-to-image generation, VQ-conditioned generation, reference-image editing, and Chinese--English text rendering.

This repository provides the checkpoints and Diffusers-based inference code for the LLaDA-Image model family.

## News

- **2026-09-07:** Thanks to [@Rebel AI](https://huggingface.co/realrebelai), the Comfy UI for [LLaDA-Image](https://huggingface.co/realrebelai/LLaDa-Image_ComfyUI) and [LLaDA-Image-Turbo](https://huggingface.co/realrebelai/LLaDa-Image-Turbo_ComfyUI) and its FB8 version is supported.
- **2026-09-04:** We released the LLaDA-Image Base and Turbo checkpoints together with the inference code.

## Highlights

- **Unified generation and editing.** A single checkpoint supports text-to-image generation and reference-preserving, instruction-guided editing without a separate editing backbone.
- **Unified diffusion model.** Both backbone and DiT are diffusion models, trained in a unified framework.
- **Realistic image generation.** LLaDA-Image produces high-quality images with rich visual details, natural lighting, and coherent compositions.
- **Image-only pre-training for visual-prior learning.** The report establishes the visual prior through image-only pre-training and mid-training before introducing paired language supervision and joint generation--editing training.
- **Efficient inference with distilled model.** LLaDA-Image-Turbo uses Twin-DMD distillation to deliver fast image generation and editing in only 2--4 sampling steps.
- **SOTA on Qwen-Image-Bench.** LLaDA-Image achieves state-of-the-art overall scores of 53.53 in English and 53.38 in Chinese.

<p align="center">
  <img class="not-prose" src="./assets/qwen-imagebench.png" alt="Qwen-image bench evaluation" width="100%">
</p>

## Model Zoo

| Model                 | Description                                                                           | Sampling steps | Hugging Face (Checkpoints)                                                                    | ModelScope (Checkpoints)                                                                          |
| --------------------- | ------------------------------------------------------------------------------------- | -------------: | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| **LLaDA-Image**       | Base model for high-fidelity text-to-image generation and instruction-guided editing. |             50 | **BF16:** [inclusionAI/LLaDA-Image](https://huggingface.co/inclusionAI/LLaDA-Image)<br>**FP8:** [inclusionAI/LLaDA-Image-FP8](https://huggingface.co/inclusionAI/LLaDA-Image-FP8) | **BF16:** [inclusionAI/LLaDA-Image](https://modelscope.cn/models/inclusionAI/LLaDA-Image)<br>**FP8:** [inclusionAI/LLaDA-Image-FP8](https://modelscope.cn/models/inclusionAI/LLaDA-Image-FP8) |
| **LLaDA-Image-Turbo** | Distilled model for fast generation and editing.                                      |              4 | **BF16:** [inclusionAI/LLaDA-Image-Turbo](https://huggingface.co/inclusionAI/LLaDA-Image-Turbo)<br>**FP8:** [inclusionAI/LLaDA-Image-Turbo-FP8](https://huggingface.co/inclusionAI/LLaDA-Image-Turbo-FP8) | **BF16:** [inclusionAI/LLaDA-Image-Turbo](https://modelscope.cn/models/inclusionAI/LLaDA-Image-Turbo)<br>**FP8:** [inclusionAI/LLaDA-Image-Turbo-FP8](https://modelscope.cn/models/inclusionAI/LLaDA-Image-Turbo-FP8) |

## Opensource Plan

- [x] Inference code and model weights
- [ ] Training code (coming soon)

## Quick Start

### 1. Create an environment

The implementation has been used with Python 3.11, PyTorch 2.8, Transformers 4.57.6, and Diffusers 0.39.0.

```bash
git clone https://github.com/inclusionAI/LLaDA-Image.git
cd LLaDA-Image

conda create -n llada-image python=3.11 -y
conda activate llada-image

pip install -r requirements.txt
```

> [!NOTE]
> The pinned Transformers version matters: the LLaDA2 text encoder ships remote code that imports symbols removed in
> Transformers 5.x. Install into a clean environment rather than an existing one.

### Apple Silicon

The model runs on Apple Silicon through the PyTorch MPS backend, with no CUDA toolkit and no `flash-attn` build.
Every attention path in the stack — the DiT, the QueryFormer, the text projection, the SigVQ encoder, and the LLaDA2
text encoder — resolves to `torch.nn.functional.scaled_dot_product_attention`, which MPS implements natively.

`from_pretrained` selects the accelerator automatically, preferring CUDA, then MPS, then CPU:

```python
from src import LLaDAImagePipeline, resolve_device

device = resolve_device()          # torch.device("mps") on Apple Silicon
pipe = LLaDAImagePipeline.from_pretrained("inclusionAI/LLaDA-Image", device=device)
```

Pass an explicit `device=` to override the choice, and `DEVICE=mps` (or `cpu`, `cuda`) to `scripts/run_llada_image.sh`.

**Memory.** The BF16 checkpoint holds every component resident on the device at once:

| Component | BF16 size |
| --- | ---: |
| `text_encoder` (LLaDA2 MoE, 256 experts) | 32.65 GB |
| `transformer` (DiT) | 13.08 GB |
| `sigvq` | 2.59 GB |
| `text_projection`, `vae`, `queryformer` | 0.92 GB |
| **Total** | **49.24 GB** |

Plan on 64 GB of unified memory as a practical floor for 1024x1024 generation, and expect memory pressure near that
floor once activations are added. Lower `height`/`width`, or use an FP8 checkpoint, if you have less.

**MoE backend.** The text encoder's fused MoE has a Triton kernel gated on CUDA tensors, and falls back automatically
to an eager PyTorch path on MPS — set `LLADA_MOE_BACKEND=eager` to force it. The fallback loops over experts, so
prompt encoding is slower than on CUDA. In `text` mode it runs once per image rather than once per denoising step, so
it costs a fixed amount per generation.

### 2. Run inference

The pipeline accepts a prompt and, for editing, an optional reference image.

#### LLaDA-Image (Base)

Use the Base checkpoint for high-fidelity generation and editing. Its recommended sampling configuration is **50 steps**.

```python
import torch

from src import LLaDAImagePipeline, resolve_device

# Picks CUDA, then Apple Silicon MPS, then CPU. Pass a device explicitly to override.
device = resolve_device()

# Load the pipeline. The model is downloaded from Hugging Face on first use.
pipe = LLaDAImagePipeline.from_pretrained(
    "inclusionAI/LLaDA-Image",
    torch_dtype=torch.bfloat16,
    device=device,
)

# Generate an image.
prompt = (
    "A cinematic photograph of a red fox standing in fresh snow, "
    "soft winter light, detailed fur, shallow depth of field"
)
negative_prompt = ""

image = pipe(
    prompt=prompt,
    negative_prompt=negative_prompt,
    generation_mode="text",
    height=1024,
    width=1024,
    num_inference_steps=50,
    guidance_scale=5.0,
    generator=torch.Generator(device).manual_seed(42),
).images[0]

image.save("llada-image-base.png")
```

#### LLaDA-Image-Turbo

Use the Turbo checkpoint for fast generation and editing. Its recommended sampling configuration is **4 steps**.

> [!NOTE]
> For LLaDA-Image-Turbo inference, you can try setting `stochastic_sampling` to `false` in `scheduler/scheduler_config.json`, which may produce sharper details in some cases.

```python
import torch

from src import LLaDAImagePipeline, resolve_device

device = resolve_device()

# Load the distilled Turbo checkpoint.
pipe = LLaDAImagePipeline.from_pretrained(
    "inclusionAI/LLaDA-Image-Turbo",
    torch_dtype=torch.bfloat16,
    device=device,
)

prompt = "A quiet observatory above a sea of clouds at sunrise, golden light, wide-angle photograph"

image = pipe(
    prompt=prompt,
    generation_mode="text",
    height=1024,
    width=1024,
    num_inference_steps=4,
    guidance_scale=1.0,
    generator=torch.Generator(device).manual_seed(42),
).images[0]

image.save("llada-image-turbo.png")
```

#### Generation modes

Both checkpoints support the following modes. Text and VQ-conditioned generation require height and width divisible by 16; image editing requires dimensions divisible by 32.

**VQ-conditioned generation** uses the LLaDA2 model to produce image VQ tokens from the prompt, which SigVQ embeds before diffusion. Do not provide an input image in VQ mode.

```python
image = pipe(
    prompt="A quiet observatory above a sea of clouds at sunrise",
    generation_mode="vq",
    height=1024,
    width=1024,
    num_inference_steps=50,  # Use 4 for LLaDA-Image-Turbo.
    guidance_scale=5.0,  # Use 1.0 for few-step inference.
    generator=torch.Generator(device).manual_seed(42),
).images[0]
```

**Image editing** requires a reference image:

```python
from diffusers.utils import load_image

reference_image = load_image("/path/to/input.png")
image = pipe(
    prompt="Turn it into a watercolor painting",
    image=reference_image,
    generation_mode="editing",
    height=1024,
    width=1024,
    num_inference_steps=50,  # Use 4 for LLaDA-Image-Turbo.
    guidance_scale=5.0,  # Use 1.0 for few-step inference.
    generator=torch.Generator(device).manual_seed(43),
).images[0]
```

## Acknowledgements

We thank the [VeOmni](https://github.com/ByteDance-Seed/VeOmni) project and its contributors for their valuable open-source work.

## Citation

If you find LLaDA-Image useful for your research or applications, please consider citing our work.

```bibtex
@article{LLaDAImage,
title = {LLaDA-Image: Building Strong Image Generators with Fully Open Training Recipes},
author = {Chuyan Chen and Haoxing Chen and Kun Chen and Zhenglin Cheng and Long Cui and Ruishan Fang and Zhangxuan Gu and Zhicheng Huang and Zhenzhong Lan and Yuanting Lei and Haoquan Li and Jianguo Li and Rongchuan Li and Sidu Li and Tao Lin and Deyuan Liu and Jiacheng Liu and Lin Liu and Yuxuan Lou and Zhisheng Lu and Yuxin Ma and Shuheng Shen and Peng Sun and Chaoyang Wang and Hongjun Wang and Xiaomei Wang and Yongxin Wang and Chengzhang Wu and Hongru Wu and Jun Xie},
journal = {arXiv preprint arXiv:2609.03796},
year = {2026}
}
```
