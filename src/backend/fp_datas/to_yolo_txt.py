import json
import os

def convert_bbox_to_yolo(size, box):
    dw = 1. / size[0]
    dh = 1. / size[1]
    x = (box[0] + box[2] / 2.0) * dw
    y = (box[1] + box[3] / 2.0) * dh
    w = box[2] * dw
    h = box[3] * dh
    return x, y, w, h

def convert_annotations_to_yolo(json_file, output_dir, exclude_texts):
    with open(json_file, 'r') as file:
        data = json.load(file)

    image_info = {image['id']: (image['width'], image['height']) for image in data['images']}
    for annotation in data['annotations']:
        ocr_text = annotation['attributes']['OCR']
        # Skip annotations with specified texts
        if any(ex_text in ocr_text for ex_text in exclude_texts):
            continue

        bbox = annotation['bbox']
        image_id = annotation['image_id']
        image_size = image_info[image_id]

        # YOLO format: class_id center_x center_y width height
        # Assuming class_id for OCR is 0
        yolo_bbox = convert_bbox_to_yolo(image_size, bbox)
        yolo_format = f"0 {' '.join([str(a) for a in yolo_bbox])}\n"

        base_filename = os.path.splitext(os.path.basename(json_file))[0]
        output_filename = os.path.join(output_dir, base_filename + ".txt")
        with open(output_filename, 'a') as out_file:
            out_file.write(yolo_format)

# Directory containing the JSON files
json_dir = 'TL_OCR'
output_dir = '/home/t23320/Easy-Yolo-OCR/yolov5/dataset/custom_data'
exclude_texts = ["단위세대", "평면도", "축척", "단위세대평면도"]  # Texts to exclude

# Convert all JSON files
for json_file in os.listdir(json_dir):
    if json_file.endswith('.json'):
        convert_annotations_to_yolo(os.path.join(json_dir, json_file), output_dir, exclude_texts)

