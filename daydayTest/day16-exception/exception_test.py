
'''
    语法：
        try...except...else
        try...except...else...finally...(finally里的代码一定会执行)

'''

'''
    except 的基类
    如果发生的异常和 except 子句中的类是同一个类或者是他的基类，
    则异常和 except 子句中的类是兼容的（但反过来则不成立---列出派生类的except子句与基类兼容）。
'''
class AException(Exception):
    pass

class BException(AException):
    pass

class CException(BException):
    pass

for cls in [AException, BException, CException]:
    try:
        raise cls() # 抛出异常
    except CException:
        print('捕获C异常')
    except BException:
        print('捕获B异常')
    except AException:
        print('捕获A异常')
    else:
        print('没有捕获异常')
    finally:
        print('不管怎么样都要善后')