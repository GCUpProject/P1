import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class MyHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.is_directory:
            return
        elif event.src_path.endswith("sensor_data.json"):
            print(f"새 파일이 생성되었습니다: {event.src_path}")
            copy_file(event.src_path)

def copy_file(src_path):
    local_path = "./"  # 로컬 디렉토리는 원하는 경로로 변경할 수 있습니다.
    scp_command = f"scp {src_path} {local_path}"
    try:
        os.system(scp_command)
        print("파일이 성공적으로 복사되었습니다.")
    except Exception as e:
        print(f"파일 복사 중 오류 발생: {e}")

def watch_remote_directory():
    remote_path = "/home/pi/pProj/"
    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, remote_path, recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == "__main__":
    watch_remote_directory()
