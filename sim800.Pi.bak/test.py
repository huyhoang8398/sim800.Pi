#!/usr/bin/env python
from stringexec import parseString, writeString

if __name__ == "__main__":
    a = parseString('a\n\r\tsdff\nsafchange 4 * * * 33\n\r', 'change ')
    writeString('output.txt', a)
    print(a)
    b =  parseString('a\n\r\tsdff\nsafchange * * 33\nadsfdsf', 'change ')
    writeString('output.txt', b)
    print(b)