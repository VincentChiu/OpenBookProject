.. _tut-morecontrol:

*************************************
More Control Flow Tools 深入流程控制
*************************************

Besides the :keyword:`while` statement just introduced, Python knows the usual
control flow statements known from other languages, with some twists.

除了前面介绍的 :keyword:`while` 关键字，Python 也像其它语言一样提供了常用的流程控制语句，并
加以一些改变。

.. _tut-if:

:keyword:`if` Statements :keyword:`if` 语法
===========================================

Perhaps the most well-known statement type is the :keyword:`if` statement.  For
example::

可能最有名的语句是 :keyword:`if`。例如： ::

   >>> x = int(raw_input("Please enter an integer: "))
   Please enter an integer: 42
   >>> if x < 0:
   ...      x = 0
   ...      print 'Negative changed to zero'
   ... elif x == 0:
   ...      print 'Zero'
   ... elif x == 1:
   ...      print 'Single'
   ... else:
   ...      print 'More'
   ...
   More

There can be zero or more :keyword:`elif` parts, and the :keyword:`else` part is
optional.  The keyword ':keyword:`elif`' is short for 'else if', and is useful
to avoid excessive indentation.  An  :keyword:`if` ... :keyword:`elif` ...
:keyword:`elif` ... sequence is a substitute for the ``switch`` or
``case`` statements found in other languages.

这里可以有零到多个 :keyword:`elif` 分支和 :keyword:`else` 分支可选。关键
字 :keyword:`elif` 是 `else if` 的简写，它可以有效避免过度缩进。 
:keyword:`if` ... :keyword:`elif` ... :keyword:`elif` ... 序列是其
它语言中的 :keyword:`switch 或 :keyword:case 语法的替代品。

.. _tut-for:

:keyword:`for` Statements :keyword:`for` 语法
==============================================

.. index::
   statement: for
   statement: for

The :keyword:`for` statement in Python differs a bit from what you may be used
to in C or Pascal.  Rather than always iterating over an arithmetic progression
of numbers (like in Pascal), or giving the user the ability to define both the
iteration step and halting condition (as C), Python's :keyword:`for` statement
iterates over the items of any sequence (a list or a string), in the order that
they appear in the sequence.  For example (no pun intended):

可能你用过 C 或 Pascal， Python 中的 :keyword:`for` 语法与之稍有不同。通常的循环可能会
依据一个等差数值步进过程（如Pascal）或由用户来定义迭代步骤和中止条件（如 C ），Python 的 
for 语句依据任意序列（链表或字符串）中的子项，按它们在序列中的顺序来进行迭代。例如（没有暗指）：

.. One suggestion was to give a real C example here, but that may only serve to
   confuse non-C programmers.
   有人建议在这里给一个真实的 C 示例，不过这样恐怕迷惑非 C 程序员。

::

   >>> # Measure some strings:
   ... a = ['cat', 'window', 'defenestrate']
   >>> for x in a:
   ...     print x, len(x)
   ... 
   cat 3
   window 6
   defenestrate 12

It is not safe to modify the sequence being iterated over in the loop (this can
only happen for mutable sequence types, such as lists).  If you need to modify
the list you are iterating over (for example, to duplicate selected items) you
must iterate over a copy.  The slice notation makes this particularly
convenient::

在循环中修改序列被迭代的部分不安全。如果你需要修改被迭代的序列（例如复制选择项），应该迭代它的复本。
通常使用切割就可以方便的做到：

   >>> for x in a[:]: # make a slice copy of the entire list
   ...    if len(x) > 6: a.insert(0, x)
   ... 
   >>> a
   ['defenestrate', 'cat', 'window', 'defenestrate']

.. _tut-range:

The :func:`range` Function :func:`range` 函数
=============================================

If you do need to iterate over a sequence of numbers, the built-in function
:func:`range` comes in handy.  It generates lists containing arithmetic
progressions::

如果你需要一个数值序列，内置函数 :func:`range` 函数可能很有用，它生成一个等差级数序列：

   >>> range(10)
   [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

The given end point is never part of the generated list; ``range(10)`` generates
a list of 10 values, the legal indices for items of a sequence of length 10.  It
is possible to let the range start at another number, or to specify a different
increment (even negative; sometimes this is called the 'step')::

给定的终点不在生成的列表中；``range(10)`` 生成了 10 个值，准确的用索引值填充了这个长度为 10 
的列表。也可以让 range 操作从另一个数值开始，或者可以指定一个不同的步进值（甚至是负数，有时也称
之为`步长`）：

   >>> range(5, 10)
   [5, 6, 7, 8, 9]
   >>> range(0, 10, 3)
   [0, 3, 6, 9]
   >>> range(-10, -100, -30)
   [-10, -40, -70]

To iterate over the indices of a sequence, combine :func:`range` and :func:`len`
as follows::

要迭代列表索引的话，如下所示结合使用 :func:`range` 和 :func:`len`：

   >>> a = ['Mary', 'had', 'a', 'little', 'lamb']
   >>> for i in range(len(a)):
   ...     print i, a[i]
   ... 
   0 Mary
   1 had
   2 a
   3 little
   4 lamb


.. _tut-break:

:keyword:`break` and :keyword:`continue` Statements, and :keyword:`else` Clauses on Loops :keyword:`break` 和 :keyword:`continue` 语句，以及循环中的 :keyword:`else` 块
====================================================================================================================================================================

The :keyword:`break` statement, like in C, breaks out of the smallest enclosing
:keyword:`for` or :keyword:`while` loop.

语句 ::keyword:`break` 类似C语言，用于跳出最近的 :keyword:`for` 或 :keyword:`while` 循环。

The :keyword:`continue` statement, also borrowed from C, continues with the next
iteration of the loop.

语句 :keyword:``continue 也来自于 C ，跳转到循环的下一个迭代过程。

Loop statements may have an ``else`` clause; it is executed when the loop
terminates through exhaustion of the list (with :keyword:`for`) or when the
condition becomes false (with :keyword:`while`), but not when the loop is
terminated by a :keyword:`break` statement.  This is exemplified by the
following loop, which searches for prime numbers::

循环语句可以有一个 ``else`` 分支；当（ :keyword:`for` ）循环穷尽它循环的列表或
者（ `:keyword:`while ）循环条件变为 False ，而非通过 :keyword:break 语句中
止时，它会执行。以下这个搜索素数的循环是一个简单的示例：

   >>> for n in range(2, 10):
   ...     for x in range(2, n):
   ...         if n % x == 0:
   ...             print n, 'equals', x, '*', n/x
   ...             break
   ...     else:
   ...         # loop fell through without finding a factor
   ...         print n, 'is a prime number'
   ... 
   2 is a prime number
   3 is a prime number
   4 equals 2 * 2
   5 is a prime number
   6 equals 2 * 3
   7 is a prime number
   8 equals 2 * 4
   9 equals 3 * 3


.. _tut-pass:

:keyword:`pass` Statements :keyword:`pass` 语句
================================================

The :keyword:`pass` statement does nothing. It can be used when a statement is
required syntactically but the program requires no action. For example::

语句 :keyword:`pass` 什么也不做。它用于在语法上必须要有占位，但程序不做任何事的场合。例如：

   >>> while True:
   ...     pass  # Busy-wait for keyboard interrupt (Ctrl+C)
   ... 


.. _tut-functions:

Defining Functions 定义函数
============================

We can create a function that writes the Fibonacci series to an arbitrary
boundary::

我们可以创建一个函数，用于生成指定边界的菲波那契数列：

   >>> def fib(n):    # write Fibonacci series up to n
   ...     """Print a Fibonacci series up to n."""
   ...     a, b = 0, 1
   ...     while b < n:
   ...         print b,
   ...         a, b = b, a+b
   ... 
   >>> # Now call the function we just defined:
   ... fib(2000)
   1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597

.. index::
   single: documentation strings
   single: docstrings
   single: strings, documentation

The keyword :keyword:`def` introduces a function *definition*.  It must be
followed by the function name and the parenthesized list of formal parameters.
The statements that form the body of the function start at the next line, and
must be indented.

关键字 :keyword:`def` 指明函数 *定义* 。其后必须带有函数名和以括号标明的参数列表。函数体的
语句从下一行开始，一定要缩进。

The first statement of the function body can optionally be a string literal;
this string literal is the function's documentation string, or :dfn:`docstring`.
(More about docstrings can be found in the section :ref:`tut-docstrings`.)
There are tools which use docstrings to automatically produce online or printed
documentation, or to let the user interactively browse through code; it's good
practice to include docstrings in code that you write, so make a habit of it.

函数体的第一行可以是一个字符串文本，这个字符串文本是函数的文档字符串，或称 :dfn:`docstring`。
（更多关于 docstring 的内容可以在 :ref:`tut-docstrings` 一章找到。）有一些工具可以将
docstring 转为在线或可打印的文档，或者供用户在代码中交互阅读；在你的代码中加入文档字符串是
件好事，应该使之成为习惯。

The *execution* of a function introduces a new symbol table used for the local
variables of the function.  More precisely, all variable assignments in a
function store the value in the local symbol table; whereas variable references
first look in the local symbol table, then in the local symbol tables of
enclosing functions, then in the global symbol table, and finally in the table
of built-in names. Thus, global variables cannot be directly assigned a value
within a function (unless named in a :keyword:`global` statement), although they
may be referenced.

*调用* 函数会使函数为局部变量生成一个新的符号表。更准确的说，函数中所有的赋值都存储在局部符号表；
而变量引用首先查找局部符号表，然后是全局符号表，然后是内置命名表。因此，全局变量不会在函数内被直
接赋值（除非是 :keyword:`global` 语句中的命名），尽管它们可以被引用。

The actual parameters (arguments) to a function call are introduced in the local
symbol table of the called function when it is called; thus, arguments are
passed using *call by value* (where the *value* is always an object *reference*,
not the value of the object). [#]_ When a function calls another function, a new
local symbol table is created for that call.

函数的实际参数在函数被调用时引入局部符号表；因此，参数使用 *传值* 方式传递（这里的 *值* 一般是对
象*引用* 而不是对象的值）。[#]_  当函数调用其它函数，会为其建立新的局部符号表。

A function definition introduces the function name in the current symbol table.
The value of the function name has a type that is recognized by the interpreter
as a user-defined function.  This value can be assigned to another name which
can then also be used as a function.  This serves as a general renaming
mechanism::

函数定义为当前的符号表引入了函数名。函数名对应的值被解释器认定为自定义函数类型。这个值可以被赋予
其它名字，使其作为函数使用。这是一种通用的重命名机制：

   >>> fib
   <function fib at 10042ed0>
   >>> f = fib
   >>> f(100)
   1 1 2 3 5 8 13 21 34 55 89

Coming from other languages, you might object that ``fib`` is not a function but
a procedure since it doesn't return a value.  In fact, even functions without a
:keyword:`return` statement do return a value, albeit a rather boring one.  This
value is called ``None`` (it's a built-in name).  Writing the value ``None`` is
normally suppressed by the interpreter if it would be the only value written.
You can see it if you really want to using :keyword:`print`::

你也许会抗议： ``fib`` 不是函数，而是方法。在 Python 中，就像 C 一样，方法只是没有返回值的
函数。实际上，从技术角度讲，方法返回一个值，尽管是一个很无聊的值。这个值被称为 ``None`` （这
是一个内置命名）。定义 ``None`` 这个值只是在没得选择的时候用于哄骗一下解释器（译注：好吧，这里
我恶搞了一下:P）。如果你明确使用 :keyword:`print`就可以看到它： ::

   >>> fib(0)
   >>> print fib(0)
   None

It is simple to write a function that returns a list of the numbers of the
Fibonacci series, instead of printing it::

写一个函数返回菲波那契数列的一部分列表，而不是打印它，非常简单：

   >>> def fib2(n): # return Fibonacci series up to n
   ...     """Return a list containing the Fibonacci series up to n."""
   ...     result = []
   ...     a, b = 0, 1
   ...     while b < n:
   ...         result.append(b)    # see below
   ...         a, b = b, a+b
   ...     return result
   ... 
   >>> f100 = fib2(100)    # call it
   >>> f100                # write the result
   [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

This example, as usual, demonstrates some new Python features:

像往常一样，这里新介绍了一些 Python 的功能:

* The :keyword:`return` statement returns with a value from a function.
  :keyword:`return` without an expression argument returns ``None``. Falling off
  the end of a function also returns ``None``.

  指令 `return` 从函数中返回一个值。没有表达式参数的 :keyword:`return` 返回 ``None``。方
  法执行完毕后也从末尾返回 ``None``。

* The statement ``result.append(b)`` calls a *method* of the list object
  ``result``.  A method is a function that 'belongs' to an object and is named
  ``obj.methodname``, where ``obj`` is some object (this may be an expression),
  and ``methodname`` is the name of a method that is defined by the object's type.
  Different types define different methods.  Methods of different types may have
  the same name without causing ambiguity.  (It is possible to define your own
  object types and methods, using *classes*, as discussed later in this tutorial.)
  The method :meth:`append` shown in the example is defined for list objects; it
  adds a new element at the end of the list.  In this example it is equivalent to
  ``result = result + [b]``, but more efficient.

  指令 ``result.append(b)`` 称为列表对象 ``result`` 的一个*方法*。方法是'从属'于对象
  的，名为``obj.methodname``的函数，这里``obj``指某对象（可能是个表达式），``methodname``
  是由对象类型定义的方法的名字。不同的类型定义了不同的方法。不同类型可能有同名的方法，但不会混淆。
  （你可以使用本书后面内容介绍的 *class* 定义的类型。） 本例中的 :meth:`append` 是 list 
  对象定义的，它将一个新的元素加入到列表最后。本例中它相当于 `` result = result + [b] ``，
  但更高效。



.. _tut-defining:

More on Defining Functions 深入函数定义 
=====================================

It is also possible to define functions with a variable number of arguments.
There are three forms, which can be combined.

函数也可以定义可变数目的参数，有三种不同的形式，可以组合使用。

.. _tut-defaultargs:

Default Argument Values 默认参数值
---------------------------------

The most useful form is to specify a default value for one or more arguments.
This creates a function that can be called with fewer arguments than it is
defined to allow.  For example::

最有用的形式是为一个或多个参数指定默认值.这样可以创建一个函数,使其能够使用比定义时少的参数调用,例如:

   def ask_ok(prompt, retries=4, complaint='Yes or no, please!'):
       while True:
           ok = raw_input(prompt)
           if ok in ('y', 'ye', 'yes'): return True
           if ok in ('n', 'no', 'nop', 'nope'): return False
           retries = retries - 1
           if retries < 0: raise IOError, 'refusenik user'
           print complaint

This function can be called either like this: ``ask_ok('Do you really want to
quit?')`` or like this: ``ask_ok('OK to overwrite the file?', 2)``.

这个函数既可以这样调用：``ask_ok('Do you really want to quit?')`` ，也可以像这样调
用：``ask_ok('OK to overwite the file?', 2)。

This example also introduces the :keyword:`in` keyword. This tests whether or
not a sequence contains a certain value.

这个例子也介绍了 :keyword:`in` 关键字。它检测序列中是否包含某个确定的值。

The default values are evaluated at the point of function definition in the
*defining* scope, so that ::

默认值等于在函数定义域中被定义时的值，例如：

   i = 5

   def f(arg=i):
       print arg

   i = 6
   f()

will print ``5``.

会打印 ``5``。

**Important warning:**  The default value is evaluated only once. This makes a
difference when the default is a mutable object such as a list, dictionary, or
instances of most classes.  For example, the following function accumulates the
arguments passed to it on subsequent calls::

**重要警告：** 默认值只绑定一次。这使得默认值是列表、字典或大部分类的实例时会有所变化。例如，下面这个函
数在调用过程中积累了多个值：

   def f(a, L=[]):
       L.append(a)
       return L

   print f(1)
   print f(2)
   print f(3)

This will print ::

会打印出： ::

   [1]
   [1, 2]
   [1, 2, 3]

If you don't want the default to be shared between subsequent calls, you can
write the function like this instead::

如果你不想在后继的调用间共享默认值，可以像下面这样编写函数： ::
x
   def f(a, L=None):
       if L is None:
           L = []
       L.append(a)
       return L


.. _tut-keywordargs:

Keyword Arguments 关键字参数
----------------------------

Functions can also be called using keyword arguments of the form ``keyword =
value``.  For instance, the following function::

函数可以通过形如 ``keyword = value`` 的关键字参数调用。例如，以下函数： ::

   def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
       print "-- This parrot wouldn't", action,
       print "if you put", voltage, "volts through it."
       print "-- Lovely plumage, the", type
       print "-- It's", state, "!"

could be called in any of the following ways::

可以通过以下的形式调用：

   parrot(1000)
   parrot(action = 'VOOOOOM', voltage = 1000000)
   parrot('a thousand', state = 'pushing up the daisies')
   parrot('a million', 'bereft of life', 'jump')

but the following calls would all be invalid::

但是以下调用无效：

   parrot()                     # required argument missing 必要的参数缺失
   parrot(voltage=5.0, 'dead')  # non-keyword argument following keyword 非关键字参数跟在关键字参数之后
   parrot(110, voltage=220)     # duplicate value for argument 参数重复赋值
   parrot(actor='John Cleese')  # unknown keyword 未知关键字

In general, an argument list must have any positional arguments followed by any
keyword arguments, where the keywords must be chosen from the formal parameter
names.  It's not important whether a formal parameter has a default value or
not.  No argument may receive a value more than once --- formal parameter names
corresponding to positional arguments cannot be used as keywords in the same
calls. Here's an example that fails due to this restriction::

通常，参数列表中的每一个关键字都必须来自于形式参数，每个参数都有对应的关键字。形式参数有没有默认值并不重
要。实际参数不能一次赋多个值——形式参数不能在同一次调用中同时使用位置和关键字绑定值。这里有一个例子演示
了在这种约束下所出现的失败情况： ::

   >>> def function(a):
   ...     pass
   ... 
   >>> function(0, a=0)
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: function() got multiple values for keyword argument 'a'

When a final formal parameter of the form ``**name`` is present, it receives a
dictionary (see :ref:`typesmapping`) containing all keyword arguments except for
those corresponding to a formal parameter.  This may be combined with a formal
parameter of the form ``*name`` (described in the next subsection) which
receives a tuple containing the positional arguments beyond the formal parameter
list.  (``*name`` must occur before ``**name``.) For example, if we define a
function like this::

引入一个形如 ``**name`` 的参数时，它接收一个字典（参见 :ref:`typemappint`） ，该字典包含了所有未出现在形式参数列表中的关键字参数。这里可能还会组合使用一个形如 ``*name`` （下一节中会详细介绍）的形式参数，它接收一个元组，包含了所有没有出现在形式参数列表中的参数值。（ ``*name`` 必须在 ``**name`` 之前出现） 例如，我们这样定义一个函数： ::

   def cheeseshop(kind, *arguments, **keywords):
       print "-- Do you have any", kind, "?"
       print "-- I'm sorry, we're all out of", kind
       for arg in arguments: print arg
       print "-" * 40
       keys = keywords.keys()
       keys.sort()
       for kw in keys: print kw, ":", keywords[kw]

It could be called like this::

可以这样调用： ::

   cheeseshop("Limburger", "It's very runny, sir.",
              "It's really very, VERY runny, sir.",
              shopkeeper='Michael Palin',
              client="John Cleese",
              sketch="Cheese Shop Sketch")

and of course it would print::

当然它会打印如内容： ::

   -- Do you have any Limburger ?
   -- I'm sorry, we're all out of Limburger
   It's very runny, sir.
   It's really very, VERY runny, sir.
   ----------------------------------------
   client : John Cleese
   shopkeeper : Michael Palin
   sketch : Cheese Shop Sketch

Note that the :meth:`sort` method of the list of keyword argument names is
called before printing the contents of the ``keywords`` dictionary; if this is
not done, the order in which the arguments are printed is undefined.

应注意在打印 ``keywords`` 字典之前调用 :meth:sort 方法，否则打印参数时的顺序未定义。

.. _tut-arbitraryargs:

Arbitrary Argument Lists 可变参数列
---------------------------------

.. index::
  statement: *  

Finally, the least frequently used option is to specify that a function can be
called with an arbitrary number of arguments.  These arguments will be wrapped
up in a tuple (see :ref:`tut-tuples`).  Before the variable number of arguments,
zero or more normal arguments may occur. ::

最后，一个最不常用的选择让函数可以调用可变个数的参数。这些参数被包装进一个元组（参见 :ref:`tut-tuples`
）。在这些可变个数的参数之前，可以有零到多个普通的参数：

   def write_multiple_items(file, separator, *args):
       file.write(separator.join(args))


.. _tut-unpacking-arguments:

Unpacking Argument Lists 参数列表的分拆
------------------------------------

The reverse situation occurs when the arguments are already in a list or tuple
but need to be unpacked for a function call requiring separate positional
arguments.  For instance, the built-in :func:`range` function expects separate
*start* and *stop* arguments.  If they are not available separately, write the
function call with the  ``*``\ -operator to unpack the arguments out of a list
or tuple::

另有一种相反的情况: 当你要传递的参数已经是一个列表但要调用的函数却接受分开一个个的参数值. 这时候你要
把已有的列表拆开来. 例如内建函数 range() 需要要独立的 start, stop 参数. 你可以在调用函数时加
一个 ``*``\ 操作符来自动把参数列表拆开： ::

   >>> range(3, 6)             # normal call with separate arguments
   [3, 4, 5]
   >>> args = [3, 6]
   >>> range(*args)            # call with arguments unpacked from a list
   [3, 4, 5]

.. index::
  statement: **

In the same fashion, dictionaries can deliver keyword arguments with the ``**``\
-operator::

以同样的方式，``**``\ 操作符可以把字典传递给关键字参数：

   >>> def parrot(voltage, state='a stiff', action='voom'):
   ...     print "-- This parrot wouldn't", action,
   ...     print "if you put", voltage, "volts through it.",
   ...     print "E's", state, "!"
   ...
   >>> d = {"voltage": "four million", "state": "bleedin' demised", "action": "VOOM"}
   >>> parrot(**d)
   -- This parrot wouldn't VOOM if you put four million volts through it. E's bleedin' demised !


.. _tut-lambda:

Lambda Forms Lambda 形式
-------------------------

By popular demand, a few features commonly found in functional programming
languages like Lisp have been added to Python.  With the :keyword:`lambda`
keyword, small anonymous functions can be created. Here's a function that
returns the sum of its two arguments: ``lambda a, b: a+b``.  Lambda forms can be
used wherever function objects are required.  They are syntactically restricted
to a single expression.  Semantically, they are just syntactic sugar for a
normal function definition.  Like nested function definitions, lambda forms can
reference variables from the containing scope::

出于实际需要，有几种通常在函数式语言如 Lisp 中出现的功能加入到了 Python 。通过 
:keyword:`lambda` 关键字，可以创建短小的匿名函数。这里有一个函数返回它的两个参
数的和：``lambda a, b: a+b``。 Lambda 形式可以用于任何需要的函数对象。出于
语法限制，它们只能有一个单独的表达式。语义上讲，它们只是普通函数定义中的一个语法技巧。
类似于嵌套函数定义，lambda 形式可以从包含范围内引用变量： ::

   >>> def make_incrementor(n):
   ...     return lambda x: x + n
   ...
   >>> f = make_incrementor(42)
   >>> f(0)
   42
   >>> f(1)
   43


.. _tut-docstrings:

Documentation Strings 文档字符串
------------------------------

.. index::
   single: docstrings
   single: documentation strings
   single: strings, documentation

There are emerging conventions about the content and formatting of documentation
strings.

这里介绍一些文档字符串内容和格式的概念。

The first line should always be a short, concise summary of the object's
purpose.  For brevity, it should not explicitly state the object's name or type,
since these are available by other means (except if the name happens to be a
verb describing a function's operation).  This line should begin with a capital
letter and end with a period.

第一行应该是关于对象用途的简介。简短起见，不用明确的陈述对象名或类型，因为它们可以从别的途径
了解到（除非这个名字碰巧就是描述这个函数操作的动词）。这一行应该以大写字母开头，以句号结尾。

If there are more lines in the documentation string, the second line should be
blank, visually separating the summary from the rest of the description.  The
following lines should be one or more paragraphs describing the object's calling
conventions, its side effects, etc.

如果文档字符串有多行，第二行应该空出来，与接下来的详细描述明确分隔。接下来的文档应该有一或多
段描述对象的调用约定、边界效应等。

The Python parser does not strip indentation from multi-line string literals in
Python, so tools that process documentation have to strip indentation if
desired.  This is done using the following convention. The first non-blank line
*after* the first line of the string determines the amount of indentation for
the entire documentation string.  (We can't use the first line since it is
generally adjacent to the string's opening quotes so its indentation is not
apparent in the string literal.)  Whitespace "equivalent" to this indentation is
then stripped from the start of all lines of the string.  Lines that are
indented less should not occur, but if they occur all their leading whitespace
should be stripped.  Equivalence of whitespace should be tested after expansion
of tabs (to 8 spaces, normally).

Python的解释器不会从多行的文档字符串中去除缩进，所以必要的时候应当自己清除缩进。这符合通常的习惯。
第一行*之后*的第一个非空行决定了整个文档的缩进格式。（我们不用第一行是因为它通常紧靠着起始的引号，
缩进格式显示的不清楚。）留白“相当于”是字符串的起始缩进。每一行都不应该有缩进，如果有缩进的话，所
有的留白都应该清除掉。留白的长度应当等于扩展制表符的宽度（通常是8个空格）。

Here is an example of a multi-line docstring::

   >>> def my_function():
   ...     """Do nothing, but document it.
   ... 
   ...     No, really, it doesn't do anything.
   ...     """
   ...     pass
   ... 
   >>> print my_function.__doc__
   Do nothing, but document it.

       No, really, it doesn't do anything.


.. _tut-codingstyle:

Intermezzo: Coding Style 编码风格
================================

.. sectionauthor:: Georg Brandl <georg@python.org>
.. index:: pair: coding; style

Now that you are about to write longer, more complex pieces of Python, it is a
good time to talk about *coding style*.  Most languages can be written (or more
concise, *formatted*) in different styles; some are more readable than others.
Making it easy for others to read your code is always a good idea, and adopting
a nice coding style helps tremendously for that.

现在你可以写更长更复杂的 Python 程序，是时候讨论一下*代码风格*了。大多数语言可以
写（或者简单的说，*格式化*）成不同的风格，有些会比其它的更好读一些。让别人读自己
的代码时更方便是个好想法，良好的编码风格对此非常有帮助。

For Python, :pep:`8` has emerged as the style guide that most projects adhere to;
it promotes a very readable and eye-pleasing coding style.  Every Python
developer should read it at some point; here are the most important points
extracted for you:

对于Python， :pep:`8` 作为风格指南出现在很多项目中，它主张一种高度可读的，视觉友
好的编码风格。每个 Python 开发者都应该阅读它，这里面提炼了最重要的观点。

* Use 4-space indentation, and no tabs.
  
  使用 4 空格缩进，而不是tab。

  4 spaces are a good compromise between small indentation (allows greater
  nesting depth) and large indentation (easier to read).  Tabs introduce
  confusion, and are best left out.

  4 空格是小缩进（允许更大的嵌入深度）和大缩进（更容易阅读）之间的良好折中。Tab
  带来了混乱，最好不要用它。

* Wrap lines so that they don't exceed 79 characters.

  折行，保持它不要超过 79 字符。

  This helps users with small displays and makes it possible to have several
  code files side-by-side on larger displays.

  这有助于使用小显示的用户，也可以方便在大显示器上并排放几个文件。

* Use blank lines to separate functions and classes, and larger blocks of
  code inside functions.

  使用空行分隔类和函数，以及函数内部的大块代码。

* When possible, put comments on a line of their own.

  可能的话，把注释写在单独的一行上。

* Use docstrings.

  使用文档字符串。

* Use spaces around operators and after commas, but not directly inside
  bracketing constructs: ``a = f(1, 2) + g(3, 4)``.

  在操作符两边和逗号之后加空格，但是不要直接在括号中插空格： ``a = f(1, 2) +
  g(3, 4)`` 。

* Name your classes and functions consistently; the convention is to use
  ``CamelCase`` for classes and ``lower_case_with_underscores`` for functions
  and methods.  Always use ``self`` as the name for the first method argument
  (see :ref:`tut-firstclasses` for more on classes and methods).

  类和函数命名要统一。类名使用 ``CamelCase`` 形式，函数名和方法名使用
  ``lower_case_with_underscores`` 形式。坚持用 ``self`` 作为方法的第一个参数名
  （关于类和方法的详细信息，参见 :ref:`tut-firstclasses` ）。

  译注：这里我个人更倾向类名用Pascal命名，方法名用驼峰命名，视你的团队习惯而定。

* Don't use fancy encodings if your code is meant to be used in international
  environments.  Plain ASCII works best in any case.
  
  如果需要在国际化环境中使用代码，不要用本地化的编码，纯ASCII在任何情况下都很好
  用。

  译注：实践证明，unicode才是真正的国际化通用编码。我们应该尽量使用utf-8。

.. rubric:: Footnotes

.. [#] Actually, *call by object reference* would be a better description,
   since if a mutable object is passed, the caller will see any changes the
   callee makes to it (items inserted into a list).

   实际上，*call by object reference* 是一个更好的说法，因为如果传入一个可变对
   像，调用者会看到调用造成的所有改变（比如在list中插入一项）。

