#!/usr/bin/env python
import os
import time
import json
import boto3

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

filename = "%s%s_%s.dump" % (backupdir,databasename, date)
uploaded_filename = "%s_%s.dump" % (databasename, date)

client = boto3.client('s3')

with open(filename,'rb') as data:
 client.upload_fileobj(data,bucket_name,uploaded_filename)
