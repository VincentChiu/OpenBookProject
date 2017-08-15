.. _tut-errors:

**********************************
Errors and Exceptions 错误和异常
**********************************

Until now error messages haven't been more than mentioned, but if you have tried
out the examples you have probably seen some.  There are (at least) two
distinguishable kinds of errors: *syntax errors* and *exceptions*.

直到现在，我们还没有更多的提及错误信息，但是如果你真的尝试了前面的例子，也许你会见到一些。这里
（至少）有两种错误很容易辨认：*语法错误*和*异常*。

.. _tut-syntaxerrors:

Syntax Errors 语法错误
======================

Syntax errors, also known as parsing errors, are perhaps the most common kind of
complaint you get while you are still learning Python::

语法错误，或者称之为解析错，是你在学习 Python 的过程中最无孔不入的一种了::

   >>> while True print 'Hello world'
     File "<stdin>", line 1, in ?
       while True print 'Hello world'
                      ^
   SyntaxError: invalid syntax

The parser repeats the offending line and displays a little 'arrow' pointing at
the earliest point in the line where the error was detected.  The error is
caused by (or at least detected at) the token *preceding* the arrow: in the
example, the error is detected at the keyword :keyword:`print`, since a colon
(``':'``) is missing before it.  File name and line number are printed so you
know where to look in case the input came from a script.

语法分析器指出了出错的一行，并且在最先找到的错误的位置标记了一个小小的'箭头'。箭头靠前的位置，
就是错误发生（或者至少是被发现）的位置。这个例子中，函数 :func:`print` 被检查到有错误，
是它前面缺少了一个冒号（``':'``）。文件名和行号一并给出，这样就方便的获知是哪一个脚本的问题了。


.. _tut-exceptions:

Exceptions 异常
===============

Even if a statement or expression is syntactically correct, it may cause an
error when an attempt is made to execute it. Errors detected during execution
are called *exceptions* and are not unconditionally fatal: you will soon learn
how to handle them in Python programs.  Most exceptions are not handled by
programs, however, and result in error messages as shown here::

就算一个语句或表达式在语法上是正确的，在运行它的时候，也有可能发生错误。运行期检测到的错误被称
为*异常*，程序并不会无条件的崩掉，你很快就可以了解到在Python中如何处理它们了。大多数的异常
都不会被程序处理，都以错误信息的形式展现在这里::

   >>> 10 * (1/0)
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   ZeroDivisionError: integer division or modulo by zero
   >>> 4 + spam*3
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   NameError: name 'spam' is not defined
   >>> '2' + 2
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: cannot concatenate 'str' and 'int' objects

The last line of the error message indicates what happened. Exceptions come in
different types, and the type is printed as part of the message: the types in
the example are :exc:`ZeroDivisionError`, :exc:`NameError` and :exc:`TypeError`.
The string printed as the exception type is the name of the built-in exception
that occurred.  This is true for all built-in exceptions, but need not be true
for user-defined exceptions (although it is a useful convention). Standard
exception names are built-in identifiers (not reserved keywords).

错误信息的最后一行告诉你到底发生了什么。异常以不同的类型出现，这些类型都作为信息的一部分打印出
来: 例子中的类型有 :exc:`ZeroDivisionError`，:exc:`NameError` 和 :exc:`TypeError`。
被打印出的异常类型的字符串就是内置的异常的名称。这条规则适用于所有的内置异常，但对用户定义的异
常并不强制（虽然这是非常有用的方法）。标准的异常名称是内置的标识符（没有保留关键字）。

The rest of the line provides detail based on the type of exception and what
caused it.

这一行最后一部分描述了异常的详细内容和发生的原因。

The preceding part of the error message shows the context where the exception
happened, in the form of a stack traceback. In general it contains a stack
traceback listing source lines; however, it will not display lines read from
standard input.

错误信息的前面部分显示了异常发生的上下文，并以调用栈的形式显示具体信息。通常它包含调用栈
里的每一个源代码行，然而，来自标准输入的源码不会显示出来。

:ref:`bltin-exceptions` lists the built-in exceptions and their meanings.


.. _tut-handling:

Handling Exceptions 异常处理
============================

It is possible to write programs that handle selected exceptions. Look at the
following example, which asks the user for input until a valid integer has been
entered, but allows the user to interrupt the program (using :kbd:`Control-C` or
whatever the operating system supports); note that a user-generated interruption
is signalled by raising the :exc:`KeyboardInterrupt` exception. ::

可以通过编程来处理选中的异常。下面的例子让用户输入一个合法的整数，但是允许用户中断这个程序（使
用 :kbd:`Control-C` 或者操作系统提供的方法）。用户中断的信息会引发一个 
:exc:`KeyboardInterrupt` 异常。 ::

   >>> while True:
   ...     try:
   ...         x = int(raw_input("Please enter a number: "))
   ...         break
   ...     except ValueError:
   ...         print "Oops!  That was no valid number.  Try again..."
   ...     

The :keyword:`try` statement works as follows.

:keyword:`try`语句按照如下方式工作。

* First, the *try clause* (the statement(s) between the :keyword:`try` and
  :keyword:`except` keywords) is executed.

  首先，执行*try子句*（在关键字:keyword:`try`和关键字:keyword:`except`之间的语句）

* If no exception occurs, the *except clause* is skipped and execution of the
  :keyword:`try` statement is finished.

  如果在执行try子句的过程中发生了异常，那么try子句余下的部分将被忽略。如果异常的类型
和 :keyword:`except` 之后的名称相符，那么对应的except子句将被执行。最后执
行 :keyword:`try` 语句之后的代码。

* If an exception occurs during execution of the try clause, the rest of the
  clause is skipped.  Then if its type matches the exception named after the
  :keyword:`except` keyword, the except clause is executed, and then execution
  continues after the :keyword:`try` statement.

  如果一个异常没有与任何的except匹配，那么这个异常将会传递给上层的:keyword:`try`中。
如果最终仍然没有找到能够处理这个异常的代码，那么他就成了一个*未处理异常*，执行被中断，显
示提示信息。

* If an exception occurs which does not match the exception named in the except
  clause, it is passed on to outer :keyword:`try` statements; if no handler is
  found, it is an *unhandled exception* and execution stops with a message as
  shown above.

  如果发生的异常没有被 except 子句匹配到，它就被抛出到上一个 :keyword:`try` 语句。
  如果一直找不到匹配，以 *未捕获异常* 中止程序并显示消息。

A :keyword:`try` statement may have more than one except clause, to specify
handlers for different exceptions.  At most one handler will be executed.
Handlers only handle exceptions that occur in the corresponding try clause, not
in other handlers of the same :keyword:`try` statement.  An except clause may
name multiple exceptions as a parenthesized tuple, for example::

一个 :keyword:`try` 语句可能包含多个except子句，分别来处理不同的特定的异常。最多只有一个
分支会被执行。处理程序将只针对对应的try子句中的异常进行处理，而不是其他的 :keyrowd:`try` 
的处理程序中的异常。一个except子句可以同时处理多个异常，这些异常将被放在一个括号里成为一个
元组，例如： ::

   ... except (RuntimeError, TypeError, NameError):
   ...     pass

The last except clause may omit the exception name(s), to serve as a wildcard.
Use this with extreme caution, since it is easy to mask a real programming error
in this way!  It can also be used to print an error message and then re-raise
the exception (allowing a caller to handle the exception as well)::

最后一个except子句可以忽略异常的名称，它将被当作通配符使用。这种方法要慎用！搞不好你会把程序中真
正的错误隐藏的无影无踪。你可以使用这种方法打印一个错误信息，然后再次把异常抛出
（就让调用者去处理这个烫手的山芋吧）::

   import sys

   try:
       f = open('myfile.txt')
       s = f.readline()
       i = int(s.strip())
   except IOError as (errno, strerror):
       print "I/O error({0}): {1}".format(errno, strerror)
   except ValueError:
       print "Could not convert data to an integer."
   except:
       print "Unexpected error:", sys.exc_info()[0]
       raise

The :keyword:`try` ... :keyword:`except` statement has an optional *else
clause*, which, when present, must follow all except clauses.  It is useful for
code that must be executed if the try clause does not raise an exception.  For
example::

:keyword:`try` ... :keyword:`except`语句还有一个可选的*else子句*，如果使用这个子句，
那么必须放在所有的except子句之后。这个子句将在try子句没有发生任何异常的时候执行。例如::

   for arg in sys.argv[1:]:
       try:
           f = open(arg, 'r')
       except IOError:
           print 'cannot open', arg
       else:
           print arg, 'has', len(f.readlines()), 'lines'
           f.close()

The use of the :keyword:`else` clause is better than adding additional code to
the :keyword:`try` clause because it avoids accidentally catching an exception
that wasn't raised by the code being protected by the :keyword:`try` ...
:keyword:`except` statement.

使用 :keyword:`else` 子句比把所有的语句都放在 :keyword:`try` 子句里面要好，这样可以避免
一些意想不到的、而except又没有捕获的异常。

When an exception occurs, it may have an associated value, also known as the
exception's *argument*. The presence and type of the argument depend on the
exception type.

当发生了一个异常，可能伴随着会有相关数据，也就是所谓的异常的*参数*。是否有这个参数，以及它
的类型取决于异常的类型。

The except clause may specify a variable after the exception name (or tuple).
The variable is bound to an exception instance with the arguments stored in
``instance.args``.  For convenience, the exception instance defines
:meth:`__getitem__` and :meth:`__str__` so the arguments can be accessed or
printed directly without having to reference ``.args``.

except语句可以在异常名字（或元组）之后指定一个变量。这个变量绑定异常实例，异常的参数存放
在 ``instance.args`` 里面。为了方便使用，这个实例定义了方法 :meth:`__getitem__` 
和 :meth:`__str__`，所以这个参数可以直接用于赋值或打印，而不必麻烦的使用 ``.args``。

But use of ``.args`` is discouraged.  Instead, the preferred use is to pass a
single argument to an exception (which can be a tuple if multiple arguments are
needed) and have it bound to the ``message`` attribute.  One may also
instantiate an exception first before raising it and add any attributes to it as
desired. ::

但是并不推荐使用 ``.args``。取而代之的是，这里欢迎给异常传递一个单独的参数（如果多个参数，
使用元组也可以），把它绑定到 ``message`` 属性上。一旦发生异常，它将在抛出前绑定所有指定的属性::

   >>> try:
   ...    raise Exception('spam', 'eggs')
   ... except Exception as inst:
   ...    print type(inst)     # the exception instance
   ...    print inst.args      # arguments stored in .args
   ...    print inst           # __str__ allows args to printed directly
   ...    x, y = inst          # __getitem__ allows args to be unpacked directly
   ...    print 'x =', x
   ...    print 'y =', y
   ...
   <type 'exceptions.Exception'>
   ('spam', 'eggs')
   ('spam', 'eggs')
   x = spam
   y = eggs

If an exception has an argument, it is printed as the last part ('detail') of
the message for unhandled exceptions.

对于未处理的异常，如果他含有参数，那么他就会被当作详细信息打印出来。

Exception handlers don't just handle exceptions if they occur immediately in the
try clause, but also if they occur inside functions that are called (even
indirectly) in the try clause. For example::

异常处理并不仅仅处理那些直接发生在try子句中的异常，而且还能处理子句中调用的函
数（甚至间接调用的函数）里抛出的异常。例如::

   >>> def this_fails():
   ...     x = 1/0
   ... 
   >>> try:
   ...     this_fails()
   ... except ZeroDivisionError as detail:
   ...     print 'Handling run-time error:', detail
   ... 
   Handling run-time error: integer division or modulo by zero


.. _tut-raising:

Raising Exceptions 抛出异常
=========================

The :keyword:`raise` statement allows the programmer to force a specified
exception to occur. For example::

:keyword:`raise` 语句允许程序员强制抛出一个指定的异常。例如::

   >>> raise NameError, 'HiThere'
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   NameError: HiThere

The first argument to :keyword:`raise` names the exception to be raised.  The
optional second argument specifies the exception's argument.  Alternatively, the
above could be written as ``raise NameError('HiThere')``.  Either form works
fine, but there seems to be a growing stylistic preference for the latter.

第一个参数是抛出（:keyword:`raise`）的异常名。可选的第二个参数是异常的特定参数。
另外，也可以写作 ``raise NameError('HiThere')``。两种都可以用，只是后一种看起来
更符合未来的语法发展趋势。

If you need to determine whether an exception was raised but don't intend to
handle it, a simpler form of the :keyword:`raise` statement allows you to
re-raise the exception::

如果你想要拿到一个异常，但是不拦截它，有个简单的形式，:keyword:`raise` 语句可以
重新抛出它： ::

   >>> try:
   ...     raise NameError, 'HiThere'
   ... except NameError:
   ...     print 'An exception flew by!'
   ...     raise
   ...
   An exception flew by!
   Traceback (most recent call last):
     File "<stdin>", line 2, in ?
   NameError: HiThere


.. _tut-userexceptions:

User-defined Exceptions 用户定义异常
===================================

Programs may name their own exceptions by creating a new exception class.
Exceptions should typically be derived from the :exc:`Exception` class, either
directly or indirectly.  For example::

程序可以通过定义异常类型来创建自己的异常。异常应该直接或间接的继承自
:exc:`Exception` 类型。例如： ::

   >>> class MyError(Exception):
   ...     def __init__(self, value):
   ...         self.value = value
   ...     def __str__(self):
   ...         return repr(self.value)
   ... 
   >>> try:
   ...     raise MyError(2*2)
   ... except MyError as e:
   ...     print 'My exception occurred, value:', e.value
   ... 
   My exception occurred, value: 4
   >>> raise MyError, 'oops!'
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   __main__.MyError: 'oops!'

In this example, the default :meth:`__init__` of :class:`Exception` has been
overridden.  The new behavior simply creates the *value* attribute.  This
replaces the default behavior of creating the *args* attribute.

在本例中， :class:`Exception` 的默认构造函数 :meth:`__init__` 被覆盖。新的行为只
是简单的创建 *value* 属性，这取代了默认的创建 *args* 属性的行为。

Exception classes can be defined which do anything any other class can do, but
are usually kept simple, often only offering a number of attributes that allow
information about the error to be extracted by handlers for the exception.  When
creating a module that can raise several distinct errors, a common practice is
to create a base class for exceptions defined by that module, and subclass that
to create specific exception classes for different error conditions::

异常类型可以和其它类型一样定义任何行为，不过通常来讲尽量保持它简单，只提供几个属
性，以便拦截异常后了解错误信息。如果创建了一个可能抛出几种不同错误的模块，通常的
习惯是为这个模块的异常定义一个基类，为不同错误条件设计的所有特定异常都从此派生： ::

   class Error(Exception):
       """Base class for exceptions in this module."""
       pass

   class InputError(Error):
       """Exception raised for errors in the input.

       Attributes:
           expression -- input expression in which the error occurred
           message -- explanation of the error
       """

       def __init__(self, expression, message):
           self.expression = expression
           self.message = message

   class TransitionError(Error):
       """Raised when an operation attempts a state transition that's not
       allowed.

       Attributes:
           previous -- state at beginning of transition
           next -- attempted new state
           message -- explanation of why the specific transition is not allowed
       """

       def __init__(self, previous, next, message):
           self.previous = previous
           self.next = next
           self.message = message

Most exceptions are defined with names that end in "Error," similar to the
naming of the standard exceptions.

大多数异常定义都以 "Error" 结尾，就像标准异常名一样。

Many standard modules define their own exceptions to report errors that may
occur in functions they define.  More information on classes is presented in
chapter :ref:`tut-classes`.

大多数标准模块定义它们的异常，在其定义的函数发生错误时报告错误。详情参见
:ref:`tut-classes` 一章。

.. _tut-cleanup:

Defining Clean-up Actions 定义清理动作
===================================

The :keyword:`try` statement has another optional clause which is intended to
define clean-up actions that must be executed under all circumstances.  For
example::

关键字 :keyword:`try` 有另一个可选的子句，可以定义清理动作，无论任何情况下都会执
行。例如： ::

   >>> try:
   ...     raise KeyboardInterrupt
   ... finally:
   ...     print 'Goodbye, world!'
   ... 
   Goodbye, world!
   Traceback (most recent call last):
     File "<stdin>", line 2, in ?
   KeyboardInterrupt

A *finally clause* is always executed before leaving the :keyword:`try`
statement, whether an exception has occurred or not. When an exception has
occurred in the :keyword:`try` clause and has not been handled by an
:keyword:`except` clause (or it has occurred in a :keyword:`except` or
:keyword:`else` clause), it is re-raised after the :keyword:`finally` clause has
been executed.  The :keyword:`finally` clause is also executed "on the way out"
when any other clause of the :keyword:`try` statement is left via a
:keyword:`break`, :keyword:`continue` or :keyword:`return` statement.  A more
complicated example (having :keyword:`except` and :keyword:`finally` clauses in
the same :keyword:`try` statement works as of Python 2.5)::

在离开 :keyword:`try` 语句之前，*finally 子句* 总是会执行，无论是否发生异常。在
:keyword:`try` 子句发生了一个没有被 :keyword:`except` 捕获（或它发生于
:keyword:`except` 或 :keyword:`else` 子句中）的异常时，会在执行
:keyword:`finally` 子句后重新抛出异常。 :keyword:`finally` 子句即使在
:keyword:`try` 子句中另有 :keyword:`break`，:keyword:`continue` 或
:keyword:`return` 语句的情况下，也一样会`从此路离开`。更为完整的示例如下（自
Python 2.5 起 :keyword:`try` 语句中可以同时有 :keyword:`except` 和
:keyword:`finally` 子句）： ::

   >>> def divide(x, y):
   ...     try:
   ...         result = x / y
   ...     except ZeroDivisionError:
   ...         print "division by zero!"
   ...     else:
   ...         print "result is", result
   ...     finally:
   ...         print "executing finally clause"
   ...
   >>> divide(2, 1)
   result is 2
   executing finally clause
   >>> divide(2, 0)
   division by zero!
   executing finally clause
   >>> divide("2", "1")
   executing finally clause
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
     File "<stdin>", line 3, in divide
   TypeError: unsupported operand type(s) for /: 'str' and 'str'

As you can see, the :keyword:`finally` clause is executed in any event.  The
:exc:`TypeError` raised by dividing two strings is not handled by the
:keyword:`except` clause and therefore re-raised after the :keyword:`finally`
clause has been executed.

如你所见，任何情况下 :keyword:`finally` 子句都会执行。 两个字符串相除抛出了
:exec:`TypeError`，没有被 :keyword:`except` 捕获，所以执行 :keyword:`finally` 子
句之后被重新抛出。

In real world applications, the :keyword:`finally` clause is useful for
releasing external resources (such as files or network connections), regardless
of whether the use of the resource was successful.

真实环境的应用中，:keyword:`finally` 子句用于释放扩展资源（例如文件或网络联接），无
论资源调用是否成功。

.. _tut-cleanup-with:

Predefined Clean-up Actions 预定义清理动作
=======================================

Some objects define standard clean-up actions to be undertaken when the object
is no longer needed, regardless of whether or not the operation using the object
succeeded or failed. Look at the following example, which tries to open a file
and print its contents to the screen. ::

有些对象定义了标准的清理动作，无论对象操作成功与否，当它不再被需要的时候，都会执
行。参见下面这个打开文件并在屏幕上打印内容的例子。 ::

   for line in open("myfile.txt"):
       print line

The problem with this code is that it leaves the file open for an indeterminate
amount of time after the code has finished executing. This is not an issue in
simple scripts, but can be a problem for larger applications. The
:keyword:`with` statement allows objects like files to be used in a way that
ensures they are always cleaned up promptly and correctly. ::

这段代码的问题在于它无法确定在代码执行完以后，文件还会打开多久。在小脚本中这没什
么问题，但是在更大的应用程序中就会是个麻烦了。 :keyword:`with` 语句确保文件这样
的对象在执行完后总是能安全、及时的被清理。 ::

   with open("myfile.txt") as f:
       for line in f:
           print line

After the statement is executed, the file *f* is always closed, even if a
problem was encountered while processing the lines. Other objects which provide
predefined clean-up actions will indicate this in their documentation.

语句执行完后，文件 *f* 总是会被关闭，即使处理文本行时出错也一样。查阅文档可以知
道其它的对象是否提供了清理动作。


