mkdir -p datasets/cats_dogs
cd datasets/cats_dogs
wget https://www.robots.ox.ac.uk/~vgg/data/pets/data/images.tar.gz
wget https://www.robots.ox.ac.uk/~vgg/data/pets/data/annotations.tar.gz
tar -xzf images.tar.gz
tar -xzf annotations.tar.gz
cd ../..



# python train.py --img 640 --batch 16 --epochs 10 --data data/cats_dogs.yaml --weights yolov5s.pt --lambda_factor 0.3

# python val.py --img 640 --batch 16 --data data/cats_dogs.yaml --weights runs/train/exp6/weights/best.pt




# Eval results - without the custom bounding box

#                 Class     Images  Instances          P          R      mAP50   mAP50-95: 100%|██████████| 93/93 [00:08<00:00, 10.62it/s]
#                    all       1478        749      0.477      0.932      0.522      0.409
#                    cat       1478        238       0.48      0.945      0.531      0.441
#                    dog       1478        511      0.474      0.918      0.513      0.377
# Speed: 0.1ms pre-process, 2.4ms inference, 1.0ms NMS per image at shape (16, 3, 640, 640)
# Results saved to runs/val/exp2


# Eval results - with the custom bounding box

#                 Class     Images  Instances          P          R      mAP50   mAP50-95: 100%|██████████| 93/93 [00:08<00:00, 10.75it/s]
#                    all       1478        749      0.448      0.608      0.414      0.257
#                    cat       1478        238       0.48      0.635      0.451      0.305
#                    dog       1478        511      0.416      0.581      0.378      0.209
# Speed: 0.1ms pre-process, 2.3ms inference, 1.1ms NMS per image at shape (16, 3, 640, 640)
# Results saved to runs/val/exp3