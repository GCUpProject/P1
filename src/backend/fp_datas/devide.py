import os
import random

# 이미지 파일 경로 설정
data_dir = '/home/t23320/Easy-Yolo-OCR/yolov5/dataset/custom_data'
output_dir = '/home/t23320/Easy-Yolo-OCR/yolov5/dataset'

# 분할 비율 설정
train_ratio = 0.7
valid_ratio = 0.2
test_ratio = 0.1  # 테스트 세트를 원하지 않으면 이 값을 0으로 설정

# 이미지 파일 목록 가져오기
image_files = [f for f in os.listdir(data_dir) if os.path.isfile(os.path.join(data_dir, f)) and f.endswith('.png')]

# 무작위로 섞기
random.shuffle(image_files)

# 분할 인덱스 계산
total_images = len(image_files)
train_index = int(total_images * train_ratio)
valid_index = train_index + int(total_images * valid_ratio)

# 데이터 분할
train_files = image_files[:train_index]
valid_files = image_files[train_index:valid_index]
test_files = image_files[valid_index:] if test_ratio > 0 else []

# 파일 경로 쓰기 함수
def write_to_file(file_list, filename):
    with open(filename, 'w') as file:
        for img in file_list:
            file.write(f'dataset/custom_data/{img}\n')

# 파일 생성
write_to_file(train_files, os.path.join(output_dir, 'custom_train.txt'))
write_to_file(valid_files, os.path.join(output_dir, 'custom_valid.txt'))
if test_ratio > 0:
    write_to_file(test_files, os.path.join(output_dir, 'custom_test.txt'))

print(f"Train/Valid/Test: {len(train_files)}/{len(valid_files)}/{len(test_files)}")

