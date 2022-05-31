#This script pulls all s3 bucket names and sizes and outputs to csv file
#Still a Work in Progress
#Last modified: Justin Jans 5/3/2022


#Import Boto and credentials and create session, and client
from xml.sax.saxutils import quoteattr
import boto3

session = boto3.Session(profile_name='exp-qa')
s3 = session.client('s3')
s3resource = session.resource('s3')

#Define Variables
NameList = []
SizeList = []
LastModified = []

#Get list of all buckets
AllBuckets = s3.list_buckets()

#Output buckets
print('Existing buckets:')
for bucket in AllBuckets['Buckets']:
    #print(f'    {bucket["Name"]}')
    #Append Names into NameList
    NameList.append(bucket["Name"])
    #Iterate through names to get size and last modified date
    size_byte = 0
    for my_bucket_object in NameList:
        #Print statements are sanity checkes to make sure info is right
        print("\n")
        print(my_bucket_object)
        print("\n")
        size_byte=size_byte+my_bucket_object.size
        totalsize_gb=size_byte/1024/1024/1024
    print("\n")
    print(my_bucket_object.last_modified)   
    print("\n")
    #print(size_byte)
    print(totalsize_gb)

#Old code parts - remove later

#print(f'    {NameList}')



#Initialize S3 resource
#s3 = session.resource('s3')

#initialize byte size
#size_byte=0

#iterate through each bucket
#for bucket in AllBuckets['Buckets']:

#my_bucket=s3.Bucket('qa-myexp')
#for my_bucket_object in my_bucket.objects.all():
#    print("\n")
#    print(my_bucket_object.key)
#    print("\n")
#    #print(my_bucket_object.name)
#    size_byte=size_byte+my_bucket_object.size
#    totalsize_gb=size_byte/1024/1024/1024
#print("\n")
#print(my_bucket_object.last_modified)   
#print("\n")
#print(size_byte)
#print(totalsize_gb)
