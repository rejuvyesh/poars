#!/usr/bin/env python3
# Copyright rejuvyesh <rejuvyesh@gmail.com>, 2013
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

import simplejson as json

data = open('dict.json')
js = json.load(data)
sch = []
for k in js.keys():
    sch.append(k+": "+js[k]['Schedule'])

# timesort = sorted(js, key=lambda x: (js[x]['Schedule']))
sli = []
for k in js.keys():
    sli.append(js[k]['Schedule'])

tit = []
for k in js.keys():
    tit.append(js[k]['Title'])

l = list(zip(js.keys(), sli, tit))
sl = sorted(l, key=lambda x: x[1])
print(sl)
fout = open('sorted.csv', 'wt')
fout.write("\n".join('%s,%s,%s' % x for x in sl))
