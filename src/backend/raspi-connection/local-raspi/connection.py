import requests
import Adafruit_DHT
import time
import json
from gtts import gTTS
from multiprocessing import Process
import os
import socket
import spidev
#----------------DHT-----------------
sensor = Adafruit_DHT.DHT11
pin = 23
#-------------SENDINGDATA------------
remote_host = '192.168.4.1'
remote_user = 'pi'
remote_path = '/home/pi/Server/'
json_filename = ''
#-----------RASPIINFORMATION---------
sensorId = 1
sesorIp = ''
#----------Create a JSON file--------
i = 0
dataList = []
#----------WARNINGSET---------------
warn_fileName = "warning.json"

#------------------------------------MQ5-----------------------------------------
class McpEx:
    def __init__(self):
        self.spi = spidev.SpiDev()
        self.spi.open(0, 0) 
        self.spi.mode = 3
        self.spi.max_speed_hz = 1000000
 
    def analog_read(self, channel):
        r = self.spi.xfer2([1, (0x08 + channel) << 4, 0])
        adc_out = ((r[1] & 0x03) << 8) + r[2]
        return adc_out
 
    def __call__(self):
        while True:
            adc = self.analog_read(0)
            voltage = adc * 5 / 1023
            #print("ADC = %s(%d) Voltage = %.3fV" % (hex(adc), adc, voltage))
            return adc         
gas = McpEx()

#----------------------------WARNINGPROCESS-----------------------------------
def warn_process(n):
	current_directory = os.path.dirname(os.path.realpath(__file__))
	file_path = os.path.join(current_directory, warn_fileName)
	while True:
		if os.path.exists(file_path):
			with open("warning.json", "r") as json_file:
				data = json.load(json_file)
			text_value = data.get('text', '')
			tts = gTTS(text=text_value, lang='ko', slow=False)
			tts.save("output.mp3")
			os.system("xdg-open output.mp3")
		time.sleep(10)

#---------------------------------MAIN-----------------------------------------
if __name__ == '__main__':
	
	#Warning process on
	warn_p = Process(target=warn_process, args=(1,))
	warn_p.start()
	
	#Checking own ip adress
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(("8.8.8.8", 80))
	sensorIp = s.getsockname()[0]
	json_filename = "/home/pi/pProj/" + sensorIp +".json"
	print(json_filename)
	
	while True:	
		#Check sensor data
		humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
		gasAdc = gas.__call__()
		
		# Setting data for Server
		if humidity is not None and temperature is not None:
			print(f'index={i}')
			data = {'sensor_id': sensorId, 'temperature': temperature, 'humidity': humidity, 'gas': gasAdc}
			dataList.append(data)
			print(data)
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