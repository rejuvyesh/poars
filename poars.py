import requests
import re
import pickle
from bs4 import BeautifulSoup

url = 'http://172.26.142.65:4040/Common/CourseListing.asp'

response = requests.get(url)

soup = BeautifulSoup(response.content)
print(soup.prettify)

regex = re.compile("^[\s]+([A-Z]+[A-Z]*[0-9]+[A-Z0-9]*)[\n]", re.MULTILINE)
cont = regex.findall(soup.prettify())
pickle.dump(cont, open('sublist.p', 'wb'))
print(cont)

response.close
