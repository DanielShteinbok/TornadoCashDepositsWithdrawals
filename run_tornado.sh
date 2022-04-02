#!/bin/bash

pushd scripts

echo "### Preprocess ###"

python preprocess_data.py

echo "### Tornado experiments ###"

# create time of day representation
python run_tornado_experiment.py False 6 -1
# create gas price representation
python run_tornado_experiment.py False -1 50

# run for multiple samples
for i in {0..9}; do
echo $i
# train model
python train_node_embedding.py diff2vec True $i;
# create representation
python run_tornado_experiment.py True diff2vec $i;
done;

popd
