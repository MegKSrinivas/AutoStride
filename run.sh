#!/bin/bash
set -e

echo "Installing dependencies"
pip install --upgrade pip
pip install -r requirements.txt

echo "Dependencies installed."

# Clone DETR or any repo containing the Hungarian matcher
if [ ! -d "detr" ]; then
  echo "Cloning DETR repository"
  git clone https://github.com/facebookresearch/detectron2.git
fi

# Run preprocessing notebooks
echo "Running preprocessing notebooks..."
jupyter nbconvert --to notebook --execute annotations.ipynb --inplace
jupyter nbconvert --to notebook --execute parsing.ipynb --inplace

NOTEBOOKS=(
  ViTPD.ipynb
  baseline_detectors.ipynb
  DETR_Basline.ipynb
)

echo "🚀 Running notebooks… outputs will be saved in-place:"
for nb in "${NOTEBOOKS[@]}"; do
  echo "▶️ Executing $nb..."
  jupyter nbconvert \
    --to notebook \
    --execute "$nb" \
    --inplace \
    --ExecutePreprocessor.timeout=-1
done

echo "All notebooks executed successfully."

# Navigate to app directory
cd Webapp || exit

# Install dependencies
echo "Installing Python requirements..."
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# Launch Streamlit App
echo "Launching Streamlit App..."
python -m streamlit run app.py