from flask import Flask, request
import datetime
import os

app = Flask(__name__)
LOG_FILE = "/logs/app3_log.txt"

@app.route('/log', methods=['POST'])
def log_message():
    data = request.get_json()
    with open(LOG_FILE, "a") as f:
        f.write(f"{datetime.datetime.now()} - {data}\n")
    return {"status": "logged"}, 200

if __name__ == '__main__':
    os.makedirs("/logs", exist_ok=True)
    app.run(host='0.0.0.0', port=5003)
