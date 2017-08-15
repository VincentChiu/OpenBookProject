#!/usr/bin/env python
# coding: utf-8
import re
from html import alt

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

WIDTH = 73
circled = u'①②③④⑤⑥⑦⑧⑨'
replace = (
           # Such plethoric whitespaces exists in tables;
           # they should be removed for compactness.
           (r'(?<=\n {3}\d\.)\n\n {6}', ' '),
           # Tab only appears after (1), (2) ... and revision number;
           # they should be removed for compactness.
           (r'\t', ''),
           # The following are the tree marks;
           # I made them all indent 3 more spaces at each level.
           (r' {4}\*(?= (\d{1,2}|\w)\.)', ' ' * 3 + '*'),
           (r' {10}o(?= )', ' ' * 6 +'o'),
           (r' {16}\+', ' ' * 9 +'+'),
           # Split lines before chapters, sections and subsections;
           # Before chapters, a new line of split marks is inserted;
           # Before (sub)sections, the line before it is REPLACED by split marks for compactness
           (ur'\n( {2}(第 \d{1,2} 章|附录 \w\.) )',
             r'\n%s\n\1' % ('#' * WIDTH)),
           (r'\n\n( {4}(\d{1,2}|[A-J])\.(\d{1,2}|[A-B])\. )',
             r'\n%s\n\1' % ('=' * WIDTH)),
           (r'\n\n( {6}(\d{1,2}|\w)\.(\d|\w)\.\d\. )',
             r'\n%s\n\1' % ('-' * WIDTH)),
           )
if __name__ == '__main__':
    if len(sys.argv) != 2:
        sys.exit()
    fin = open(sys.argv[1], 'r')
    txt = fin.read()
    fin.close()
    
    for i in range(1, 10):
        txt = txt.replace(alt % i, circled[i - 1])
    
    for old, new in replace:
        txt = re.sub(old, new, txt)
    
    fout = open(sys.argv[1], 'w')
    fout.write(txt)
    fout.close()
