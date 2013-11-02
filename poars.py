#!/usr/bin/env python3
# Copyright rejuvyesh <rejuvyesh@gmail.com>, 2013
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

import requests
import re
import pickle
import time
from subprocess import call
from bs4 import BeautifulSoup
import os
url = 'http://172.26.142.66:4040/Common/CourseListing.asp'

response = requests.get(url)

soup = BeautifulSoup(response.content)
print(soup.prettify)

regex = re.compile("^[\s]+([A-Z]+[A-Z]*[0-9]+[A-Z0-9]*)[\n]", re.MULTILINE)
cont = regex.findall(soup.prettify())
pickle.dump(cont, open('sublist.p', 'wb'))
print(cont)

response.close
scrap = 'n'
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

            print((type(soup.prettify)))
            fout.write(oars.text)
            oars.close

            if call("elinks -dump " + i + ".html" + ">" + i + ".txt", shell=True) == 0:
                call("rm -f " + i + ".html", shell=True)
            else:
                print(i)
