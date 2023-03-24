import array
import pprint

import requests
import xlrd
import xlwt
import os
import logging, time, os, json
from urllib.parse import *

class Detail:
    colId: str
    key: str
    colType: int
    rowId: str
    val: str
    dataType: int
    extInfo: str

    def __str__(self):
        return f'colId={self.colId}, key={self.key}, colType={self.colType}, rowId={self.rowId}, val={self.val}, dataType={self.dataType}, extInfo={self.extInfo}'


class Hero:
    priColId: str
    priKey: str
    priRowId: str
    priVal: str
    icon: str
    # details: Detail

    def __str__(self):
        return f'priColId={self.priColId}, priKey={self.priKey}, priRowId={self.priRowId}, priVal={self.priVal}, icon={self.icon})'

MAX_SIZE = 0 # 当前爬取的最大的数量
RESULTS = []
def fetch_hero_list(page=0, size=20):
    print('获取武将列表')
    hero_url = 'https://galaxias-api.lingxigames.com/ds/ajax/endpoint.json'
    api = '/api/l/owresource/getQueryDataInfoListByCategory'
    gameId = 10000100
    tbId = '350659087930767364'
    categoryIds = '350958444404029449,350958444404029450,350958444404029451,350958444404029452'
    current_page = page
    current_size = size
    param = {"api": api,
             "params": {"gameId": gameId, "tbId": tbId,
                        "categoryIds": categoryIds,
                        "page": current_page,
                        "size": current_size
                        }
             }
    hero_json = requests.post(hero_url, json=param).json()
    if hero_json['success']:
        print('success')
        MAX_SIZE = hero_json['result']['totalCount']
        items = hero_json['result']['items']
        print(type(items), type(RESULTS))
        RESULTS.extend(items)
        print(len(RESULTS))
        if current_size * (page+1) < MAX_SIZE: # 当前爬取的数量还没有到达最大值，继续递归
            current_page += 1
            current_size = 20
            fetch_hero_list(current_page, current_size)
        else:
            # 爬取完成之后，去获取对应武将的详细情况以及下载对应的武将icon
            heros = []
            for item in RESULTS:
                icon = item['details'][0]['val']
                item['icon'] = icon
                print(item)
                if item:
                    print(item)
                    hero = Hero()
                    hero.__dict__ = item
                    heros.append(hero)

            for hero in heros:
                print(hero)
                download_icon(hero.icon, f'{hero.priRowId}_{hero.priVal}')
                fetch_hero_detail(hero.priRowId)
            save_heros_info()
            # fetch_hero_detail()
            # download_hero_icon()
    else:
        print('请求出错')
HEROS_DEATIL_LIST = []
def fetch_hero_detail(priRowId):
    print('获取武将的详情')
    hero_url = 'https://galaxias-api.lingxigames.com/ds/ajax/endpoint.json'
    api = '/api/l/owresource/getQueryDataInfoByPriId'
    gameId = 10000100
    tbId = '350659087930767364'
    param = {"api": api,
             "params": {"gameId": gameId,
                        "tbId": tbId,
                        "priRowId": priRowId
                        }
             }
    hero_json = requests.post(hero_url, json=param).json()
    HEROS_DEATIL_LIST.append(hero_json)


def is_need_download_icon(iconName):
    file = os.path.join(os.getcwd(), f'source/{iconName}.png')
    if os.path.exists(file):
        return None
    else:
        return file

def download_icon(downloadUrl: str, fileName: str):
    print('下载icon')
    saveFile = is_need_download_icon(fileName)
    if saveFile:
        if isinstance(downloadUrl, str):
            # 下载
            try:
                response = requests.get(downloadUrl, timeout=20).content
            except TimeoutError:
                print(f'下载图片超时：{downloadUrl}')
                return downloadUrl
            except Exception as e:
                print(f'下载图片失败：{downloadUrl} -> 原因：{e}')
                return downloadUrl

            with open(saveFile, 'wb') as f:
                f.write(response)
        else:
            print('无法下载')
    else:
        print('icon已经存在')

# 保存获取的数据
def save_heros_info():
    file = os.path.join(os.getcwd(),'data/charater.json')
    try:
        with open(file, 'w', encoding='utf-8-sig') as f:
            for hero in HEROS_DEATIL_LIST:
                json.dump(hero, f, ensure_ascii=False)
    except Exception as e:
        print(f'打开文件出错{e}')

if __name__ == '__main__':
    # 三国志 2017 官网：http://sgz2017.youkia.com/strategy/list
    # 三国志 战略版 官网：https://sgzzlb.lingxigames.com/station

    fetch_hero_list()
    # os.getcwd()
    # path = os.path.join(os.getcwd(), 'source/nihao.png')
    # print(os.getcwd())
    # print(path)
    # download_hero_icon('http://image.aligames.com/s/y9s/g/2020/5/15/445977754491435012.png', '曹擦')


    # url = 'https://sgzzlb.lingxigames.com/station/'
    #
    # htmldata = requests.get(url).text
    # user_agent = settings.USER_AGENT
    # header = {
    #     "User-Agent": user_agent
    # }
    # hero_url = 'https://galaxias-api.lingxigames.com/ds/ajax/endpoint.json'
    # param = {"api": "/api/l/owresource/getQueryDataInfoListByCategory","params":{"gameId":10000100,"tbId":"350659087930767364","categoryIds":"350958444404029449,350958444404029450,350958444404029451,350958444404029452","page":1,"size":20}}
    # hero_json = requests.post(hero_url, header=header, json=param).json()
    # print(hero_json)



