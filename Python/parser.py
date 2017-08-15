
import requests
from bs4 import BeautifulSoup
import json
import os
import codecs

# python파일의 위치
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

req = requests.get('http://cu.bgfretail.com/product/pb.do?category=product&depth2=1')
html = req.text
soup = BeautifulSoup(html, 'html.parser')

data = {}
index = 0
for tag in soup.find_all('div',{'class': "photo"}):
    # print(tag.text)
    for a_tag in tag.find_all('a'):
        for img_tag in a_tag.find_all('img'):
            src = img_tag.get('src')
            alt = img_tag.get('alt')
            index = index + 1
            data["PR%d"%index] = {"img": src}

index = 0
for tag in soup.find_all('p',{'class': "prodPrice"}):
    for span_tag in tag.find_all('span'):
        text = span_tag.text
        index = index + 1
        data["PR%d"%index]["price"] = text

index = 0
for tag in soup.find_all('p',{'class': "prodName"}):
    for a_tag in tag.find_all('a'):
        text = a_tag.text
        index = index + 1
        data["PR%d"%index]["name"] = text


with open(os.path.join(BASE_DIR, 'result.json'),'w+',encoding='utf-8') as json_file:
    json.dump(data, json_file,ensure_ascii=False)
