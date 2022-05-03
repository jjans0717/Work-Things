#This script pulls all s3 bucket names and sizes and outputs to csv file
#Still a Work in Progress
#Last modified: Justin Jans 4/29/2012


#Import Boto and credentials and create session, client, and resource
from xml.sax.saxutils import quoteattr
import boto3

session = boto3.Session(profile_name='exp-qa')
s3 = session.client('s3')


#Get list of all buckets
AllBuckets = s3.list_buckets()

#Output buckets
print('Existing buckets:')
for bucket in AllBuckets['Buckets']:
    print(f'    {bucket["Name"]}')
