#!/usr/bin/env python3
# Copyright rejuvyesh <rejuvyesh@gmail.com>, 2013
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

import requests
import re
import pickle
import time
import subprocess
import sys
from bs4 import BeautifulSoup
import os
url = 'http://172.26.142.66:4040/Common/CourseListing.asp'

response = requests.get(url)

soup = BeautifulSoup(response.content)

regex = re.compile("^[\s]+([A-Z]+[A-Z]*[0-9]+[A-Z0-9]*)[\n]", re.MULTILINE)
cont = regex.findall(soup.prettify())
pickle.dump(cont, open('sublist.p', 'wb'))

response.close
scrap = 'y'
obj = pickle.load(open('sublist.p', 'rb'))
if scrap == 'y':
    for i in obj:
        if os.path.isfile(i + '.html'):
            continue
        else:
            fout = open(i + ".html", "wt")
            url = "http://172.26.142.75:4040/Utils/CourseInfoPopup2.asp?Course=" + i
            time.sleep(2)
            oars = requests.get(url, timeout=1)
            soup = BeautifulSoup(oars.content)
            fout.write(oars.text)
            oars.close()
            outfile = i + ".txt"
            cmd = "elinks -dump " + i + ".html"
            with open(outfile, "w") as output_f:
                p = subprocess.Popen(cmd, stdout=output_f, shell=True)
