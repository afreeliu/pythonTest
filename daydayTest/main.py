# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.
import random
from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
    return "测试容器部署"





if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8888)