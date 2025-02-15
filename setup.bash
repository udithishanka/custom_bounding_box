mkdir -p datasets/cats_dogs
cd datasets/cats_dogs
wget https://www.robots.ox.ac.uk/~vgg/data/pets/data/images.tar.gz
wget https://www.robots.ox.ac.uk/~vgg/data/pets/data/annotations.tar.gz
tar -xzf images.tar.gz
tar -xzf annotations.tar.gz
cd ../..

pip install -r requirements.txt

#python preprocess.py

# python train.py --img 640 --batch 16 --epochs 50 --data data/cats_dogs.yaml --weights yolov5s.pt