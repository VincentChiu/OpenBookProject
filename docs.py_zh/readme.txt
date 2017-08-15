= docs.py 中文计划 =
 简述::
    立志建立及时的 Python 官方文档中文翻译工程环境
 版本::
  * 090104 ZoomQuiet 增补掺合流程,,,
  * 081218 ZoomQuiet 发现链接文件目录编译有问题,修订本地编译方式,,,
  * 081217 ZoomQuiet 增补官方文档编译方法
   * Revision 2070: /trunk/docs.py_zh/v2.6.1 正式启动 全Py2.6.*官方文档中文翻译
   * Revision 2071: /trunk/docs.py_zh/v3.0 正式启动 全Py3.*官方文档中文翻译
  * 081214 ZoomQuiet 创建
 关联::
  * PyMOTW中文文档 - http://groups.google.com/group/python-cn/browse_thread/thread/7dff0bd9a30b921f
== 翻译约定 ==
 * 统一翻译关键词:
    * SVN：http://openbookproject.googlecode.com/svn/trunk/zh_terms.txt
    * 是以往所有翻译工程积累下来的关键词建议译文以及讨论,请所有掺合的行者注意更新
 * 统一文本组织:
    * 尽力使用纯文本进行组织,方便进行版本追踪
    * 使用 UTF-8 编码,以便所有平台的行者统一使用
    * 使用单字节,ASCII标点符号

== 工程约定 ==
`约定这一中文版文档工程的相关协同事务`
=== 掺合约定 ===
 原则::
  * 任何有力有闲的好人都可以掺合!
  * 但是要出示足够能力和诚意
 join::
  1. 订阅 http://groups.google.com/group/openbookproject 
  2. 建立本地工程环境
  3. 在列表中说明你的 docs.py_zh 本地工作环境:
   * 你的主机硬件信息,网卡MAC 值
   * 你的主机软件信息:什么OS?什么Python 版本?什么编辑环境?
   * 你的主要联系信息:邮箱?IM?主页?
   * 出示你本地的编译成果:截屏和修订章节的 diff
  4. 经过项目主持人的共同评审,确认后,就开通 http://openbookproject.googlecode.com/svn/ 权限
  
  正常开始协同翻译和维护, 前要求及时响应 列表的讨论:
   * 使用邮件标签 [docs.py]

=== 工程环境 ===
 SVN: http://openbookproject.googlecode.com/svn/trunk/docs.py_zh
{{{
目录结构 /:
+-- PyStandardLib_zh   Python 江湖群 版本 "标准模块"
+-- PyTutorial_zh  刘鑫 版本 Python 教程
  +-- 2.4  DocBook 历史版本
  +-- 2.5  DocBook 历史版本
  +-- 2.6  reST 版本 100%
  +-- 3.0  reST 版本 30%
+-- v2.6.1  reST 全站版本
  +-- build     文档编译工作目录
    (+-- doctrees  文档中间结果)~只应存在翻译者本地
    +-- html    网页输出
    +-- latex   TeX输出
    +-- text    纯文本输出
  +-- dist      文档发行目录,包含压缩文档
  +-- tools     编译工具目录)
    以上三个目录只应该存在翻译者本地
  +-- distutils 
  +-- tutorial 
  +-- ,,,
  \-- README.txt
+-- v3.0    reST 全站版本
  +-- build     文档编译工作目录
    (+-- doctrees  文档中间结果)~只应存在翻译者本地
    +-- html    网页输出
    +-- latex   TeX输出
    +-- text    纯文本输出
  (+-- dist      文档发行目录,包含压缩文档
  +-- tools     编译工具目录)
    以上两个目录只应存在翻译者本地
  +-- distutils
  +-- tutorial
  +-- ,,,
  \-- README.txt
+-- svn.ignore  SVN属性忽略文件类型聲明
\-- readme.txt  本文
}}}

解释::
 * 上述指明`只应存在翻译者本地`的目录,仅仅包含编译工具代码和编译中间结果,和翻译工程本身无关!
 * 所以,注意不要检入到SVN仓库中!
 * 当前,已经使用 SVN 的属性进行了过滤声明:
文件类型过滤 ::
 * 对想进行文件类型 提交过滤的目录进行应用
{{{
 $ svn propset svn:ignore -F svn.ignore path/to/dir
}}}
 * 参考:忽略未版本控制的条目
  * http://www.subversion.org.cn/svnbook/1.4/svn.advanced.props.special.ignore.html
== 编译约定 ==
`Python 2.6 之后启用了全新的文档组织方式,为了使翻译工程正规化，长期化，自动化，特此约定`

* 编译流程为:
{{{
本地编译
+-> 检入OBP SVN仓库
+--> 相关社区自动定期检出,即,完成发布!
}}}
* 编译方法:
 * 参考 http://wiki.woodpecker.org.cn/moin/HowToCompliePythonDocument
* 编译组织:
 # 下载相关源代码包
 # 下载相关翻译工程
 # 将源代码包中的 Doc 目录用翻译工程中的 Doc 目录替代, `注意!`
  * 翻译工程的目录如前述,没有 built/doctrees;dist;tools 三个目录;
  * 本地工程,应该从源代码包中,补足 tools 目录! 另外两个会自动生成,不用理会;-)
  * 对*inux用户来讲,最佳体验就是 将源代码目录 和 翻译工程目录 分离,使用 链接 简单的将 Doc 目录替代就好!
{{{              
Python 2.6.1   
  +- Demo       
  +- Doc < svn co <  docs.py_zh/v2.6.1/Doc
    +- ,,,             
    +- tools   {从源码包中复制}
    +- ,,,             
    +- conf.py {从源码包中复制}
    \- ,,,             
  +- Grammar 
  +- ,,,
}}}
 # 测试是否可以正常编译出HTML 页面!?
{{{
/patn/to/u/Python-2.6.1/Doc
$ make html
}}}
 # 如果可以,说明环境配置成功!
 # 如果有问题,请根据提示,清查目录情况!
* 编译协同:
 # 翻译者组织好本地编译/工作环境,开始翻译
 # 随时使用 docutils 工具来编译指定的单个页面,以便保证联编时,不会有问题;
 # 每日进行翻译,一定要:
  # svn up ~ 同步一下最新翻译成果,解决可能的冲突
  # svn ci ~ 将当日完成的工作检入SVN

   

