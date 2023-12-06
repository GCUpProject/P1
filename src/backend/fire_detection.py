import json
import requests
import time

def calculate_averages_and_detect_fire(sensor_data, recent_temps):
    sum_data = {'temperature': 0, 'humidity': 0, 'gas': 0}

    for entry in sensor_data:
        sum_data['temperature'] += entry['temperature']
        sum_data['humidity'] += entry['humidity']
        sum_data['gas'] += entry['gas']

    avg_data = {key: value / len(sensor_data) for key, value in sum_data.items()}

    def determine_fire_conditions(hum, base_temp=60, base_gas=3000):
        if hum <= 29:
            return base_temp * 0.8, base_gas * 0.8
        elif hum >= 61:
            return base_temp * 1.2, base_gas * 1.2
        else:
            return base_temp, base_gas

    fire_temp, fire_gas = determine_fire_conditions(avg_data['humidity'])

    # 이전 온도 평균 계산
    avg_temp = (
        sum(recent_temps) / len(recent_temps)
    ) if recent_temps else 0

    # 온도 변화량이 2배 이상일 경우 화재 판단
    temp_change_fire = False
    if len(recent_temps) >= 3:
        avg_temp = sum(recent_temps) / len(recent_temps)
        temp_change_fire = avg_data['temperature'] >= 2 * avg_temp

    fire_status = 1 if (
        avg_data['temperature'] >= fire_temp 
        or avg_data['gas'] >= fire_gas 
        or temp_change_fire
    ) else 0

    # 최근 온도 리스트 업데이트
    recent_temps.append(avg_data['temperature'])
    if len(recent_temps) > 3:
        recent_temps.pop(0)

    return avg_data, fire_status

# 파일 경로
file_path = 'sensor_data.json'  # 실제 파일 경로

# 최근 온도 값을 저장하는 리스트
recent_temperatures = []

# 무한 루프
while True:
    with open(file_path, 'r') as file:
        sensor_data = json.load(file)

    avg_data, fire_status = calculate_averages_and_detect_fire(sensor_data, recent_temperatures)
    avg_data['fire'] = fire_status

    print(avg_data)

    url = "http://ceprj.gachon.ac.kr:60035"
    response = requests.post(url, data=json.dumps(avg_data), auth=('t23320', 'dovev2023'))

    print("Status Code:", response.status_code)
    print("Response:", response.text)

    time.sleep(1)
