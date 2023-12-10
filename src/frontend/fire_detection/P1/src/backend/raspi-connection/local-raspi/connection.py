import requests
import Adafruit_DHT
import time
import random
import json
from multiprocessing import Process
import os
#----------------DHT-----------------
sensor = Adafruit_DHT.DHT11
pin = 23
#----------------MQ5-----------------

#-------------SendingData------------
remote_host = '192.168.4.1'
remote_user = 'pi'
remote_path = '/home/pi/Server/'
json_filename = '/home/pi/pProj/sensor_data.json'
#-----------RASPIINFORMATION---------
sensorId = 1
#----------Create a JSON file--------
i = 0
dataList = []

   
if __name__ == '__main__':
	
	while True:
		
		#Check sensor data
		humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
		
		# Setting data for Server
		if humidity is not None and temperature is not None:
			print(f'index={i}')
			print('Temp={0:0.1f}*C  Humidity={1:0.1f}%'.format(temperature, humidity))
			# Mq-5, fix
			gas = round(random.uniform(1600, 1620),4)
			
			data = {'sensor_id': sensorId, 'temperature': temperature, 'humidity': humidity, 'gas': gas}
			dataList.append(data)
			i += 1
		
		# Post to server
		if i == 25 :
			with open(json_filename, 'w') as jsonfile:
				json.dump(dataList, jsonfile)
				jsonfile.write('\n')  # Add a newline between JSON objects for readability
				print('Data saved to', json_filename)
				i = 0
				dataList = []
			#Sending JSON data to server	
			scp_command = f"sshpass -p abcd1234 scp -r -o StrictHostKeyChecking=no {json_filename} {remote_user}@{remote_host}:{remote_path}"
			result = os.system(scp_command)
		
		time.sleep(0.04)  # 25Hz
