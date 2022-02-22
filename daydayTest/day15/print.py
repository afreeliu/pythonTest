import json
import math


'''
    格式化输出
'''


# 1、基本使用
print('{}网址："{}!"'.format('Python 技术', 'www.afree_liu@163.com'))

# 2、在括号中的数字用于指向传入对象在 format()中的位置
print('{0} 和 {1}'.format('Hello', 'Python'))
print('{1} 和 {0}'.format('Hello', 'Python'))

# 3、如果在 format() 中使用来关键字参数，那么他们的值会指向使用该名字的参数
print('{name} 网址: {site}'.format(name='Python 技术', site='www.afree_liu@163.com'))

# 4、位置和关键字可以任意组合（注意，关键字参数需要放在所有参数的末尾，format方法会将没有关键字的参数组合成一个元组，位置访问不能超越元组的数量）
print('电商网站{0}{1}{name}'.format('淘宝', '京东', name='平多多'))

# 5、用 ** 标志将字典以关键字参数方式传入
print("repr() show quotes: {!a}; str() doesn't:{!s}".format('test1', 'test2'))

# 6、字段名后允许可选的:和格式指令
'''
    将 PI 转为三位精度
'''
print('The value of PI is approximately {0:.3f}.'.format(math.pi))

# 7、在字段后的：后面加一个整数会限定该字段的最小宽度
table = {'Sjoerd': 138, 'Jack': 456, 'Dcab': 789}
for name, phone in table.items():
    ''' {}中的 ：号左边表示 format 参数中的第一个（即name），右边表示间隔 '''
    print('{0:10}{1:10d}'.format(name, phone))

# 8、如果有个很长的格式化字符串，不想分割它可以传入一个字典，用中括号（[]）访问它的键
print('Jack:{0[Jack]:d}; Sjoerd:{0[Sjoerd]:d}; Dcab:{0[Dcab]:d}'.format(table))
# 还可以用 ** 标志将这个字典以关键字参数的方式传入
print('Jack:{Jack:d}; Sjoerd:{Sjoerd:d}; Dcab:{Dcab:d}'.format(**table))

'''
    读取键盘的输入
'''
# str = input('请输入内容：');
# print('输入的内容是:{}'.format(str))



'''
    函数 open()返回文件对象，通常的用法需要两个参数：open(filenam, mode)。
    filename：需要访问的文件名称
    mode：操作文件的方式：（默认为 r ）
        r：只读；
        w：只写入文件，已经存在的文件将被覆盖内容；
        a：打开文件进行追加内容
        r+：打开文件进行读写；
        rb+：以二进制格式打开一个文件用于读写...
'''
# f = open('tmp.txt', 'r')
# read(size): size 为可选参数，不填则为全部内容
# str = f.read()

# readline():读取一行
# str = f.readline()
# while str:
#     print(str)
#     str = f.readline()
# f.close()

# readlines(): 读取文件中包含的所有行，可设置可选参数size
# str = f.readlines()
# print(str)
# f.close()

# write(string) 将string的内容写入文件
# f = open('tmp.txt', 'w')
# num = f.write('Hello Python')
# print(num)
# f.close()

# seek(offset, from_what) 改变文件当前位置。
    # offset 移动距离；
    # from_what 起始位置， 0：表示开头， 1：表示当前位置；2：表示结尾。默认值为 0
# f = open('tmp.txt', 'r', encoding='utf-8')
# # f.write('你好啊你知道我是谁么')
# # 移动到文件的第 6 个字节
# # f.seek(6)# 如果是中文字符，那么移动的距离必须为偶数，不然会报错
# try:
#     f.seek(6)
# except(UnicodeDecodeError):
#     print('字符编码错误')
# except:
#     print('未知错误')
# finally:
#     print('结束错误了')

# print(f.read())
# tell() 返回文件对象当前所处的位置，他是从文件开头开始算起的字节数
# print(f.tell())
# print(f.read())
# f.close()


'''
    操作 json 格式数据
    json.dumps(obj=obj) 序列化，obj 转换为 json 格式的字符串
    json.dump(obj, fb) 序列化，将 obj 转换为 json 格式的字符串，将字符写入文件
    json.loads(str) 反序列化，将json格式的字符串反序列化为一个 Python 对象
    json.load(fb)反序列化，从文件中读取含 json 格式的数据，将之反序列化为一个 Python对象
'''

data = {'id': '1', 'name': 'json', 'age': 12}
with open('test.json', 'w') as f:
    json.dump(data, f)

with open('test.json', 'r') as f1:
    d = json.load(f1)
    print(d)



