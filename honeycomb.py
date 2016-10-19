#!/usr/bin/python
import sys
import re
stdin = sys.stdin.read()
data = re.findall('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+', stdin)
for url in data:
  print url.split(';')[0].split('&')[0]
