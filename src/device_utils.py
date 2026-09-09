# Copyright 2026 The HuggingFace Team. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Accelerator selection helpers shared by the pipeline and the run script.

LLaDA-Image runs on CUDA, on Apple Silicon through the PyTorch MPS backend, and on CPU. Every attention path in the
model resolves to `torch.nn.functional.scaled_dot_product_attention`, so no vendor-specific attention kernel is
required on any of them.
"""

import torch


def resolve_device(device: torch.device | str | None = None) -> torch.device:
    """Return the accelerator to run on, preferring CUDA, then Apple Silicon MPS, then CPU.

    An explicit `device` is returned as-is so callers can always override the automatic choice. Pass `"auto"` (or
    `None`) to select the best available backend.
    """
    if device is not None and device != "auto":
        return torch.device(device)

    if torch.cuda.is_available():
        return torch.device("cuda")
    if torch.backends.mps.is_available():
        return torch.device("mps")
    return torch.device("cpu")


def resolve_dtype(dtype: torch.dtype | None = None, device: torch.device | str | None = None) -> torch.dtype:
    """Return the compute dtype for `device`, defaulting to bfloat16 on accelerators and float32 on CPU.

    CPU bfloat16 inference is emulated and impractically slow for a model this size, so float32 is used instead.
    """
    if dtype is not None:
        return dtype

    return torch.float32 if resolve_device(device).type == "cpu" else torch.bfloat16
