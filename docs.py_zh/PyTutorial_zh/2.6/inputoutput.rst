.. _tut-io:

***************************
Input and Output 输出和输出
***************************

There are several ways to present the output of a program; data can be printed
in a human-readable form, or written to a file for future use. This chapter will
discuss some of the possibilities.


.. _tut-formatting:

Fancier Output Formatting 设计输出格式 
====================================

So far we've encountered two ways of writing values: *expression statements* and
the :keyword:`print` statement.  (A third way is using the :meth:`write` method
of file objects; the standard output file can be referenced as ``sys.stdout``.
See the Library Reference for more information on this.)

我们有两种大相径庭的输出值方法：表达式语句和 print 语句。（第三种方式是
使用文件对象的 write() 方法，标准文件输出可以参考 ``sys.stdout``。详细
内容参见库参考手册。）

.. index:: module: string

Often you'll want more control over the formatting of your output than simply
printing space-separated values.  There are two ways to format your output; the
first way is to do all the string handling yourself; using string slicing and
concatenation operations you can create any layout you can imagine.  The
standard module :mod:`string` contains some useful operations for padding
strings to a given column width; these will be discussed shortly.  The second
way is to use the :meth:`str.format` method.

可能你经常想要对输出格式做一些比简单的打印空格分隔符更为复杂的控制。有
两种方法可以格式化输出。第一种是由你来控制整个字符串，使用字符串切割和联
接操作就可以创建出任何你想要的输出形式。标准模块 :mod:`string` 包括了一
些操作，将字符串填充入给定列时，这些操作很有用。随后我们会讨论这部分内
容。第二种方法是使用 :meth:`str.format` 方法。

One question remains, of course: how do you convert values to strings? Luckily,
Python has ways to convert any value to a string: pass it to the :func:`repr`
or :func:`str` functions.

当然，还有一个问题，如何将值转化为字符串？很幸运，Python总是把任意值传
入 :func:`repr` 或 :func:`str` 函数，转为字符串。

The :func:`str` function is meant to return representations of values which are
fairly human-readable, while :func:`repr` is meant to generate representations
which can be read by the interpreter (or will force a :exc:`SyntaxError` if
there is not equivalent syntax).  For objects which don't have a particular
representation for human consumption, :func:`str` will return the same value as
:func:`repr`.  Many values, such as numbers or structures like lists and
dictionaries, have the same representation using either function.  Strings and
floating point numbers, in particular, have two distinct representations.

函数 :func:`str` 用于将值转化为适于人阅读的形式，而 :func:`repr` 转化为供解释器读取的形式
（如果没有等价的语法，则会发生 :exc:`SyntaxError` 异常） 某对象没有适于人阅读的解释形式的话， 
:func:`str` 会返回与 :func:`repr` 等同的值。很多类型，诸如数值或链表、字典这样的结构，针对
各函数都有着统一的解读方式。字符串和浮点数，有不同的解读方式。

Some examples::

下面是一些示例： ::

   >>> s = 'Hello, world.'
   >>> str(s)
   'Hello, world.'
   >>> repr(s)
   "'Hello, world.'"
   >>> str(0.1)
   '0.1'
   >>> repr(0.1)
   '0.10000000000000001'
   >>> x = 10 * 3.25
   >>> y = 200 * 200
   >>> s = 'The value of x is ' + repr(x) + ', and y is ' + repr(y) + '...'
   >>> print s
   The value of x is 32.5, and y is 40000...
   >>> # The repr() of a string adds string quotes and backslashes:
   ... hello = 'hello, world\n'
   >>> hellos = repr(hello)
   >>> print hellos
   'hello, world\n'
   >>> # The argument to repr() may be any Python object:
   ... repr((x, y, ('spam', 'eggs')))
   "(32.5, 40000, ('spam', 'eggs'))"

Here are two ways to write a table of squares and cubes::

以下两种方式可以输出平方和立方表：

   >>> for x in range(1, 11):
   ...     print repr(x).rjust(2), repr(x*x).rjust(3),
   ...     # Note trailing comma on previous line
   ...     print repr(x*x*x).rjust(4)
   ...
    1   1    1
    2   4    8
    3   9   27
    4  16   64
    5  25  125
    6  36  216
    7  49  343
    8  64  512
    9  81  729
   10 100 1000

   >>> for x in range(1,11):
   ...     print '{0:2d} {1:3d} {2:4d}'.format(x, x*x, x*x*x)
   ... 
    1   1    1
    2   4    8
    3   9   27
    4  16   64
    5  25  125
    6  36  216
    7  49  343
    8  64  512
    9  81  729
   10 100 1000

(Note that in the first example, one space between each column was added by the
way :keyword:`print` works: it always adds spaces between its arguments.)

（需要注意的是使用 print 方法时每两列之间有一个空格：它总是在参数之间加一个空格。）

This example demonstrates the :meth:`rjust` method of string objects, which
right-justifies a string in a field of a given width by padding it with spaces
on the left.  There are similar methods :meth:`ljust` and :meth:`center`.  These
methods do not write anything, they just return a new string.  If the input
string is too long, they don't truncate it, but return it unchanged; this will
mess up your column lay-out but that's usually better than the alternative,
which would be lying about a value.  (If you really want truncation you can
always add a slice operation, as in ``x.ljust(n)[:n]``.)

以上是一个 :meth:`rjust` 函数的演示，这个函数把字符串输出到一列，并通过
向左侧填充空格来使其右对齐。类似的函数还有 :meth:`ljust` 和
:meth:`center`。这些函数只是输出新的字符串，并不改变什么。如果输出的字
符串太长，它们也不会截断它，而是原样输出，这会使你的输出格式变得混乱，
不过总强过另一种选择（截断字符串），因为那样会产生错误的输出值。（如果
你确实需要截断它，可以使用切割操作，例如：``x.ljust( n)[:n]``。）

There is another method, :meth:`zfill`, which pads a numeric string on the left
with zeros.  It understands about plus and minus signs::

另一个函数 :meth:`zfill` 用于向数值的字符串表达左侧填充零。该函数可以正确理解正负号：

   >>> '12'.zfill(5)
   '00012'
   >>> '-3.14'.zfill(7)
   '-003.14'
   >>> '3.14159265359'.zfill(5)
   '3.14159265359'

Basic usage of the :meth:`str.format` method looks like this::

:meth:`str.format` 方法的基本用法如下： ::

   >>> print 'We are the {0} who say "{1}!"'.format('knights', 'Ni')
   We are the knights who say "Ni!"

The brackets and characters within them (called format fields) are replaced with
the objects passed into the format method.  The number in the brackets refers to
the position of the object passed into the format method. ::

大括号和其中的字符（称作格式化字段）被替换为 format 方法传入的对象。大括号中的数
字引用的是 format 方法传入的对象的位置。 ::

   >>> print '{0} and {1}'.format('spam', 'eggs')
   spam and eggs
   >>> print '{1} and {0}'.format('spam', 'eggs')
   eggs and spam

If keyword arguments are used in the format method, their values are referred to
by using the name of the argument. ::

如果在 format 方法中使用关键字参数，它们的值通过命名来引用。 ::

   >>> print 'This {food} is {adjective}.'.format(
   ...       food='spam', adjective='absolutely horrible')
   This spam is absolutely horrible.

Positional and keyword arguments can be arbitrarily combined::

位置和关键字参数可以适当组合 ::

   >>> print 'The story of {0}, {1}, and {other}.'.format('Bill', 'Manfred',
   ...                                                    other='Georg')
   The story of Bill, Manfred, and Georg.

An optional ``':``` and format specifier can follow the field name. This also
greater control over how the value is formatted.  The following example
truncates the Pi to three places after the decimal.

一个可选的 ``':``` 和格式指示器可以跟在字段名之后。这是一个更强大的值格式化控制。
以下的例子将 Pi 转为小数点后三位的十进制数值。

   >>> import math
   >>> print 'The value of PI is approximately {0:.3f}.'.format(math.pi)
   The value of PI is approximately 3.142.

Passing an integer after the ``':'`` will cause that field to be a minimum
number of characters wide.  This is useful for making tables pretty.::

在  ``':``` 之后传递一个整数可以指定最小（译注，原文 minimum number，我觉得这里
应该是最大才对）宽度，这在美化打印时很有用。

   >>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 7678}
   >>> for name, phone in table.items():
   ...     print '{0:10} ==> {1:10d}'.format(name, phone)
   ... 
   Jack       ==>       4098
   Dcab       ==>       7678
   Sjoerd     ==>       4127

If you have a really long format string that you don't want to split up, it
would be nice if you could reference the variables to be formatted by name
instead of by position.  This can be done by simply passing the dict and using
square brackets ``'[]'`` to access the keys ::

如果你有一个实在太长的格式式字符串，又不想分割，一个很好的办法就是引用变量名而不
是位置。这样就可以简单的传入字典，还可以用中括号 ``'[]'`` 访问键 ::

   >>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
   >>> print ('Jack: {0[Jack]:d}; Sjoerd: {0[Sjoerd]:d}; '
   ...        'Dcab: {0[Dcab]:d}'.format(table))
   Jack: 4098; Sjoerd: 4127; Dcab: 8637678

This could also be done by passing the table as keyword arguments with the '**'
notation.::

也可以像下面这样将table作为关键字参数，以 '**' 标识传入。 ::

   >>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
   >>> print 'Jack: {Jack:d}; Sjoerd: {Sjoerd:d}; Dcab: {Dcab:d}'.format(**table)
   Jack: 4098; Sjoerd: 4127; Dcab: 8637678

This is particularly useful in combination with the new built-in :func:`vars`
function, which returns a dictionary containing all local variables.

新的内置函数 :func:`vars` 在这个时候特别有用，它返回所有局部变量组成的字典。

For a complete overview of string formating with :meth:`str.format`, see
:ref:`formatstrings`.

要查看 :meth:`str.format` 的详细内容，参见 :ref:`formatstrings`。

Old string formatting 旧的字符串格式化
----------------------------------

The ``%`` operator can also be used for string formatting. It interprets the
left argument much like a :cfunc:`sprintf`\ -style format string to be applied
to the right argument, and returns the string resulting from this formatting
operation. For example::

``%`` 操作符与可以用于字符串格式化。它将左边的参数视为 :cfunc:`sprintf`\ -style
的格式化字符串，应用右边的参数，返回格式化后的字符串，例如： ::

   >>> import math
   >>> print 'The value of PI is approximately %5.3f.' % math.pi
   The value of PI is approximately 3.142.

Since :meth:`str.format` is quite new, a lot of Python code still uses the ``%``
operator. However, because this old style of formatting will eventually removed
from the language :meth:`str.format` should generally be used.

因为 :meth:`str.format` 还太新，大量的 Python 源码还使用 ``%`` 操作符。然而，因
为旧式的格式化操作符迟早会从语言中取消，以后应该尽量使用 :meth:`str.format`。

More information can be found in the :ref:`string-formatting` section.

在 :ref:`string-formatting` 一节可以看到更多的信息。

.. _tut-files:

Reading and Writing Files 读写文件
================================

.. index::
   builtin: open
   object: file

:func:`open` returns a file object, and is most commonly used with two
arguments: ``open(filename, mode)``.

:func:`open` 返回一个文件对象，最常用的方式传入两个参数： ``open(filename, mode)``。

::

   >>> f = open('/tmp/workfile', 'w')
   >>> print f
   <open file '/tmp/workfile', mode 'w' at 80a0960>

The first argument is a string containing the filename.  The second argument is
another string containing a few characters describing the way in which the file
will be used.  *mode* can be ``'r'`` when the file will only be read, ``'w'``
for only writing (an existing file with the same name will be erased), and
``'a'`` opens the file for appending; any data written to the file is
automatically added to the end.  ``'r+'`` opens the file for both reading and
writing. The *mode* argument is optional; ``'r'`` will be assumed if it's
omitted.

第一个参数是文件名字符串。第二个参数也是字符串，通过几个字符来指示文件的使用方式。
如果只需要读文件，*mode* 可以是 ``'r'``；``'w'`` 是只写（如果有同名的文件会被清
除）。``'a'`` 以添加模式打开文件，所有写入数据自动添加到末尾。 ``'r+`` 以读写两
种模式打开文件。参数 *mode* 是可选的，如果忽略它，默认为``'r'``。

On Windows, ``'b'`` appended to the mode opens the file in binary mode, so there
are also modes like ``'rb'``, ``'wb'``, and ``'r+b'``.  Windows makes a
distinction between text and binary files; the end-of-line characters in text
files are automatically altered slightly when data is read or written.  This
behind-the-scenes modification to file data is fine for ASCII text files, but
it'll corrupt binary data like that in :file:`JPEG` or :file:`EXE` files.  Be
very careful to use binary mode when reading and writing such files.  On Unix,
it doesn't hurt to append a ``'b'`` to the mode, so you can use it
platform-independently for all binary files.

在 Windows 上，加上 ``'b'`` 就以二进制模式打开文件，形如
``'rb'``，``'wb'``，``'r+b'`` 这样。Windows 的文本和二进制的处理方式有区别，在以
文本模式读写的情况下自动维护换行符。如果文件是纯 ASCII 文本，这种幕后操作没什么
问题，但是如果文件是 :file:`JPEG` 或 :file:`EXE` 这类的二进制类型，就一定要注意
使用二进制模式来读写。在 Unix 上，模式中加上 ``'b'`` 也不会有什么伤害，所以对于
所有二进制文件你可以平台中立的使用它。


.. _tut-filemethods:

Methods of File Objects 文件对象方法
-----------------------------------

The rest of the examples in this section will assume that a file object called
``f`` has already been created.

本节中的例子都假定有一个名为 ``f`` 的文件对象已经存在。

To read a file's contents, call ``f.read(size)``, which reads some quantity of
data and returns it as a string.  *size* is an optional numeric argument.  When
*size* is omitted or negative, the entire contents of the file will be read and
returned; it's your problem if the file is twice as large as your machine's
memory. Otherwise, at most *size* bytes are read and returned.  If the end of
the file has been reached, ``f.read()`` will return an empty string (``""``).

要读取文件内容，就调用 ``f.read(size)``，它将文件数据大块的取出来，以字符串返回。
*size* 是一个可选的数值参数。省略 *size* 或其为负数时，就读取整个内容并返回。如
果文件对于你的机器内存来说太大，那就是你自找麻烦了。另外，*size* 是读取的最大字
节数，如果读到了文件的末尾， ``f.read()`` 会返回一个空字符串 （``""``）。 ::

   >>> f.read()
   'This is the entire file.\n'
   >>> f.read()
   ''

``f.readline()`` reads a single line from the file; a newline character (``\n``)
is left at the end of the string, and is only omitted on the last line of the
file if the file doesn't end in a newline.  This makes the return value
unambiguous; if ``f.readline()`` returns an empty string, the end of the file
has been reached, while a blank line is represented by ``'\n'``, a string
containing only a single newline.   ::

``f.readline()`` 从文件中读取单行信息；在字符串末尾保留一个换行符（``\n``），文
件没有以换行结束的情况下，才会省略它。这使得返回值并不确定。如果
``f.readline()`` 返回一个空字符串，就表示到达了文件结尾；而空字符串表示为一个只
包含一个换行符的 ``'\n'``。 ::

   >>> f.readline()
   'This is the first line of the file.\n'
   >>> f.readline()
   'Second line of the file\n'
   >>> f.readline()
   ''

``f.readlines()`` returns a list containing all the lines of data in the file.
If given an optional parameter *sizehint*, it reads that many bytes from the
file and enough more to complete a line, and returns the lines from that.  This
is often used to allow efficient reading of a large file by lines, but without
having to load the entire file in memory.  Only complete lines will be returned.

``f.readlines()`` 返回一个列表，包含文件中所有的数据行。如果给出了可选参数
*sizehint*， 它从文件中读取指定行数的数据并返回。这通常用于提高按行读取大文件的
效率，不必将整个文件加载到内存。返回的都是整行。
::

   >>> f.readlines()
   ['This is the first line of the file.\n', 'Second line of the file\n']

An alternative approach to reading lines is to loop over the file object. This is
memory efficient, fast, and leads to simpler code::

有个读取行的好办法是在文件对象上循环。这个代码更快，更简单，可以更经济的使用内存 ::

   >>> for line in f:
           print line,

   This is the first line of the file.
   Second line of the file

The alternative approach is simpler but does not provide as fine-grained
control.  Since the two approaches manage line buffering differently, they
should not be mixed.



``f.write(string)`` writes the contents of *string* to the file, returning
``None``.   ::

   >>> f.write('This is a test\n')

To write something other than a string, it needs to be converted to a string
first::

   >>> value = ('the answer', 42)
   >>> s = str(value)
   >>> f.write(s)

``f.tell()`` returns an integer giving the file object's current position in the
file, measured in bytes from the beginning of the file.  To change the file
object's position, use ``f.seek(offset, from_what)``.  The position is computed
from adding *offset* to a reference point; the reference point is selected by
the *from_what* argument.  A *from_what* value of 0 measures from the beginning
of the file, 1 uses the current file position, and 2 uses the end of the file as
the reference point.  *from_what* can be omitted and defaults to 0, using the
beginning of the file as the reference point. ::

   >>> f = open('/tmp/workfile', 'r+')
   >>> f.write('0123456789abcdef')
   >>> f.seek(5)     # Go to the 6th byte in the file
   >>> f.read(1)        
   '5'
   >>> f.seek(-3, 2) # Go to the 3rd byte before the end
   >>> f.read(1)
   'd'

When you're done with a file, call ``f.close()`` to close it and free up any
system resources taken up by the open file.  After calling ``f.close()``,
attempts to use the file object will automatically fail. ::

   >>> f.close()
   >>> f.read()
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   ValueError: I/O operation on closed file

It is good practice to use the :keyword:`with` keyword when dealing with file
objects.  This has the advantage that the file is properly closed after its
suite finishes, even if an exception is raised on the way.  It is also much
shorter than writing equivalent :keyword:`try`\ -\ :keyword:`finally` blocks::

    >>> with open('/tmp/workfile', 'r') as f:
    ...     read_data = f.read()
    >>> f.closed
    True

File objects have some additional methods, such as :meth:`isatty` and
:meth:`truncate` which are less frequently used; consult the Library Reference
for a complete guide to file objects.


.. _tut-pickle:

The :mod:`pickle` Module
------------------------

.. index:: module: pickle

Strings can easily be written to and read from a file. Numbers take a bit more
effort, since the :meth:`read` method only returns strings, which will have to
be passed to a function like :func:`int`, which takes a string like ``'123'``
and returns its numeric value 123.  However, when you want to save more complex
data types like lists, dictionaries, or class instances, things get a lot more
complicated.

Rather than have users be constantly writing and debugging code to save
complicated data types, Python provides a standard module called :mod:`pickle`.
This is an amazing module that can take almost any Python object (even some
forms of Python code!), and convert it to a string representation; this process
is called :dfn:`pickling`.  Reconstructing the object from the string
representation is called :dfn:`unpickling`.  Between pickling and unpickling,
the string representing the object may have been stored in a file or data, or
sent over a network connection to some distant machine.

If you have an object ``x``, and a file object ``f`` that's been opened for
writing, the simplest way to pickle the object takes only one line of code::

   pickle.dump(x, f)

To unpickle the object again, if ``f`` is a file object which has been opened
for reading::

   x = pickle.load(f)

(There are other variants of this, used when pickling many objects or when you
don't want to write the pickled data to a file; consult the complete
documentation for :mod:`pickle` in the Python Library Reference.)

:mod:`pickle` is the standard way to make Python objects which can be stored and
reused by other programs or by a future invocation of the same program; the
technical term for this is a :dfn:`persistent` object.  Because :mod:`pickle` is
so widely used, many authors who write Python extensions take care to ensure
that new data types such as matrices can be properly pickled and unpickled.


