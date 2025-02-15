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


# Eval results - with the custom bounding box (lambda_factor = 0.3)

#                 Class     Images  Instances          P          R      mAP50   mAP50-95: 100%|██████████| 93/93 [00:08<00:00, 10.75it/s]
#                    all       1478        749      0.448      0.608      0.414      0.257
#                    cat       1478        238       0.48      0.635      0.451      0.305
#                    dog       1478        511      0.416      0.581      0.378      0.209
# Speed: 0.1ms pre-process, 2.3ms inference, 1.1ms NMS per image at shape (16, 3, 640, 640)
# Results saved to runs/val/exp3



# Eval results - with the custom bounding box (lambda_factor = 0.01)
# Model summary: 157 layers, 7015519 parameters, 0 gradients, 15.8 GFLOPs
#                  Class     Images  Instances          P          R      mAP50   mAP50-95: 100%|██████████| 47/47 [00:06<00:00,  6.88it/s]
#                    all       1478        749      0.476      0.934      0.512      0.401
#                    cat       1478        238      0.476      0.946      0.529      0.441
#                    dog       1478        511      0.475      0.922      0.496       0.36
# Results saved to runs/train/exp13



# Eval results - with the custom bounding box (lambda_factor = 0.05)
# Model summary: 157 layers, 7015519 parameters, 0 gradients, 15.8 GFLOPs
#                  Class     Images  Instances          P          R      mAP50   mAP50-95: 100%|██████████| 47/47 [00:06<00:00,  6.90it/s]
#                    all       1478        749      0.477      0.944      0.499      0.381
#                    cat       1478        238      0.468      0.966      0.494      0.408
#                    dog       1478        511      0.487      0.922      0.503      0.355
# Results saved to runs/train/exp14
# root@6c2e1e5507f8:~/custom_bounding_box/yolov5# 