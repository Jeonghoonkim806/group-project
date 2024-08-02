import pyodbc
import tkinter as tk
from tkinter import filedialog
import os

# ODBC 연결 설정
dsn = 'MyOracleDSN'
user = 'semi_2405_team1'
password = '1234'

connection_string = f'DSN={dsn};UID={user};PWD={password}'
db = pyodbc.connect(connection_string)
cursor = db.cursor()

def insert_filename(filename):
    query = "INSERT INTO mp4_metadata (filename) VALUES (?)"
    cursor.execute(query, filename)
    db.commit()

# Tkinter를 사용하여 파일 선택 다이얼로그 열기
root = tk.Tk()
root.withdraw()  # Tkinter 창 숨기기

file_path = filedialog.askopenfilename(filetypes=[("MP4 files", "*.mp4")])
if file_path:
    filename = os.path.basename(file_path)  # 파일 이름만 추출
    insert_filename(filename)
    print(f"Filename '{filename}' inserted successfully.")
else:
    print("No file selected.")

# 데이터베이스 연결 종료
cursor.close()
db.close()