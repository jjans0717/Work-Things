#This script will grab all files in a bucket and filter them
#Last modified: Justin Jans 8/10/22


#Import Boto and credentials and create session, client, and resource
import boto3

session = boto3.Session(profile_name='exp-sandbox')
s3 = session.client('s3')