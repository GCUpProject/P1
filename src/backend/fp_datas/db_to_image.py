import cv2
import mysql.connector
from PIL import Image, ImageDraw, ImageFont
import numpy as np

def draw_text(img, text, font_path, font_size):
    # OpenCV 이미지를 PIL 이미지로 변환
    img_pil = Image.fromarray(img)
    draw = ImageDraw.Draw(img_pil)
                    
    # 사용할 폰트와 크기 지정
    font = ImageFont.truetype(font_path, font_size)
    #font = ImageFont.truetype("NotoSansCJK-Bold", font_size)

    text_y = 20
    if len(text) == 4:
        text_x = 10
    if len(text) == 3:
        text_x = 30
    if len(text) == 2:
        text_x = 55

    # 텍스트 그리기
    draw.text((text_x,text_y), text, font=font, fill=(0,0,0))
    #print(text)
                                            
    # PIL 이미지를 OpenCV 이미지로 다시 변환
    return np.array(img_pil)


# 이미지 파일 경로
floor_plan_path = 'images/floor_plan.png'
fire_icon_path = 'images/fire.png'
extinguisher_icon_path = 'images/extinguisher.png'
exit_icon_path = 'images/exit.png'

# 이미지 읽기
floor_plan = cv2.imread(floor_plan_path, cv2.IMREAD_UNCHANGED)
if len(floor_plan.shape) == 2:
    floor_plan = cv2.cvtColor(floor_plan, cv2.COLOR_GRAY2BGR)
fire_icon = cv2.imread(fire_icon_path, cv2.IMREAD_UNCHANGED)
extinguisher_icon = cv2.imread(extinguisher_icon_path, cv2.IMREAD_UNCHANGED)
exit_icon = cv2.imread(exit_icon_path, cv2.IMREAD_UNCHANGED)

# DB 설정
db_config = {
    'user': 'dbid233',
    'password': 'dbpass233',
    'host': '127.0.0.1',
    'port': '3306',
    'database': 'db23320'
}

# 이미지에 아이콘과 텍스트를 그리는 함수
def draw_icon_with_text(img, icon, text, center_x, center_y):
    icon_height, icon_width = icon.shape[:2]

    top_left_x = center_x - icon_width // 2
    top_left_y = center_y - icon_height // 2

    # 아이콘 그리기
    alpha_icon = icon[:, :, 3] / 255.0
    alpha_image = 1.0 - alpha_icon
    for c in range(0, 3):
        img[top_left_y:top_left_y+icon_height, top_left_x:top_left_x+icon_width, c] = (
            alpha_icon * icon[:, :, c] +
            alpha_image * img[top_left_y:top_left_y+icon_height, top_left_x:top_left_x+icon_width, c]
        )

# 데이터베이스 연결 및 정보 읽기
try:
    db_connection = mysql.connector.connect(**db_config)
    cursor = db_connection.cursor()

    # sensor 테이블에서 센서의 총 수를 가져옴
    cursor.execute("SELECT COUNT(*) FROM sensor")
    sensor_count = cursor.fetchone()[0]

    # 비상구 아이콘 배치
    cursor.execute("SELECT space.x, space.y, space.name FROM sensor JOIN space ON sensor.space_id = space.`index` WHERE sensor.exit = 1")
    exit_spaces = cursor.fetchall()
    for x, y, name in exit_spaces:
        text_icon = draw_text(exit_icon, name, "NanumGothicBold.ttf", 50)
        draw_icon_with_text(floor_plan, text_icon, name, x, y)

    # 소화기 아이콘 배치
    cursor.execute("SELECT space.x, space.y, space.name FROM sensor JOIN space ON sensor.space_id = space.`index` WHERE sensor.extinguisher = 1")
    extinguisher_spaces = cursor.fetchall()
    for x, y, name in extinguisher_spaces:
        text_icon = draw_text(extinguisher_icon, name, "NanumGothicBold.ttf", 50)
        draw_icon_with_text(floor_plan, text_icon, name, x, y)

    # 화재 아이콘 배치
    cursor.execute("SELECT sensor_id FROM test WHERE fire = 1 ORDER BY created_at DESC LIMIT %s", (sensor_count,))
    fire_tests = cursor.fetchall()
    for sensor_id, in fire_tests:
        cursor.execute("SELECT space_id FROM sensor WHERE `index` = %s", (sensor_id,))
        space_id_record = cursor.fetchone()
        if space_id_record:
            space_id = space_id_record[0]
            cursor.execute("SELECT x, y, name FROM space WHERE `index` = %s", (space_id,))
            space_record = cursor.fetchone()
            if space_record:
                x, y, name = space_record
                text_icon = draw_text(fire_icon, name, "NanumGothicBold.ttf", 50)
                draw_icon_with_text(floor_plan, text_icon, name, x, y)

except mysql.connector.Error as e:
    print(f"Error: {e}")
finally:
    if db_connection.is_connected():
        cursor.close()
        db_connection.close()

# 결과 이미지를 저장하고 보여주기
cv2.imwrite('result.png', floor_plan)
#cv2.imshow('Floor Plan with Exits, Extinguishers, and Fire', floor_plan)
cv2.waitKey(0)
cv2.destroyAllWindows()
