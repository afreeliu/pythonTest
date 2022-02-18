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
