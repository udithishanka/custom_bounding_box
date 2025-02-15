mkdir -p datasets/cats_dogs
cd datasets/cats_dogs
wget https://www.robots.ox.ac.uk/~vgg/data/pets/data/images.tar.gz
wget https://www.robots.ox.ac.uk/~vgg/data/pets/data/annotations.tar.gz
tar -xzf images.tar.gz
tar -xzf annotations.tar.gz
cd ../..

python3 preprocess.py