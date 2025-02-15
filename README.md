## custom bounding box


## Project Setup

1. Run the 'setup.bash' script.

```bash
    bash setup.bash
```

2.  Use/Create a virtual environment to install the dependancies.
```
python3 -m venv yolov5-env
source yolov5-env/bin/activate
```

3. Install the Dependancies
```bash
pip install -r requirements.txt
```

4. Run preprocess.py
```bash
python preprocess.py
```

5. Finetune YOLOv5 with Dataset
Here, I have added a new argument called lambda_factor, if its not provided default value is zero, which means it doesn't take the additional custom_bbox_similarity to the loss function.

```bash
python train.py --img 640 --batch 16 --epochs 10 --data data/cats_dogs.yaml --weights yolov5s.pt --lambda_factor 0.01
```

6. Evaluate the Finetuned model with the datset.
'exp6' of this command needs to be replaced with your actual dir, which contains the trained weights of your training.

```bash
python val.py --img 640 --batch 16 --data data/cats_dogs.yaml --weights runs/train/exp6/weights/best.pt
```