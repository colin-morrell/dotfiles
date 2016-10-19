#!/usr/bin/env python
import arrow
import sys
if len(sys.argv) != 2:
    exit()
print(arrow.get(sys.argv[1]).format('MMMM DD, YYYY - HH:MM:ss A'))
