#!/usr/bin/env python
import os
import time
import json

with open("/home/ubuntu/backup_envs.json") as f: # backup_envs.json에 있는 정보를 가져온다.
    dict = json.load(f)
    dbusername = dict['DB_USERNAME']
    host = dict['DB_HOST']
    password = dict["DB_PASSWORD"]
    databasename = dict["DB_NAME"]
    bucket_name = dict["BUCKET_NAME"]

username = 'ubuntu'
port = '5432'
backupdir = "/home/"+username +'/backupfiles/'
date = time.strftime('%Y%m%d')

if not os.path.exists(backupdir):
    os.popen("sudo mkdir %s" % (backupdir))
    print("%s is created." % (backupdir))
os.popen("PGPASSWORD=%s pg_dump --clean -h %s -U %s -d %s > %s%s_%s.dump" % (password,host,dbusername, databasename, backupdir,databasename, date))
print("Backup file is created.")
