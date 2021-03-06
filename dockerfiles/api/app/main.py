#This file is auto-generated. See modules.json and autogenerator.py for details

#!/usr/bin/python3

"""
    get_allpages.py
    MediaWiki API Demos
    Demo of `Allpages` module: Get all pages whose title contains the text
    "Jungle," in whole or part.
    MIT License
"""

from flask import Flask, render_template
import os
import requests

app = Flask(__name__)

@app.route("/")
def get_jobs():
    page_list = []
    S = requests.Session()

    URL = os.getenv('URL')
    API_URL = os.getenv('API_URL')
    
    PARAMS = {
        "action": "query",
        "format": "json",
        "list": "allpages",
         "aplimit": "max",
    }
    
    R = S.get(url=API_URL, params=PARAMS)
    DATA = R.json()
    
    PAGES = DATA["query"]["allpages"]
    
    for page in PAGES:
      #  print(page["title"])
        page_list.append(page["title"])
    return render_template('lista.html',URL=URL,page_list=page_list)
app.run(host='0.0.0.0',port=80)
