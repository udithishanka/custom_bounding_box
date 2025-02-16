## custom bounding box


## Project Setup

1. **Clone the repo**
```bash
git clone https://github.com/udithishanka/custom_bounding_box.git
cd custom_bounding_box
```

2. **Run the 'setup.bash' script**
- This bash script will download and extract the Oxford-IIIT Pet Dataset.
```bash
    bash setup.bash
```

3. **Create a virtual environment to install the dependancies**
```
python3 -m venv yolov5-env
source yolov5-env/bin/activate
```

4. **Install the Dependancies**
```bash
pip install -r requirements.txt
```

5. **Run preprocess.py**
- This script converts Pascal VOC XML annotations to YOLO format, splits the dataset into 80% training and 20% validation, and organizes images and labels into respective folders for YOLO-based training.
```bash
python preprocess.py
```

6. **Go into yolov5**
```bash
cd yolov5
```
- Run following commands inside the yolov5 dir.

7. **Finetune YOLOv5 with Dataset**
Here, I have added a new argument called lambda_factor, if its not provided default value is zero, which means it doesn't take the additional custom_bbox_similarity to the loss function.

```bash
python train.py --img 640 --batch 16 --epochs 10 --data data/cats_dogs.yaml --weights yolov5s.pt --lambda_factor 0.01
```

8. **Evaluate the Finetuned model with the datset**
'exp6' of this command needs to be replaced with your actual dir, which contains the trained weights of your training.

```bash
python val.py --img 640 --batch 16 --data data/cats_dogs.yaml --weights runs/train/exp6/weights/best.pt
```

9. **Detect cats and dogs in an image.
```bash
python detect.py --weights runs/train/exp8/weights/best.pt --source ../datasets/cats_dogs/images/val/Abyssinian_6.jpg --img 640 --conf 0.25
```