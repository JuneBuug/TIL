#!/usr/bin/env python
import os
import time
import json
import boto3

def upload_to_s3(filename,uploaded_filename):
    s3 = boto3.client('s3')
    try:
        s3.upload_file(filename,bucket_name,uploaded_filename)
    except:
        print("Error while uploading %s to S3" % (filename))
    else:
        os.popen("sudo rm -rf %s" % (filename))
        # 만약 업로드를 성공하면 로컬에 있던 백업파일은 지운다.

if __name__ == "__main__":
    with open("/home/ubuntu/backup_envs.json") as f: # backup_envs.json에 있는 정보를 가져온다.
            dict = json.load(f)
            dbusername = dict['DB_USERNAME']
            host = dict['DB_HOST']
            password = dict["DB_PASSWORD"]
            databasename = dict["DB_NAME"]
            bucket_name = dict["BUCKET_NAME"]

    username = 'ubuntu'
    port = '5432'
    backupdir = "/home/"+username +'/backup/'
    date = time.strftime('%Y%m%d_%H:%M:%S')

    if not os.path.exists(backupdir):
            os.popen("sudo mkdir %s" % (backupdir))
            print("%s is created." % (backupdir))
    os.popen("PGPASSWORD=%s pg_dump -h %s -U %s -d %s > %s%s_%s.back" % (password,host,dbusername, databasename, backupdir,databasename, date))
    os.popen("PGPASSWORD=%s pg_dump -Fc -h %s -U %s -d %s > %s%s_%s.backup" % (password,host,dbusername, databasename, backupdir,databasename, date))


    filename = "%s%s_%s.backup" % (backupdir,databasename, date)
    uploaded_filename = "%s_%s.backup" % (databasename, date)

    filename2 = "%s%s_%s.back" % (backupdir, databasename, date)
    uploaded_filename2 = "%s_%s.back" % (databasename, date)

    upload_to_s3(filename,uploaded_filename)
    upload_to_s3(filename2,uploaded_filename2)
