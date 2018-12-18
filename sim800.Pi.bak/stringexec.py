#!/usr/bin/env python
import re

def parseString(input, regex):
    try:
        return re.search(str(regex) + '(.+)', input).group(1)
    except AttributeError:
        return ''

def writeString(filePath, content):
    with open(filePath, 'w') as file:
        file.write(content)
        file.close()