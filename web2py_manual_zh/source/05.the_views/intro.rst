本章导读
===============

尽管WEB2PY使用Python语言用来编写他的数据层，控制器和表现层，但是为了安全起见以及更加易于阅读，它还是使用了一种修改过的更加Python语法来编写表现层。

表现层的目的就是在HTML文档里面嵌入代码（Python）。但是我们常常在嵌入过程中遇到这样的问题：

- 怎么区分这些嵌入的代码？
- 代码缩进的规则是应该基于Python还是HTML呢？

WEB2PY用{{...}}来区分嵌入在HTML的Python代码。用花括号而不用的圆括号的好处就是，它对所有的HTML编辑器都是透明的。意思就是说。这让开发者们可以很轻松的用HTML编辑器来编写WEB2PY的显示层。

尽管开发者在HTML里面嵌入Python的代码，但是文档本身还是应该根据HTML的规则来缩进，而非Python的规则。因此，尽管Python是靠强制缩进来区分代码块的，但是我们不需要在{{...}}里面强制按照Python的要求缩进。当然，需要有相应的模板语言来达到同样的区分代码块的功能，这就是关键字pass的作用了。

*一个代码块从一个以冒号结尾的句子开始，到一个以pass开头的句子结束。当一个代码块根据上下文以一种很明显的方式结束时，pass关键字不是必要的。*

下面给出一个样例：

::

    {{
    if i==0:
    response.write('iis0')
    else:
    response.write('iisnot0')
    pass
    }}

需要说明的是，pass是一个Python的关键字，而不是WEB2PY的关键字。某一些Python的编辑器，比如Emacs，用pass关键字来区分代码块和自动重新缩进。

WEB2PY模板语言自动生成的结果几乎是一样的，当他发现了形如以下的代码：

::

    <html><body>
    {{for x in range(10):}}{{=x}}hello<br/>{{pass}}
    </body></html>

它把这段代码翻译成一段Python程序：

::

    response.write("""<html><body>""", escape=False)
    for x in range(10):
        response.write(x)
        response.write("""hello<br />""", escape=False)
    response.write("""</body></html>""",escape=False)

其中，response.write函数把字符串写入到response.body之中。

当WEB2PY的显示层里面出现了错误的时候，在错误报告里面会显示经过翻译的Python代码，而不是开发者编写的原始代码。这个特性能够帮助开发者调试真实的执行代码（就是那种可以在HTML编辑器或者浏览器的DOM查看器里面调试的东东）。

需要注意的是，以下这行代码：

::
    
    {{=x}}

经过翻译生成的Python代码为：

::
    
    response.write(x)

像这样被嵌入到HTML里面的变量默认是会被转义的。只有当x是一个XML对象的时候才不会被转义，在这种情况下，就算是escape参数设置成True，x还是不会被转义。

下面给出一个H1辅助函数的介绍，如下所示的一个函数：

::

    {{=H1(i)}}

会被翻译成如下的Python代码：

::
    
    response.write(H1(i))

在这里，H1对象和它所包含的组件会被递归的序列化，转义然后写进response的body里面去。那些被H1生成的标签和里面的HTML不会被转义。这个特性保证了所有在web页面上被显示出来的文本——并且只有文本——会被转义，因而防止了XSS受到破坏。同时，代码也更加煎蛋且易于调试。

response.write(obj, escape=True)方法接收2个参数，被写入进body的对象以及它是否需要被转义（默认是True）。如果obj是一个.xml()方法，那么它就会被调用，然后结果会被写进到body里面（escape参数就会自动被忽略了）。否则，系统就会调用这个对象的__str__方法把它序列化了，然后根据escape参数的设置情况选择是否将执行结果序列化。所有的内建的辅助函数（例如H1），都指导怎么调用.xml方法去序列化他们自己。

所有的这些都是会被透明的执行。你完全不需要（也不应该）
