#!/usr/bin/python
import re
from sys import argv
pattern = '(?!\w)\(%d\)'
alt = 'circled_%d_delcric'

if __name__ == '__main__':
    fin = open(argv[1], 'r')
    html = fin.read()
    fin.close()
    
    html = html.replace('<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">',
                        '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">')
    for i in range(1, 10):
        html = re.sub(pattern % i, alt % i, html)
    
    fout = open(argv[1], 'w')
    fout.write(html)
    fout.close()
