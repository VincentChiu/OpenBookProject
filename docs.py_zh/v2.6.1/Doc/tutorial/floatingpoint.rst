.. _tut-fp-issues:

************************************************************************
Floating Point Arithmetic:  Issues and Limitations 浮点运算：问题和限制
************************************************************************

.. sectionauthor:: Tim Peters <tim_one@users.sourceforge.net>


Floating-point numbers are represented in computer hardware as base 2 (binary)
fractions.  For example, the decimal fraction ::

浮点数在计算机硬件中以二进制的小数来表示. 比如, 十进制的小数 ::

   0.125

has value 1/10 + 2/100 + 5/1000, and in the same way the binary fraction ::

它的值为 1/10 + 2/100 + 5/1000, 同样在二进制小数中 ::

   0.001

has value 0/2 + 0/4 + 1/8.  These two fractions have identical values, the only
real difference being that the first is written in base 10 fractional notation,
and the second in base 2.

它的值是 0/2 + 0/4 + 1/8.  这两个小数的值相等, 唯一的差别是前一个是10进制的, 后一个是二进制的.

Unfortunately, most decimal fractions cannot be represented exactly as binary
fractions.  A consequence is that, in general, the decimal floating-point
numbers you enter are only approximated by the binary floating-point numbers
actually stored in the machine.

不幸的是, 多数的十进制小数不能被精确的表示为二进制小数. 导致的结果是,
计算机中存储的浮点数只是我们输入的十进制浮点数的近似值.

The problem is easier to understand at first in base 10.  Consider the fraction
1/3.  You can approximate that as a base 10 fraction::

为了便于的理解, 我们举个十进制的例子. 考虑一下分数 1/3. 你可以把它写成十进制小数形式 ::

   0.3

or, better, ::

再精确一点 ::

   0.33

or, better, ::

更加精确 ::

   0.333

and so on.  No matter how many digits you're willing to write down, the result
will never be exactly 1/3, but will be an increasingly better approximation of
1/3.

依此类推，有可能变得更精确. 但是无论写多少个数字, 结果永远不会正好等于分数 1/3, 我们只能
得到更近似于 1/3 的值.

In the same way, no matter how many base 2 digits you're willing to use, the
decimal value 0.1 cannot be represented exactly as a base 2 fraction.  In base
2, 1/10 is the infinitely repeating fraction ::

同样, 不管使用多少个二进制数字, 十进制的值 0.1 无法精确的用二进制小数来表示. 在二
进制中, 1/10 是一个无限循环小数 ::

   0.0001100110011001100110011001100110011001100110011...

Stop at any finite number of bits, and you get an approximation.  This is why
you see things like::

取有限的位数, 得到一个近似值. 这就是为什么你会看到下面的结果 ::

   >>> 0.1
   0.10000000000000001

On most machines today, that is what you'll see if you enter 0.1 at a Python
prompt.  You may not, though, because the number of bits used by the hardware to
store floating-point values can vary across machines, and Python only prints a
decimal approximation to the true decimal value of the binary approximation
stored by the machine.  On most machines, if Python were to print the true
decimal value of the binary approximation stored for 0.1, it would have to
display ::

对于大多数的计算机来说, 当你在Python提示符上输入 0.1 你会看到, 你会看到上面的. 如
果不是, 那可能是因为在不同机器上硬件用来存储浮点数的内存大小不一样, 另外, Python
只打印机器存储的二进制对应十进制的近似值. 在大多数机器上, 如果Python打印出二进制
0.1 近似值对应的真实十进制的话, 那么会显示 ::

   >>> 0.1
   0.1000000000000000055511151231257827021181583404541015625

instead!  The Python prompt uses the builtin :func:`repr` function to obtain a
string version of everything it displays.  For floats, ``repr(float)`` rounds
the true decimal value to 17 significant digits, giving ::

在任何对象需要被当作 string 显示的时候, Python提示符用内置函数 :func:`repr` 来把
对象转换成字符串. 对于浮点数, ``repr(float)`` 将浮点数的真实值取整变成 17 位有效
数字, 就如同 ::

   0.10000000000000001

``repr(float)`` produces 17 significant digits because it turns out that's
enough (on most machines) so that ``eval(repr(x)) == x`` exactly for all finite
floats *x*, but rounding to 16 digits is not enough to make that true.

之所以 ``repr(float)`` 产生17位有效数字，是因为在执行``eval(repr(x)) == x``这样的
表达式的时候，对那些有限位的浮点数 *x*，取整以后的16位数字足够让表达式值为真。

Note that this is in the very nature of binary floating-point: this is not a bug
in Python, and it is not a bug in your code either.  You'll see the same kind of
thing in all languages that support your hardware's floating-point arithmetic
(although some languages may not *display* the difference by default, or in all
output modes).

在处理浮点数的时候，这种情况相当的普遍：这不是Python的bug，也不是你写的代码的bug。
在任何支持硬件浮点运算的语言中，都会出现这样的情况。(尽管在某些语言或者输出模式
中，默认*显示*不出区别).

Python's builtin :func:`str` function produces only 12 significant digits, and
you may wish to use that instead.  It's unusual for ``eval(str(x))`` to
reproduce *x*, but the output may be more pleasant to look at::

Python的内置函数 :func:`str` 只生成保留12位有效数字的浮点数，有时候你可以用它。使
用``eval(str(x))``来处理*x*的方法不怎么常用，但是这个方法使得我们可以得到更加自然
的输出值 ::

   >>> print str(0.1)
   0.1

It's important to realize that this is, in a real sense, an illusion: the value
in the machine is not exactly 1/10, you're simply rounding the *display* of the
true machine value.

但是我们必须明确的认识到，真实的情况是，在计算机中的值并不精确的等于1/10，我们只
是简单的取整以后把它 *显示* 出来.

Other surprises follow from this one.  For example, after seeing ::

由此引发出一些其他的问题。比如下面的 ::

   >>> 0.1
   0.10000000000000001

you may be tempted to use the :func:`round` function to chop it back to the
single digit you expect.  But that makes no difference::

当我们打算用 :func:`round`函数取小数点后面一位的时候，却发现完全没有作用 ::

   >>> round(0.1, 1)
   0.10000000000000001

The problem is that the binary floating-point value stored for "0.1" was already
the best possible binary approximation to 1/10, so trying to round it again
can't make it better:  it was already as good as it gets.

出现这样的问题的原因是，"0.1"的二进制的浮点数值已经是1/10的最近似值了，所以无论怎
么近似，结果还是一样。

Another consequence is that since 0.1 is not exactly 1/10, summing ten values of
0.1 may not yield exactly 1.0, either::

另外一个后果是，因为0.1不等于1/10，所以十个0.1之和也不会等于1.0 ::

   >>> sum = 0.0
   >>> for i in range(10):
   ...     sum += 0.1
   ...
   >>> sum
   0.99999999999999989

Binary floating-point arithmetic holds many surprises like this.  The problem
with "0.1" is explained in precise detail below, in the "Representation Error"
section.  See `The Perils of Floating Point <http://www.lahey.com/float.htm>`_
for a more complete account of other common surprises.

二进制浮点运算给我们带来很多这样的“惊喜”。"0.1"带来的问题在本文的"表现错误"小节中
有着详细的解释。另外，`The Perils of Floating Point
<http://www.lahey.com/float.htm>`_ 中也有更加完整的描述。

As that says near the end, "there are no easy answers."  Still, don't be unduly
wary of floating-point!  The errors in Python float operations are inherited
from the floating-point hardware, and on most machines are on the order of no
more than 1 part in 2\*\*53 per operation.  That's more than adequate for most
tasks, but you do need to keep in mind that it's not decimal arithmetic, and
that every float operation can suffer a new rounding error.

最后我们要说，“没有完美的方法”。但是，不要过分的拒绝浮点数！Python浮点操作中的错
误是由硬件本身限制的，在大多数的机器上每次运算的误差不会超过2的53次方之一。这样的
误差在大多数的任务中是可以被接受的。但是，我们还是要牢记我们做的并不是十进制运
算，任何一个浮点预算都有可能产生一个新的错误。

While pathological cases do exist, for most casual use of floating-point
arithmetic you'll see the result you expect in the end if you simply round the
display of your final results to the number of decimal digits you expect.
:func:`str` usually suffices, and for finer control see the :meth:`str.format`
method's format specifiers in :ref:`formatstrings`.

当不出意外的时候，通常情况下大多数的浮点运算我们会得到我们期望的结果，你只需要简
单的取小数位，最终得到和十进制的一样的显示结果。:func:`str` 函数基本上够用了，为
了更好的控制输出结果，可以参见 :ref:`formatstrings` 中介绍的 :meth:`str.format`
方法的格式化方式。

.. _tut-fp-error:

Representation Error 表示错误
=============================

This section explains the "0.1" example in detail, and shows how you can perform
an exact analysis of cases like this yourself.  Basic familiarity with binary
floating-point representation is assumed.

本节详细讨论“0.1”问题，向你展示如何自已进行一个精确的分析。基本掌握二进制浮点数表示理论。

:dfn:`Representation error` refers to the fact that some (most, actually)
decimal fractions cannot be represented exactly as binary (base 2) fractions.
This is the chief reason why Python (or Perl, C, C++, Java, Fortran, and many
others) often won't display the exact decimal number you expect::

:dfn:`表示错误` 源于事实上一些（事实上是大多）十进制分数不能精确表示为二进制分数。这就是Python（
以及 Perl，C，C++，Java，Fortran 等等）语言通常不会显示出你期望的十进制数值的原
因： ::

   >>> 0.1
   0.10000000000000001

Why is that?  1/10 is not exactly representable as a binary fraction. Almost all
machines today (November 2000) use IEEE-754 floating point arithmetic, and
almost all platforms map Python floats to IEEE-754 "double precision".  754
doubles contain 53 bits of precision, so on input the computer strives to
convert 0.1 to the closest fraction it can of the form *J*/2\*\**N* where *J* is
an integer containing exactly 53 bits.  Rewriting ::

这是为什么？ 1/10 不能被精确表示为二进制分数。今天（2000年十一月）的大多数机器使
用 IEEE-754 浮点算法，大多平台将 Python 浮点数对映为 IEEE-754 “双精度浮点数”。
754 双精度浮点数有 53 比特位精度，所以计算机输入时将 0.1 尽可能的转为最接近的
*J*/2\*\**N* 形式。 *J* 是一个包含53比特的整数。如下： ::

   1 / 10 ~= J / (2**N)

as ::

即 ::

   J ~= 2**N / 10

and recalling that *J* has exactly 53 bits (is ``>= 2**52`` but ``< 2**53``),
the best value for *N* is 56::

前面提到 *J* 需要 53 比特位（``大于等于 2**52`` 且 ``小于53``）， *N* 的最佳值是
56： ::

   >>> 2**52
   4503599627370496L
   >>> 2**53
   9007199254740992L
   >>> 2**56/10
   7205759403792793L

That is, 56 is the only value for *N* that leaves *J* with exactly 53 bits.  The
best possible value for *J* is then that quotient rounded::

于是，对于 *J* 期待的 53 位，56是 *N* 的唯一可选值。 *J* 的最佳可用值是下面计算出的范围： ::

   >>> q, r = divmod(2**56, 10)
   >>> r
   6L

Since the remainder is more than half of 10, the best approximation is obtained
by rounding up::

因为余数大于10的一半，最好的逼近方法是由上界逼近 ： ::

   >>> q+1
   7205759403792794L

Therefore the best possible approximation to 1/10 in 754 double precision is
that over 2\*\*56, or ::

因此 1/10 在 754 双精度下最接近的是它比 2\*\*56 ，即： ::

   7205759403792794 / 72057594037927936

Note that since we rounded up, this is actually a little bit larger than 1/10;
if we had not rounded up, the quotient would have been a little bit smaller than
1/10.  But in no case can it be *exactly* 1/10!

注意，因为这里我们取上界，所以它实际上比 1/10 大一点点。如果我们取下界，就会比
1/10 小一点。不过它不会 *恰好* 是 1/10 ！

So the computer never "sees" 1/10:  what it sees is the exact fraction given
above, the best 754 double approximation it can get::

所以计算机无法“理解” 1/10：它理解收到的分数，给出它所能得到的最佳精度： ::

   >>> .1 * 2**56
   7205759403792794.0

If we multiply that fraction by 10\*\*30, we can see the (truncated) value of
its 30 most significant decimal digits::

如果我们将这个分数乘 10**30，我们可以看到（被截断）的30位十进制有效数字： ::

   >>> 7205759403792794 * 10**30 / 2**56
   100000000000000005551115123125L

meaning that the exact number stored in the computer is approximately equal to
the decimal value 0.100000000000000005551115123125.  Rounding that to 17
significant digits gives the 0.10000000000000001 that Python displays (well,
will display on any 754-conforming platform that does best-possible input and
output conversions in its C library --- yours may not!).

这意味着保存在计算机中的精确数值约等于十进制值 0.100000000000000005551115123125
。接近于Python显示的17位 0.10000000000000001（哦，在任何符合754的平台上通过其 C 
库最可能出现的输入输出结果就是这样了，你的环境可能不太一样！）。
