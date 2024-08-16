import pyodbc
import os

# 데이터베이스 연결 설정
dsn = 'MyOracleDSN'  # 또는 직접 ODBC 드라이버와 연결 문자열 사용
user = 'semi_2405_team1'
password = '1234'

connection_string = f'DSN={dsn};UID={user};PWD={password}'
db = pyodbc.connect(connection_string)
cursor = db.cursor()

def insert_filename(filename):
    query = "INSERT INTO mp4_metadata (filename) VALUES (?)"
    cursor.execute(query, filename)
    db.commit()

def process_directory(directory_path):
    # 디렉토리 내 모든 mp4 파일을 처리
    for filename in os.listdir(directory_path):
        if filename.endswith('.mp4'):
            insert_filename(filename)
            print(f"Filename '{filename}' inserted successfully.")

# .mp4 파일들이 있는 디렉토리 경로g
directory_path = 'path/to/your/mp4/files'

# 디렉토리 내 .mp4 파일 처리
process_directory(directory_path)

# 데이터베이스 연결 종료
cursor.close()
db.close()