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

s3 = session.resource('s3')
#initialize byte size
size_byte=0

#iterate through each bucket
#for bucket in AllBuckets['Buckets']:

my_bucket=s3.Bucket('expenterprise-uat')
for my_bucket_object in my_bucket.objects.all():
    #print(my_bucket_object.key)
    size_byte=size_byte+my_bucket_object.size
totalsize_gb=size_byte/1024/1024/1024
print(size_byte)
print(totalsize_gb)
