
'''
    定义含有默认参数的函数
'''
def def_param_fun(prompt, retries=4, reminder='Please try again!'):
    while True:
        ok = input(prompt)
        if ok in ('y', 'ye', 'yes'):
            return True
        if ok in ('n', 'no', 'nop', 'nope'):
            return False
        retries = retries - 1
        if retries < 0:
            raise ValueError('invalid user response')
        print(reminder)

'''
    以下为调用的方式
'''
# def_param_fun('Do you really want to quit?')q
# def_param_fun('Do you really want to quit?', 2)
# def_param_fun('Do you really want to quit?', 2, 'Please, yes or no')

'''
    *重要：使用默认值参数时，如果我们的默认值是一个可变对象时，我们调用函数可能出现不符合我们预期的结果。
    如下：
'''
def f(a, l=[]):
    l.append(a)
    return l

# 调用上面的函数如下
print(f(1)) # [1]
print(f(2)) # [1, 2]
print(f(3)) # [1, 2, 3]
'''
    由于函数在初始化时，默认值只会执行一次，所以在默认值为可变对象（列表，字典以及大多数类实例），我们需要做以下操作
'''
def f2(a, l=None):
    if l is None:
        l = []
    l.append(a)
    return l

print(f2(1)) # [1]
print(f2(2)) # [2]
print(f2(3)) # [3]

'''
    可变参数：
    函数中定义的参数时可以一个或多个可以变化的，其中 *args 代表着可以传入一个list 或者tuple， **args 代表可以传入一个dict
'''

def variable_fun(kind, *arguments, **keywords):
    print('friend : ', kind, ';')
    print('-' * 40)
    for arg in arguments:
        print(arg)
    print('-' * 40)
    for kw in keywords:
        print(kw, ':', keywords[kw])

variable_fun('xiaoming', 'hello xiaoming', 'nice to meet you!', mother='xiaoma', father='xiaoba', son='see you')
'''
输出如下：
friend :  xiaoming ;
----------------------------------------
hello xiaoming
nice to meet you!
----------------------------------------
mother : xiaoma
father : xiaoba
son : see you
'''

# 还能使用以下方式调用
list01 = ['hello xiaoming', 'nice to meet you ']
dict01 = {'mother': 'xiaoma', 'father': 'xiaoba', 'son': 'see you'}
variable_fun('xiaoming', *list01, **dict01)


'''
    关键字参数
    关键字参数允许调用函数时出入 0  个或任意个含参数名的参数，这样可以让我们灵活的去进行参数调用
'''
def key_fun(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
    print('-- This key_fun wouldn\'t', action, end=' ')
    print('if you put', voltage, 'volts through it.')
    print('-- Lovely plumage, the', type)
    print('-- It\'s', state, '!')

# 函数调用如下
key_fun(100)
# 1 positional argument
key_fun(voltage=1000)
# 1 keyword argument
key_fun(voltage=1000, action='V00000M')
# 2 keyword arguments
key_fun(action='V00000M', voltage=10000)
# 2 keyword arguments
key_fun('a million', 'bereft of life', 'jump')
# 3 positional arguments
key_fun('a thousand', state='pushing up the daisies')
# 1 positional, 1 keyword
