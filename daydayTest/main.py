# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.


'''

    如果项目脱离了 pycharm 运行，那么工程当前的导入目录是不会自动添加到当前导入路径的，因此需要手动加入当前工程的路径

'''
import os
import sys
import json
sys.path.append(os.path.dirname(os.path.abspath(__file__))) # 当前执行脚本的目录

from decimal import Decimal
from datetime import datetime

import random
from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
    return "测试容器部署"


''' 
    给定一个类型，统计一个文件夹下所有该类型文件的大小
'''
def caculateDirFileSize(filetype, dir):
    if os.path.isdir(dir):
        generate = os.walk(dir)
        for path, _, files_list in generate:
            for file in files_list:
                absFile = os.path.join(path, file)
                type = absFile.split('.')[-1]
                if type == filetype:
                    fileSize = os.path.getsize(absFile)
                    print(fileSize)
                print(absFile)
                print(type)

'''
    扩展 json 模块中解析的方法，
'''

data = [
    {"id": 1, "name": "是领导看", "size": Decimal("18.99"), 'ctime': datetime.now()},
    {"id": 2, "name": "是打发了", "size": Decimal("9.99"), 'ctime': datetime.now()}

]
# 因为 json 不支持序列化 Decimal 和 datetime 的数据，因此需要扩展json 模块的方法
class MyJsonEncoder(json.JSONEncoder):
    def default(self, o):
        if type(o) == Decimal:
            return str(o)
        elif type(o) == datetime:
            return o.strftime("%Y-%m-%d")
        return super().default(o)


if __name__ == '__main__':
    # app.run(host='0.0.0.0', port=8888)
    # caculateDirFileSize('pdf', '/Users/lufee/Desktop/软考')

    result = json.dumps(data, ensure_ascii=False, cls=MyJsonEncoder)
    print(result)
