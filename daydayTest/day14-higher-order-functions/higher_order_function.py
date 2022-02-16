from math import factorial
'''

    Python 中的高阶函数

    在函数式编程中，我们可以将函数当作变量一样自由使用。一个函数接收另一个函数作为参数，这种函数称之为高阶函数
'''
# 例如：
def high_func(f, arr):
    return [f(x) for x in arr]
# 上面例子中，hight_func 就是一个高阶函数。其中第一个参数 f 是一个函数，第二个参数 arr 是一个数组
# 返回的值是数组中的所有的值再经过 f 函数计算后得到的一个列表


def square(n):
    return n**2

# 使用 python 自带的数学函数
print(high_func(factorial, list(range(10))))

# 使用自定义函数
print(high_func(square, list(range(10))))

'''
    python 中常用的高阶函数就那几个如下：
    map：（根据提供的函数对指定序列做映射，并返回映射后的序列）
        定义：map(func, *iterables) --> map object
        func：序列中的每个元素需要执行的操作，可以是匿名函数
        iterables：一个或多个序列
        
    reduce：（reduce函数需要传入一个有两个参数的函数，然后用这个函数从左至右顺序遍历序列并生成结果）
        定义：reduce(func, sequence[, initial]) -> value
        func：函数，序列中的每个元素需要执行的操作，可以是匿名函数
        sequence：需要执行操作的序列
        initial：可选，初始参数
        最后返回函数的计算结果，和初始参数类型相同
        
    filter：（filter（）函数用来过滤序列中不符合条件的值，返回一个迭代器，该迭代器生成那些函数（项）为true的iterable项。如果函数为None，则返回true的项。
        定义：filter(function or None, iterable) --> filter object
        function or None： 过滤操作执行的函数
        iterable：需要过滤的序列
        
    sorted：（sorted 函数默认将序列升序排列后返回一个新的list，还可以自定义键函数来进行排序，也可以设置 reverse 参数确定是升序还是降序， 如果reverse=true 则为降序）
        定义：sorted(iterable: Iterable[_T], *, key: Optional[Callable[[_T], Any]]=..., reverse: bool=...) -> List[_T]: ...
        iterable：序列
        key：可以用来计算的排序函数
        reverse：排序规则，reverse=true 降序， reverse=false 升序（默认）    
'''