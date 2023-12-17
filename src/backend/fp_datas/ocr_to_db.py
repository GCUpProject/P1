import cv2
import easyocr
import mysql.connector
from mysql.connector import Error

# 데이터베이스 연결 설정
db_config = {
    'user': 'dbid233',
    'password': 'dbpass233',
    'host': 'localhost',
    'database': 'db23320',
    'port': 3306
}

# 이미지 불러오기
image = cv2.imread('images/floor_plan.png')

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

# 필터링할 단어 목록을 정의합니다.
keywords = ['실', '방', '룸', '호', '홀', '관', '구', '대피', '피난', '공간', '복도', '식당', '테라스', '태라스', '펜트리', '팬트리', '드레스', '발코니']

# 확률이 0.9 이상이고 특정 단어를 포함하는 결과만 필터링합니다.
filter_results = [item for item in results if item[2] >= 0.2 and any(keyword in item[1] for keyword in keywords)]

try:
    # 데이터베이스에 연결
    conn = mysql.connector.connect(**db_config)
    
    # 연결이 성공했는지 확인
    if conn.is_connected():
        print('Successfully connected to the database')
        cursor = conn.cursor()
        
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
