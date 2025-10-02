# AutoStride - Pedestrian Detection (ViT/DETR, Faster R-CNN, RetinaNet, Haar, HOG+SVM)

AutoStride is a pedestrian-detection project comparing transformer-based models (custom ViT detectors inspired by DETR) with deep CNN baselines (Faster R-CNN, RetinaNet) and classical approaches (Haar Cascades, HOG+SVM). It includes preprocessing to COCO-style annotations, end-to-end notebook pipelines, and a Streamlit web app for interactive demos.

# Overview

Evaluated four families of pedestrian detectors: (1) custom Vision Transformer (ViT) detectors with a DETR-style encoder–decoder and learnable object queries, (2) Faster R-CNN (ResNet-50 FPN), (3) RetinaNet, and (4) classical Haar and HOG+SVM detectors. The pipeline converts JAAD video/XML annotations to a unified COCO-style JSON, trains/evaluates models, and visualizes predictions vs. ground truth.

# Dataset

Used the JAAD 2.0 dataset (Joint Attention in Autonomous Driving). The project parses multiple XML files (annotations, attributes, traffic, vehicle) and merges them into a single COCO-style file with image paths. You’ll extract frames from videos before training/inference.

# Quickstart

Requires Python 3.9+ and a virtual environment (recommended).

1. Create & activate a venv

  python -m venv .venv
  source .venv/bin/activate   # Windows: .venv\Scripts\activate

2. Run everything with one command

  chmod +x run.sh
  bash run.sh

Under the hood, run.sh does:

pip install -r requirements.txt
Clones facebookresearch/detectron2 (used for components like matching/utilities).
Executes notebooks via jupyter nbconvert --execute (no timeout).

Tip: first run can take a while (dependency installs + notebook execution).

# Configuration & notes

1. Dataset paths: The preprocessing notebooks expect JAAD videos/XMLs and a destination for extracted frames. Open annotations.ipynb & parsing.ipynb and set the input/output paths for your environment, then run them to produce the COCO-style JSONs used by the modeling notebooks.
2. Long-running cells: nbconvert uses --ExecutePreprocessor.timeout=-1 in run.sh to allow full training/evaluation in notebooks.
3. GPU (optional): Training/eval will benefit from a CUDA-enabled environment, but classical baselines and the app can run CPU-only.
4. Large files: Keep heavy datasets/weights out of Git or track them via Git LFS. See .gitignore for suggested patterns.

# References

Key papers/tools used by this project:

DETR — Carion et al., 2020.
Transformer — Vaswani et al., 2017.
Faster R-CNN — Ren et al., 2015.
HOG for human detection — Dalal & Triggs, 2005.
JAAD dataset — Joint Attention in Autonomous Driving.

# License

This repository is for educational/research use. Check licenses of third-party models/datasets (e.g., JAAD, torchvision, Detectron2) before commercial use.
