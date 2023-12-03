import json
import requests
import time

# 화재 감지 조건을 결정하는 함수 정의
def determine_fire_conditions(hum, base_temp=60, base_gas=300):
    if hum <= 29:  # 낮은 습도
        return base_temp * 0.8, base_gas * 0.8
    elif hum >= 61:  # 높은 습도
        return base_temp * 1.2, base_gas * 1.2
    else:  # 보통 습도
        return base_temp, base_gas

# 데이터 업데이트 함수 정의
def update_fire_status(data, recent_temps):
    for entry in data:
        # 습도에 따른 화재 감지 조건 설정
        fire_temp, fire_gas = determine_fire_conditions(entry['hum'])

        # 온도 변화량 체크
        avg_temp = sum(recent_temps) / len(recent_temps) if recent_temps else 0
        temp_change_fire = entry['temp'] >= 2 * avg_temp

        # 화재 조건 체크
        if entry['temp'] >= fire_temp or entry['gas'] >= fire_gas or temp_change_fire:
            entry['fire'] = 1
        else:
            entry['fire'] = 0

        # 최근 온도 리스트 업데이트
        recent_temps.append(entry['temp'])
        if len(recent_temps) > 3:
            recent_temps.pop(0)

    return data

# 파일 경로
file_path = 'temp.json'  # 실제 파일 경로

# 최근 온도 값을 저장하는 리스트
recent_temperatures = []

# 무한 루프
while True:
    # 파일을 읽음
    with open(file_path, 'r') as file:
        data = json.load(file)

    # 데이터 업데이트
    updated_data = update_fire_status(data, recent_temperatures)

    # 업데이트된 데이터를 JSON 형식으로 변환
    json_data = json.dumps(updated_data)

    # POST 요청을 보낼 URL
    url = "http://192.168.4.1"

    # POST 요청 보내기
    response = requests.post(url, data=json_data)

    # 응답 상태 코드와 내용 출력
    print("Status Code:", response.status_code)
    print("Response:", response.text)

    # 1초 대기
    time.sleep(1)
