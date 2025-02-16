import os
import xml.etree.ElementTree as ET
import random
import shutil

# Define class names
classes = ["cat", "dog"]

# Convert Pascal VOC XML to YOLO format
def convert_to_yolo(xml_file, output_dir):
    tree = ET.parse(xml_file)
    root = tree.getroot()

    img_w = int(root.find("size/width").text)
    img_h = int(root.find("size/height").text)

    yolo_annotations = []

    for obj in root.findall("object"):
        class_name = obj.find("name").text.lower()
        if class_name not in classes:
            continue

        class_id = classes.index(class_name)
        bbox = obj.find("bndbox")
        xmin = int(bbox.find("xmin").text)
        ymin = int(bbox.find("ymin").text)
        xmax = int(bbox.find("xmax").text)
        ymax = int(bbox.find("ymax").text)

        x_center = (xmin + xmax) / 2 / img_w
        y_center = (ymin + ymax) / 2 / img_h
        width = (xmax - xmin) / img_w
        height = (ymax - ymin) / img_h

        yolo_annotations.append(f"{class_id} {x_center} {y_center} {width} {height}")

    # Save YOLO format annotation
    output_file = os.path.join(output_dir, os.path.basename(xml_file).replace(".xml", ".txt"))
    with open(output_file, "w") as f:
        f.write("\n".join(yolo_annotations))

# Convert all annotations
input_annotations_dir = "datasets/cats_dogs/annotations/xmls"
output_labels_dir = "datasets/cats_dogs/labels"
os.makedirs(output_labels_dir, exist_ok=True)

for xml in os.listdir(input_annotations_dir):
    if xml.endswith(".xml"):
        convert_to_yolo(os.path.join(input_annotations_dir, xml), output_labels_dir)
        

dataset_path = "datasets/cats_dogs"
image_dir = os.path.join(dataset_path, "images")
label_dir = os.path.join(dataset_path, "labels")

# Create train/val directories if they don't exist
for folder in ["train", "val"]:
    os.makedirs(os.path.join(image_dir, folder), exist_ok=True)
    os.makedirs(os.path.join(label_dir, folder), exist_ok=True)

# Get all image files
image_files = [f for f in os.listdir(image_dir) if f.endswith(('.jpg', '.png'))]
random.seed(42)
random.shuffle(image_files)

# Split into 80% train, 20% val
split_idx = int(0.8 * len(image_files))
train_files = image_files[:split_idx]
val_files = image_files[split_idx:]

# Function to move files if they exist
def move_file(src, dest):
    if os.path.exists(src):
        shutil.move(src, dest)

# Move images and labels
for img in train_files:
    move_file(os.path.join(image_dir, img), os.path.join(image_dir, "train", img))
    move_file(os.path.join(label_dir, img.replace(".jpg", ".txt").replace(".png", ".txt")),
              os.path.join(label_dir, "train", img.replace(".jpg", ".txt").replace(".png", ".txt")))

for img in val_files:
    move_file(os.path.join(image_dir, img), os.path.join(image_dir, "val", img))
    move_file(os.path.join(label_dir, img.replace(".jpg", ".txt").replace(".png", ".txt")),
              os.path.join(label_dir, "val", img.replace(".jpg", ".txt").replace(".png", ".txt")))

print("Dataset successfully split into train and val!")
