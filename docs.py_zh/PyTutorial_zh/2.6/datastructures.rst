.. _tut-structures:

************************
Data Structures 数据结构
************************

This chapter describes some things you've learned about already in more detail,
and adds some new things as well.

本章深入讲述一些你已经学习过的东西，并且还加入了新的内容。

.. _tut-morelists:

More on Lists 元组和序列
======================

The list data type has some more methods.  Here are all of the methods of list
objects:

列表数据类型还有一些方法。这里是 list 对象的所有方法。

.. method:: list.append(x)
   :noindex:

   Add an item to the end of the list; equivalent to ``a[len(a):] = [x]``.

   在 list 末尾添加一项，相当于 ``a[len(a):] = [x]``。


.. method:: list.extend(L)
   :noindex:

   Extend the list by appending all the items in the given list; equivalent to
   ``a[len(a):] = L``.

   将给定 list 的所有项都添加到当前 list 中，相当于 ``a[len(a):] = L``.


.. method:: list.insert(i, x)
   :noindex:

   Insert an item at a given position.  The first argument is the index of the
   element before which to insert, so ``a.insert(0, x)`` inserts at the front of
   the list, and ``a.insert(len(a), x)`` is equivalent to ``a.append(x)``.

   在给定点插入一项。第一个参数是插入位置的索引。所以 ``a.insert(0, x)`` 在 list
   的最前面插入一项， ``a.insert(len(a), x)`` 等于 ``a.append(x)``。


.. method:: list.remove(x)
   :noindex:

   Remove the first item from the list whose value is *x*. It is an error if there
   is no such item.

   在 list 中移除第一个值为 *x* 的项。如果没有匹配项，会发生错误。


.. method:: list.pop([i])
   :noindex:

   Remove the item at the given position in the list, and return it.  If no index
   is specified, ``a.pop()`` removes and returns the last item in the list.  (The
   square brackets around the *i* in the method signature denote that the parameter
   is optional, not that you should type square brackets at that position.  You
   will see this notation frequently in the Python Library Reference.)

   在 list 中移除指定位置的项。如果没有指定索引， ``a.pop()`` 从 list 中移除并返
   回最后一项。（*i* 两边的中括号表示这个参数是可选的，实际输入的时候不要加中括
   号。你会经常在 Python 库参考手册中看到这种记法。）


.. method:: list.index(x)
   :noindex:

   Return the index in the list of the first item whose value is *x*. It is an
   error if there is no such item.

   返回 list 中第一个值为 *x* 的项的索引，如果没有这个项，会发生错误。


.. method:: list.count(x)
   :noindex:

   Return the number of times *x* appears in the list.

   返回 *x* 在 list 中的出现次数。


.. method:: list.sort()
   :noindex:

   Sort the items of the list, in place.

   就地对 list 中的元素排序。

.. method:: list.reverse()
   :noindex:

   Reverse the elements of the list, in place.

   就地对 list 中的元素倒排。

An example that uses most of the list methods::

以下是 list 主要方法的示例： ::

   >>> a = [66.25, 333, 333, 1, 1234.5]
   >>> print a.count(333), a.count(66.25), a.count('x')
   2 1 0
   >>> a.insert(2, -1)
   >>> a.append(333)
   >>> a
   [66.25, 333, -1, 333, 1, 1234.5, 333]
   >>> a.index(333)
   1
   >>> a.remove(333)
   >>> a
   [66.25, -1, 333, 1, 1234.5, 333]
   >>> a.reverse()
   >>> a
   [333, 1234.5, 1, 333, -1, 66.25]
   >>> a.sort()
   >>> a
   [-1, 1, 66.25, 333, 333, 1234.5]


.. _tut-lists-as-stacks:

Using Lists as Stacks 当列表作为堆栈使用
--------------------------------------

.. sectionauthor:: Ka-Ping Yee <ping@lfw.org>


The list methods make it very easy to use a list as a stack, where the last
element added is the first element retrieved ("last-in, first-out").  To add an
item to the top of the stack, use :meth:`append`.  To retrieve an item from the
top of the stack, use :meth:`pop` without an explicit index.  For example::

如果将最后一个添加进来的元素先取出去（“后进先出”），列表可以很方便的当作堆栈使用。
使用 :meth:`append` 可以添加在栈顶添加元素。使用无参数的 :meth:`pop` 可以从栈顶
弹出一个元素。例如： ::

   >>> stack = [3, 4, 5]
   >>> stack.append(6)
   >>> stack.append(7)
   >>> stack
   [3, 4, 5, 6, 7]
   >>> stack.pop()
   7
   >>> stack
   [3, 4, 5, 6]
   >>> stack.pop()
   6
   >>> stack.pop()
   5
   >>> stack
   [3, 4]


.. _tut-lists-as-queues:

Using Lists as Queues 将列表作为队列使用
--------------------------------------

.. sectionauthor:: Ka-Ping Yee <ping@lfw.org>


You can also use a list conveniently as a queue, where the first element added
is the first element retrieved ("first-in, first-out").  To add an item to the
back of the queue, use :meth:`append`.  To retrieve an item from the front of
the queue, use :meth:`pop` with ``0`` as the index.  For example::

你也可以把链表当做队列使用，队列作为特定的数据结构，最先进入的元素最先释放（先进先出）。
使用 append()方法可以把元素添加到队列最后，以0为参数调用 pop() 方法可以把最先进入的
元素释放出来。例如： ::

   >>> queue = ["Eric", "John", "Michael"]
   >>> queue.append("Terry")           # Terry arrives
   >>> queue.append("Graham")          # Graham arrives
   >>> queue.pop(0)
   'Eric'
   >>> queue.pop(0)
   'John'
   >>> queue
   ['Michael', 'Terry', 'Graham']


.. _tut-functional:

Functional Programming Tools  函数化编程工具
------------------------------------------

There are three built-in functions that are very useful when used with lists:
:func:`filter`, :func:`map`, and :func:`reduce`.

使用 list 的时候，有三个内置的函数非常有用，它们是： :func:`filter`,
:func:`map`, 和 :func:`reduce`.

``filter(function, sequence)`` returns a sequence consisting of those items from
the sequence for which ``function(item)`` is true. If *sequence* is a
:class:`string` or :class:`tuple`, the result will be of the same type;
otherwise, it is always a :class:`list`. For example, to compute some primes::

``filter(function, sequence)`` 返回一个序列，包含原序列中 ``function(item)`` 为
真的项。如果 *sequence* 是一个 :class:`string` 或 :class:`tuple`，返回值应该是同
一类型。否则，它总是返回一个 :class:`list` 。例如，要计算素数： ::

   >>> def f(x): return x % 2 != 0 and x % 3 != 0
   ...
   >>> filter(f, range(2, 25))
   [5, 7, 11, 13, 17, 19, 23]

``map(function, sequence)`` calls ``function(item)`` for each of the sequence's
items and returns a list of the return values.  For example, to compute some
cubes::

``map(function, sequence`` 对 sequence 的每一项调用 ``function(item)``，将返回值
合成一个列表。例如，以下计算立方表： ::

   >>> def cube(x): return x*x*x
   ...
   >>> map(cube, range(1, 11))
   [1, 8, 27, 64, 125, 216, 343, 512, 729, 1000]

More than one sequence may be passed; the function must then have as many
arguments as there are sequences and is called with the corresponding item from
each sequence (or ``None`` if some sequence is shorter than another).  For
example::

如果传入多于一个的序列，function 必须接收多个参数，它们是每个序列的对应项（如果
某些序列比较短，就对应 ``None``）。例如： ::

   >>> seq = range(8)
   >>> def add(x, y): return x+y
   ...
   >>> map(add, seq, seq)
   [0, 2, 4, 6, 8, 10, 12, 14]

``reduce(function, sequence)`` returns a single value constructed by calling the
binary function *function* on the first two items of the sequence, then on the
result and the next item, and so on.  For example, to compute the sum of the
numbers 1 through 10::

``reduce(function, sequence)`` 对序列前两个元素调用函数 *function* ，然后用返回
值和下一个元素再次调用 *function* ，直至结束，生成一个单值。例如，以下计算 1 到
10 的总和： ::

   >>> def add(x,y): return x+y
   ...
   >>> reduce(add, range(1, 11))
   55

If there's only one item in the sequence, its value is returned; if the sequence
is empty, an exception is raised.

如果序列中只有一项，这个值就会被返回，如果序列是空的，就会抛出异常。

A third argument can be passed to indicate the starting value.  In this case the
starting value is returned for an empty sequence, and the function is first
applied to the starting value and the first sequence item, then to the result
and the next item, and so on.  For example, ::

第三个参数可以传递一个初始值。这种情况下空序列会返回初始值，函数首先使用初始值和
序列的第一项，然后是返回值和下一项，依此类推。例如： ::

   >>> def sum(seq):
   ...     def add(x,y): return x+y
   ...     return reduce(add, seq, 0)
   ... 
   >>> sum(range(1, 11))
   55
   >>> sum([])
   0

Don't use this example's definition of :func:`sum`: since summing numbers is
such a common need, a built-in function ``sum(sequence)`` is already provided,
and works exactly like this.

不要使用本例中定义的 :func:`sum`：因为总计数目是一个通用的需求，Python 已经提供
了一个内置函数 ``sum(sequence)``，它工作的很好。

.. versionadded:: 2.3


List Comprehensions 列表推导式
-----------------------------

List comprehensions provide a concise way to create lists without resorting to
use of :func:`map`, :func:`filter` and/or :keyword:`lambda`. The resulting list
definition tends often to be clearer than lists built using those constructs.
Each list comprehension consists of an expression followed by a :keyword:`for`
clause, then zero or more :keyword:`for` or :keyword:`if` clauses.  The result
will be a list resulting from evaluating the expression in the context of the
:keyword:`for` and :keyword:`if` clauses which follow it.  If the expression
would evaluate to a tuple, it must be parenthesized. ::

列表推导式提供了从序列创建列表的简单途径，不需要使用 :func:`map`，
:func:`filter` 以及 :keyword:`lambda` 。生成的列表定义通常来说比其它构造方式更为
清晰。每个列表推导式包括一个 :keyword:`for` 块之后的表达式，然后可以有零到多个 
:keyword:`for` 或 :keyword:`if` 子句。返回结果是一个根据 :keyword:`for` 和 
:keyword:`if` 上下文解析得到的列表。如果想要表达式解析为元组，就要用括号： ::

   >>> freshfruit = ['  banana', '  loganberry ', 'passion fruit  ']
   >>> [weapon.strip() for weapon in freshfruit]
   ['banana', 'loganberry', 'passion fruit']
   >>> vec = [2, 4, 6]
   >>> [3*x for x in vec]
   [6, 12, 18]
   >>> [3*x for x in vec if x > 3]
   [12, 18]
   >>> [3*x for x in vec if x < 2]
   []
   >>> [[x,x**2] for x in vec]
   [[2, 4], [4, 16], [6, 36]]
   >>> [x, x**2 for x in vec]	# error - parens required for tuples
     File "<stdin>", line 1, in ?
       [x, x**2 for x in vec]
                  ^
   SyntaxError: invalid syntax
   >>> [(x, x**2) for x in vec]
   [(2, 4), (4, 16), (6, 36)]
   >>> vec1 = [2, 4, 6]
   >>> vec2 = [4, 3, -9]
   >>> [x*y for x in vec1 for y in vec2]
   [8, 6, -18, 16, 12, -36, 24, 18, -54]
   >>> [x+y for x in vec1 for y in vec2]
   [6, 5, -7, 8, 7, -5, 10, 9, -3]
   >>> [vec1[i]*vec2[i] for i in range(len(vec1))]
   [8, 12, -54]

List comprehensions are much more flexible than :func:`map` and can be applied
to complex expressions and nested functions::

列表推导式比 :func:`map` 具有更高的灵活性，可以应用复杂的表达式，也可以嵌套函数： ::

   >>> [str(round(355/113.0, i)) for i in range(1,6)]
   ['3.1', '3.14', '3.142', '3.1416', '3.14159']


Nested List Comprehensions 嵌套的列表推导式
----------------------------------------

If you've got the stomach for it, list comprehensions can be nested. They are a
powerful tool but -- like all powerful tools -- they need to be used carefully,
if at all.

如果你对它有胃口，列表推导式也可以嵌套。这是个强大的工具，不过－－像所有的强大的
工具一样－－它需要小心使用。

Consider the following example of a 3x3 matrix held as a list containing three 
lists, one list per row::

考虑以下 3x3 矩阵示例，它由一个包含三个列表的列表表示，每行一个列表： ::

    >>> mat = [
    ...        [1, 2, 3],
    ...        [4, 5, 6],
    ...        [7, 8, 9],
    ...       ]

Now, if you wanted to swap rows and columns, you could use a list 
comprehension::

现在，如果你想要交换行或列，可以使用列表推导式： ::

    >>> print [[row[i] for row in mat] for i in [0, 1, 2]]
    [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

Special care has to be taken for the *nested* list comprehension:

在*嵌套的*列表推导式中特别要注意的是：

    To avoid apprehension when nesting list comprehensions, read from right to
    left.

	从右向左阅嵌套的列表推导式，更容易阅读。

A more verbose version of this snippet shows the flow explicitly::

一个更冗长一些的版本清楚的解释了这个过程： ::

    for i in [0, 1, 2]:
        for row in mat:
            print row[i],
        print

In real world, you should prefer builtin functions to complex flow statements. 
The :func:`zip` function would do a great job for this use case::

在实用中，你可以使用内置函数简化复杂流程。 函数 :func:`zip` 在这种情况下做的更棒： ::

    >>> zip(*mat)
    [(1, 4, 7), (2, 5, 8), (3, 6, 9)]

See :ref:`tut-unpacking-arguments` for details on the asterisk in this line.

关于本行的星号，详情参见 :ref:`tut-unpacking-arguments`。

.. _tut-del:

The :keyword:`del` statement :keyword:`del` 语法
================================================

There is a way to remove an item from a list given its index instead of its
value: the :keyword:`del` statement.  This differs from the :meth:`pop` method
which returns a value.  The :keyword:`del` statement can also be used to remove
slices from a list or clear the entire list (which we did earlier by assignment
of an empty list to the slice).  For example::

有个办法可以按列表索引而不是值来移除一个元素，那就是 :keyword:`del` 语句。与返回
值的 :meth:`pop` 方法不同，:keyword:`del` 也可以从列表中移除一个片段，或者清空整
个列表（我们早先用一个空列表代替掉一个切割片段实现了这个功能）。例如：

   >>> a = [-1, 1, 66.25, 333, 333, 1234.5]
   >>> del a[0]
   >>> a
   [1, 66.25, 333, 333, 1234.5]
   >>> del a[2:4]
   >>> a
   [1, 66.25, 1234.5]
   >>> del a[:]
   >>> a
   []

:keyword:`del` can also be used to delete entire variables::

:keyword:`del` 也可以删除整个变量: ::

   >>> del a

Referencing the name ``a`` hereafter is an error (at least until another value
is assigned to it).  We'll find other uses for :keyword:`del` later.

此后再引用命名 ``a`` 就是错误了（至少在给它再次赋值前）。我们以后会看到
:keyword:`del` 的其它用途。

.. _tut-tuples:

Tuples and Sequences 元组和序列
=============================

We saw that lists and strings have many common properties, such as indexing and
slicing operations.  They are two examples of *sequence* data types (see
:ref:`typesseq`).  Since Python is an evolving language, other sequence data
types may be added.  There is also another standard sequence data type: the
*tuple*.

我们知道列表和字符串有很多通用的属性，例如索引和切割操作。它们是序列类型中的两种（参见 
:ref:`typesseq` ）。困为 Python 是一个在不断进化的语言，也可能会加入其它的序列类型。
这里我们介绍另一个标准序列类型： *tuple （元组）* 。

A tuple consists of a number of values separated by commas, for instance::

元组由若干逗号分隔的值组成，例如： ::

   >>> t = 12345, 54321, 'hello!'
   >>> t[0]
   12345
   >>> t
   (12345, 54321, 'hello!')
   >>> # Tuples may be nested:
   ... u = t, (1, 2, 3, 4, 5)
   >>> u
   ((12345, 54321, 'hello!'), (1, 2, 3, 4, 5))

As you see, on output tuples are always enclosed in parentheses, so that nested
tuples are interpreted correctly; they may be input with or without surrounding
parentheses, although often parentheses are necessary anyway (if the tuple is
part of a larger expression).

如你所见，元组在输出时总是有括号的，以便于正确表达嵌套结构。在输入时可能有或没有括号， 不过括
号通常是必须的（如果元组是更大的表达式的一部分）。

Tuples have many uses.  For example: (x, y) coordinate pairs, employee records
from a database, etc.  Tuples, like strings, are immutable: it is not possible
to assign to the individual items of a tuple (you can simulate much of the same
effect with slicing and concatenation, though).  It is also possible to create
tuples which contain mutable objects, such as lists.

元组有很多用途。例如(x, y)坐标点，数据库中的员工记录等等。元组就像字符串，不可改变：不能给
元组的一个独立的元素赋值（尽管你可以通过联接和切割来模仿）。也可以通过包含可变对象来创建元组，
例如链表。

A special problem is the construction of tuples containing 0 or 1 items: the
syntax has some extra quirks to accommodate these.  Empty tuples are constructed
by an empty pair of parentheses; a tuple with one item is constructed by
following a value with a comma (it is not sufficient to enclose a single value
in parentheses). Ugly, but effective.  For example::

一个特殊的问题是构造包含零个或一个元素的元组：为了适应这种情况，语法上有一些额外的改变。
一对空的括号可以创建空元组；要创建一个单元素元组可以在值后面跟一个逗号（在括号中放入一
个单值是不够的）。丑陋，但是有效。例如：

   >>> empty = ()
   >>> singleton = 'hello',    # <-- note trailing comma
   >>> len(empty)
   0
   >>> len(singleton)
   1
   >>> singleton
   ('hello',)

The statement ``t = 12345, 54321, 'hello!'`` is an example of *tuple packing*:
the values ``12345``, ``54321`` and ``'hello!'`` are packed together in a tuple.
The reverse operation is also possible::

语句 ``t = 12345, 54321, 'hello!'`` 是元组封装（sequence packing）的一个例子：
值 12345， 54321 和 'hello!' 被封装进元组。其逆操作可能是这样：

   >>> x, y, z = t

This is called, appropriately enough, *sequence unpacking*. Sequence unpacking
requires the list of variables on the left to have the same number of elements
as the length of the sequence.  Note that multiple assignment is really just a
combination of tuple packing and sequence unpacking!

称其为*序列拆封*非常合适。序列拆封要求左侧的变量数目与序列的元素个数相同。要注意的是可变参数
（multiple assignment ）其实只是元组封装和序列拆封的一个结合！

There is a small bit of asymmetry here:  packing multiple values always creates
a tuple, and unpacking works for any sequence.

这里有一点不对称：封装多重参数通常会创建一个元组，而拆封操作可以作用于任何序列。

.. XXX Add a bit on the difference between tuples and lists.


.. _tut-sets:

Sets 集合
========

Python also includes a data type for *sets*.  A set is an unordered collection
with no duplicate elements.  Basic uses include membership testing and
eliminating duplicate entries.  Set objects also support mathematical operations
like union, intersection, difference, and symmetric difference.

Python 还包含了一个数据类型—— *set*（集合）。集合是一个无序不重复元素的集。基本功能包括关系测
试和消除重复元素。集合对象还支持 union（联合），intersection（交），difference（差）和
sysmmetric difference（对称差集）等数学运算。

Here is a brief demonstration::

以下是一个简单的演示： ::

   >>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
   >>> fruit = set(basket)               # create a set without duplicates
   >>> fruit
   set(['orange', 'pear', 'apple', 'banana'])
   >>> 'orange' in fruit                 # fast membership testing
   True
   >>> 'crabgrass' in fruit
   False

   >>> # Demonstrate set operations on unique letters from two words
   ...
   >>> a = set('abracadabra')
   >>> b = set('alacazam')
   >>> a                                  # unique letters in a
   set(['a', 'r', 'b', 'c', 'd'])
   >>> a - b                              # letters in a but not in b
   set(['r', 'd', 'b'])
   >>> a | b                              # letters in either a or b
   set(['a', 'c', 'r', 'd', 'b', 'm', 'z', 'l'])
   >>> a & b                              # letters in both a and b
   set(['a', 'c'])
   >>> a ^ b                              # letters in a or b but not both
   set(['r', 'd', 'b', 'm', 'z', 'l'])


.. _tut-dictionaries:

Dictionaries 字典
================

Another useful data type built into Python is the *dictionary* (see
:ref:`typesmapping`). Dictionaries are sometimes found in other languages as
"associative memories" or "associative arrays".  Unlike sequences, which are
indexed by a range of numbers, dictionaries are indexed by *keys*, which can be
any immutable type; strings and numbers can always be keys.  Tuples can be used
as keys if they contain only strings, numbers, or tuples; if a tuple contains
any mutable object either directly or indirectly, it cannot be used as a key.
You can't use lists as keys, since lists can be modified in place using index
assignments, slice assignments, or methods like :meth:`append` and
:meth:`extend`.

另一个非常有用的 Python 内建数据类型是*字典*（参见 :ref:`typesmapping`）。字典在某些语言
中可能称为“关联存储”（``associative memories''）或“关联数组”（``associative arrays''）。
序列是以连续的整数为索引，与此不同的是，字典以*关键字*为索引，关键字可以是任意不可变类型，通常用
字符串或数值。如果元组中只包含字符串、数字和元组，它可以做为关键字，如果它直接或间接的包含了可变
对象，就不能当做关键字。不能用链表做关键字，因为链表可以用索引、切割或者 append() 和 extend()
等方法改变。

It is best to think of a dictionary as an unordered set of *key: value* pairs,
with the requirement that the keys are unique (within one dictionary). A pair of
braces creates an empty dictionary: ``{}``. Placing a comma-separated list of
key:value pairs within the braces adds initial key:value pairs to the
dictionary; this is also the way dictionaries are written on output.

理解字典的最佳方式是把它看做无序的*键：值*对集合，关键字必须是互不相同的（在同一个字典之内）。
一对大括号创建一个空的字典：``{}``。初始化链表时，在大括号内放置一组逗号分隔的关键字：值对，
这也是字典输出的方式。

The main operations on a dictionary are storing a value with some key and
extracting the value given the key.  It is also possible to delete a key:value
pair with ``del``. If you store using a key that is already in use, the old
value associated with that key is forgotten.  It is an error to extract a value
using a non-existent key.

字典的主要操作是依据关键字来存储和析取值。也可以用 ``del`` 来删除键：值对。如果你用一个已经存
在的关键字存储值，以前为该关键字分配的值就会被遗忘。试图从一个不存在的关键字中读取值会导致错误。

The :meth:`keys` method of a dictionary object returns a list of all the keys
used in the dictionary, in arbitrary order (if you want it sorted, just apply
the :meth:`sort` method to the list of keys).  To check whether a single key is
in the dictionary, use the :keyword:`in` keyword.

字典的 :meth:`keys` 方法返回由所有关键字组成的链表，该链表的顺序不定（如果你需要它有序，
只能调用关键字列表的 :meth:`sort` 方法）。使用 :keyword:`in` 关键字可以检查字典中是
否存在某一关键字。

Here is a small example using a dictionary::

这是一个字典运用的简单例子： ::

   >>> tel = {'jack': 4098, 'sape': 4139}
   >>> tel['guido'] = 4127
   >>> tel
   {'sape': 4139, 'guido': 4127, 'jack': 4098}
   >>> tel['jack']
   4098
   >>> del tel['sape']
   >>> tel['irv'] = 4127
   >>> tel
   {'guido': 4127, 'irv': 4127, 'jack': 4098}
   >>> tel.keys()
   ['guido', 'irv', 'jack']
   >>> 'guido' in tel
   True

The :func:`dict` constructor builds dictionaries directly from lists of
key-value pairs stored as tuples.  When the pairs form a pattern, list
comprehensions can compactly specify the key-value list. ::

构造函数 :func:`dict` 直接从键值对元组列表中构建字典。如果有固定的模式，列表推导式
指定特定的键值对：

   >>> dict([('sape', 4139), ('guido', 4127), ('jack', 4098)])
   {'sape': 4139, 'jack': 4098, 'guido': 4127}
   >>> dict([(x, x**2) for x in (2, 4, 6)])     # use a list comprehension
   {2: 4, 4: 16, 6: 36}

Later in the tutorial, we will learn about Generator Expressions which are even
better suited for the task of supplying key-values pairs to the :func:`dict`
constructor.

在本指南的后面章节，我们会学习到生成器表达式，它更适于为 :func:`dict` 构造器生成键值对序列。

When the keys are simple strings, it is sometimes easier to specify pairs using
keyword arguments::

如果关键字只是简单的字符串，使用关键字参数指定键值对有时候更方便：

   >>> dict(sape=4139, guido=4127, jack=4098)
   {'sape': 4139, 'jack': 4098, 'guido': 4127}


.. _tut-loopidioms:

Looping Techniques 遍历技巧
===========================

When looping through dictionaries, the key and corresponding value can be
retrieved at the same time using the :meth:`iteritems` method. ::

在字典中遍历时，关键字和对应的值可以使用 :meth:`items` 方法同时解读出来：

   >>> knights = {'gallahad': 'the pure', 'robin': 'the brave'}
   >>> for k, v in knights.iteritems():
   ...     print k, v
   ...
   gallahad the pure
   robin the brave

When looping through a sequence, the position index and corresponding value can
be retrieved at the same time using the :func:`enumerate` function. ::

在序列中遍历时，索引位置和对应值可以使用 :func:`enumerate` 函数同时得到：

   >>> for i, v in enumerate(['tic', 'tac', 'toe']):
   ...     print i, v
   ...
   0 tic
   1 tac
   2 toe

To loop over two or more sequences at the same time, the entries can be paired
with the :func:`zip` function. ::

同时遍历两个或更多的序列，可以使用 :func:`zip` 组合：

   >>> questions = ['name', 'quest', 'favorite color']
   >>> answers = ['lancelot', 'the holy grail', 'blue']
   >>> for q, a in zip(questions, answers):
   ...     print 'What is your {0}?  It is {1}.'.format(q, a)
   ...	
   What is your name?  It is lancelot.
   What is your quest?  It is the holy grail.
   What is your favorite color?  It is blue.

To loop over a sequence in reverse, first specify the sequence in a forward
direction and then call the :func:`reversed` function. ::

要反向遍历一个序列，首先指定这个序列，然后调用 :func:`reversesd` 函数：

   >>> for i in reversed(xrange(1,10,2)):
   ...     print i
   ...
   9
   7
   5
   3
   1

To loop over a sequence in sorted order, use the :func:`sorted` function which
returns a new sorted list while leaving the source unaltered. ::

要按顺序遍历，使用 :func:`sorted` 函数。它返回一个己排序的新序列，原序列不变。 ::

   >>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
   >>> for f in sorted(set(basket)):
   ...     print f
   ... 	
   apple
   banana
   orange
   pear


.. _tut-conditions:

More on Conditions 深入条件控制
=============================

The conditions used in ``while`` and ``if`` statements can contain any
operators, not just comparisons.

用于 while 和 if 语句的条件包括了比较之外的操作符。

The comparison operators ``in`` and ``not in`` check whether a value occurs
(does not occur) in a sequence.  The operators ``is`` and ``is not`` compare
whether two objects are really the same object; this only matters for mutable
objects like lists.  All comparison operators have the same priority, which is
lower than that of all numerical operators.

比较操作符 ``in`` 和 ``not in`` 审核值是否在一个区间之内。操作符 ``is`` 和 ``is not`` 
和比较两个对象是否相同；这只和诸如链表这样的可变对象有关。所有的比较操作符具有相同的优先级，低于
所有的数值操作。

Comparisons can be chained.  For example, ``a < b == c`` tests whether ``a`` is
less than ``b`` and moreover ``b`` equals ``c``.

比较操作符可以串联。例如： ``a < b == c`` 测试是否 ``a`` 小于 ``b`` 并且 ``b`` 等于 ``c``。

Comparisons may be combined using the Boolean operators ``and`` and ``or``, and
the outcome of a comparison (or of any other Boolean expression) may be negated
with ``not``.  These have lower priorities than comparison operators; between
them, ``not`` has the highest priority and ``or`` the lowest, so that ``A and
not B or C`` is equivalent to ``(A and (not B)) or C``. As always, parentheses
can be used to express the desired composition.

比较操作（或其它任何逻辑表达式）可以通过逻辑操作符 ``and`` 和 ``or`` 组合，比较的结果可以用 
``not`` 来取反义。这些操作符的优先级又低于比较操作符，在它们之中，``not`` 具有最高的优先级， 
``or`` 优先级最低，所以 ``A and not B or C`` 等于 ``(A and (not B)) or C`` 。当然，
表达式可以用期望的方式表示。

The Boolean operators ``and`` and ``or`` are so-called *short-circuit*
operators: their arguments are evaluated from left to right, and evaluation
stops as soon as the outcome is determined.  For example, if ``A`` and ``C`` are
true but ``B`` is false, ``A and B and C`` does not evaluate the expression
``C``.  When used as a general value and not as a Boolean, the return value of a
short-circuit operator is the last evaluated argument.

逻辑操作符 ``and`` 和 ``or`` 也称作*短路操作符*：它们的参数从左向右解析，一旦结果可以确定就
停止。例如，如果 ``A`` 和 ``C`` 为真而 ``B`` 为假， ``A and B and C`` 不会解析 ``C``。
作用于一个普通的非逻辑值时，短路操作符的返回值通常是最后一个变量。

It is possible to assign the result of a comparison or other Boolean expression
to a variable.  For example, ::

可以把比较或其它逻辑表达式的返回值赋给一个变量，例如：

   >>> string1, string2, string3 = '', 'Trondheim', 'Hammer Dance'
   >>> non_null = string1 or string2 or string3
   >>> non_null
   'Trondheim'

Note that in Python, unlike C, assignment cannot occur inside expressions. C
programmers may grumble about this, but it avoids a common class of problems
encountered in C programs: typing ``=`` in an expression when ``==`` was
intended.

需要注意的是 Python 与 C 不同，在表达式内部不能赋值。 C 程序员经常对此抱怨，不过它避免
了一类在 C 程序中司空见惯的错误：想要在解析式中使 ``==`` 时误用了 ``=`` 操作符。

.. _tut-comparing:

Comparing Sequences and Other Types 比较序列和其它类型
===================================================

Sequence objects may be compared to other objects with the same sequence type.
The comparison uses *lexicographical* ordering: first the first two items are
compared, and if they differ this determines the outcome of the comparison; if
they are equal, the next two items are compared, and so on, until either
sequence is exhausted. If two items to be compared are themselves sequences of
the same type, the lexicographical comparison is carried out recursively.  If
all items of two sequences compare equal, the sequences are considered equal.
If one sequence is an initial sub-sequence of the other, the shorter sequence is
the smaller (lesser) one.  Lexicographical ordering for strings uses the ASCII
ordering for individual characters.  Some examples of comparisons between
sequences of the same type::

序列对象可以与相同类型的其它对象比较。比较操作按*字典*序进行：首先比较前两个元素，如果不同，
就决定了比较的结果；如果相同，就比较后两个元素，依此类推，直到所有序列都完成比较。如果两个
元素本身就是同样类型的序列，就递归字典序比较。如果两个序列的所有子项都相等，就认为序列相等。
如果一个序列是另一个序列的初始子序列，较短的一个序列就小于另一个。字符串的字典序按照单字符的 
ASCII 顺序。下面是同类型序列之间比较的一些例子： ::

   (1, 2, 3)              < (1, 2, 4)
   [1, 2, 3]              < [1, 2, 4]
   'ABC' < 'C' < 'Pascal' < 'Python'
   (1, 2, 3, 4)           < (1, 2, 4)
   (1, 2)                 < (1, 2, -1)
   (1, 2, 3)             == (1.0, 2.0, 3.0)
   (1, 2, ('aa', 'ab'))   < (1, 2, ('abc', 'a'), 4)

Note that comparing objects of different types is legal.  The outcome is
deterministic but arbitrary: the types are ordered by their name. Thus, a list
is always smaller than a string, a string is always smaller than a tuple, etc.
[#]_ Mixed numeric types are compared according to their numeric value, so 0
equals 0.0, etc.

需要注意的是用 ``<`` 或 ``>`` 比较不同类型的对象是合法的。参与比较的对象要提供适当的
比较方法。例如，不同数值类型比较时会统一它们的值大小，所以0等于0.0，等等。另一方面，如
果没有确定的排序方法，解释器会抛出 :exc:`TypeError` 异常。

.. rubric:: Footnotes

.. [#] The rules for comparing objects of different types should not be relied upon;
   they may change in a future version of the language.

   比较不同类型的对象没有可靠的规则，未来版本可能会发生变化。