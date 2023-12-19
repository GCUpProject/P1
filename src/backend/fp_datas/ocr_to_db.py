import cv2
import easyocr
import mysql.connector
from mysql.connector import Error
from collections import defaultdict

# 데이터베이스 연결 설정
db_config = {
    'user': 'dbid233',
    'password': 'dbpass233',
    'host': 'localhost',
    'database': 'db23320',
    'port': 3306
}

# 이미지 불러오기
image = cv2.imread('/home/t23320/P1/src/backend/fp_datas/images/floor_plan.png')

# 그레이스케일 변환
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# 명암 대비 향상
# 여기서 alpha는 대비를 조절하는 계수, beta는 이미지의 밝기를 조절하는 계수입니다.
alpha = 1.5
beta = 30
contrasted_image = cv2.convertScaleAbs(gray_image, alpha=alpha, beta=beta)

_, binary_image = cv2.threshold(contrasted_image, 128, 255, cv2.THRESH_BINARY)

# 이미지 크기 조정 (옵션)
# 여기서는 이미지의 크기를 두 배로 늘립니다.
resized_image = cv2.resize(binary_image, None, fx=2, fy=2, interpolation=cv2.INTER_CUBIC)

# OCR 실행
reader = easyocr.Reader(['ko'])  # 한글 인식 설정
results = reader.readtext(resized_image, low_text=0.4, link_threshold=0.4, canvas_size=2560, mag_ratio=1.5)

# 초기 최대값과 최소값을 설정합니다. 최소값은 가능한 가장 큰 값으로, 최대값은 0으로 시작합니다.
min_x = float('inf')
max_x = 0
min_y = float('inf')
max_y = 0

# results 리스트를 순회하며 각 bbox의 좌표를 비교합니다.
for result in results:
    bbox = result[0]  # bbox 좌표를 가져옵니다.
    # bbox의 x와 y 좌표들을 추출합니다.
    x_coords = [point[0] for point in bbox]
    y_coords = [point[1] for point in bbox]
    
    # 현재 bbox의 최대값과 최소값을 찾습니다.
    min_x = min(min_x, min(x_coords))
    max_x = max(max_x, max(x_coords))
    min_y = min(min_y, min(y_coords))
    max_y = max(max_y, max(y_coords))

print(max_x, max_y, min_x, min_y)
# 이미지를 최소 및 최대 좌표에 따라 잘라냅니다.
#cropped_image = image[min_y:max_y, min_x:max_x]

# 잘라낸 이미지를 저장합니다.
#cv2.imwrite('images/floor_plan.png', cropped_image)

# 필터링할 단어 목록을 정의합니다.
keywords = ['실', '방', '룸', '호', '홀', '관', '구', '대피', '피난', '공간', '복도', '식당', '테라스', '태라스', '펜트리', '팬트리', '드레스', '발코니']

name_count = defaultdict(int)

# 확률이 0.9 이상이고 특정 단어를 포함하는 결과만 필터링합니다.
filter_results = [item for item in results if item[2] >= 0.2 and any(keyword in item[1] for keyword in keywords)]

# filter_results 내의 각 텍스트 항목을 순회하며 중복 확인 및 업데이트
for i in range(len(filter_results)):
    bbox, text, prob = filter_results[i]
    # 해당 텍스트에 대한 카운트를 증가시킵니다.
    name_count[text] += 1
    # 만약 해당 텍스트가 한 번 이상 등장했다면, 일련번호를 추가합니다.
    if name_count[text] > 1:
        new_text = f"{text}{name_count[text]}"
    else:
        new_text = text
    # 원래의 리스트 항목을 업데이트된 텍스트로 교체합니다.
    filter_results[i] = (bbox, new_text, prob)

try:
    # 데이터베이스에 연결
    conn = mysql.connector.connect(**db_config)
    
    # 연결이 성공했는지 확인
    if conn.is_connected():
        print('Successfully connected to the database')
        cursor = conn.cursor()
        
        delete_query = "TRUNCATE TABLE space"
        cursor.execute(delete_query)
        delete_query = "TRUNCATE TABLE sensor"
        cursor.execute(delete_query)
        delete_query = "TRUNCATE TABLE crop"
        cursor.execute(delete_query)

        insert_query = '''
        INSERT INTO crop (max_x, max_y, min_x, min_y)
        VALUES (%s, %s, %s, %s)
        '''

        cursor.execute(insert_query, (int(max_x), int(max_y), int(min_x), int(min_y)))

        # OCR 결과를 데이터베이스에 저장하는 SQL 쿼리
        insert_query = '''
        INSERT INTO space (name, x, y)
        VALUES (%s, %s, %s)
        '''

        # 필터링된 OCR 결과를 데이터베이스에 저장
        for (bbox, text, prob) in filter_results:
            # 중앙값 계산
            center_x = int((bbox[0][0] + bbox[2][0]) / 4)
            center_y = int((bbox[0][1] + bbox[2][1]) / 4)
            
            # 데이터베이스에 삽입
            cursor.execute(insert_query, (text, center_x, center_y))
        
        # 변동 사항을 데이터베이스에 커밋
        conn.commit()
        print('OCR results have been inserted into the database.')

except Error as e:
    print(f"Error: {e}")

finally:
    if conn.is_connected():
        cursor.close()
        conn.close()
        print('Database connection is closed.')
