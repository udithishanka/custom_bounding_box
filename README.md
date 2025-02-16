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
- Here, I have added a new argument called lambda_factor, if its not provided default value is zero, which means it doesn't take the additional custom_bbox_similarity to the loss function. loss = (1 - iou) + lambda_factor * (1 - custom_similarity). This is my additional term to the loss function - "+ lambda_factor * (1 - custom_similarity)". By changing the value of lambda_factor, you are changing how much the custom boundry box similarity will affect the loss function.

```bash
python train.py --img 640 --batch 16 --epochs 10 --data data/cats_dogs.yaml --weights yolov5s.pt --lambda_factor 0.01
```

8. **Evaluate the Finetuned model with the datset**
- Usually when we run the train.py, it does the validation as well at the end, but if you want have trained weights to validate the performance on the cats and dogs dataset, you can use this command. 
IMPORTANT -Provide your actual weights path. Path in this command won't work.

```bash
python val.py --img 640 --batch 16 --data data/cats_dogs.yaml --weights runs/train/exp6/weights/best.pt
```

9. **Detect cats and dogs in an image.**
- Use this command to detect cats and dogs in an image. Provide your image source, could be a dir or a file. 
```bash
python detect.py --weights runs/train/exp8/weights/best.pt --source ../datasets/cats_dogs/images/val/Abyssinian_6.jpg --img 640 --conf 0.25
```
