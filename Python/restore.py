import os
import boto3
import sys
import json
import subprocess
from subprocess import Popen, PIPE
with open("/home/ubuntu/backup_envs.json") as f: # backup_envs.json에 있는 정보를 가져온다.
    dict = json.load(f)
    dbusername = dict['DB_USERNAME']
    host = dict['DB_HOST']
    password = dict["DB_PASSWORD"]
    databasename = dict["DB_NAME"]
    bucket_name = dict["BUCKET_NAME"]

username = 'ubuntu'
backupdir = "/home/"+username +'/downloads/'
s3 = boto3.resource('s3')
if sys.argv[1]:
 s3.meta.client.download_file(bucket_name,sys.argv[1],backupdir + sys.argv[1])
 print("download completed")
 subprocess.call('PGPASSWORD=%s psql -h %s -U %s -W -d %s < %s' % (password,host,dbusername, databasename, backupdir + sys.argv[1]), shell=True)
