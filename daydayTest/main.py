# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.
import random


def print_hi(name):
    # Use a breakpoint in the code line below to debug your script.
    print(f'Hi, {name}')  # Press ⌘F8 to toggle the breakpoint.

'''
    类方法（可调用变量、可被实例调用、可被类调用）
    1、类方法通过@classmethod装饰器实现，只能访问类变量，不能访问实例变量
    2、通过cls参数传递当前类对象，不需要实例化。
'''
class Car(object):
    name = 'BMW'
    def __init__(self, name):
        self.name = name

    def run(self, speed):
        print(self.name, speed, '行驶')

    @classmethod
    def run(cls, speed):
        print(cls.name, speed, '行驶')

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    # print_hi('PyCharm')
    #
    # c = Car('宝马')
    # c.run('110km')

    print(random.randrange(1, 100))
    a = random.randrange(1, 100)

    #1、记录用户输入了多少次
    count = 0
    while count < 10: # 输入少于
        print(count)
        count += 1
    print('结束')

    # Car.run('100km')

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
