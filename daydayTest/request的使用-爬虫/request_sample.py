import requests
import pprint


def test_fetch_type():
    # 测试使用不同的请求
    print('开始不同请求')
    url = 'http://httpbin.org/'
    get = requests.get(url+'get')
    post = requests.post(url+'post')
    put = requests.put(url+'put')
    delete = requests.delete(url+'delete')
    head = requests.head(url+'get') # HEAD 请求
    options = requests.options(url+'get')
    print(get.json(), '\n', post.json(), '\n', put.json(), '\n', delete.json(), '\n', head.headers, '\n', options.text)





if __name__ == '__main__':

    pprint.pprint('nihao')
    # url = 'http://www.tipdm.com/tipdm/index.html'
    # rqg = requests.get(url)
    # print('查看结果类型：', type(rqg))
    #
    # print('查看请求状态码:', rqg.status_code)
    #
    # print('查看响应头：', rqg.headers)
    #
    # print('查看编码：', rqg.encoding)
    #
    # print('请求结果:', rqg.text)
    #
    # test_fetch_type()


