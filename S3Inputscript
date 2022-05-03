#Import Boto and credentials and create session, clients, and variables
from xml.sax.saxutils import quoteattr
import boto3

session = boto3.Session(profile_name='exp-qa')
s3 = session.client('s3')
s3 = session.resource('s3')

FileList = []
#Get name for Bucket
Name = input("Enter the Bucket name: ")
print (Name)

#Get info from bucket
my_bucket=s3.Bucket(Name)
size_byte = 0
for my_bucket_object in my_bucket.objects.all():
    #print(my_bucket_object.key)
    FileList.append(my_bucket_object.key)
    #print(my_bucket_object.name)
    size_byte=size_byte+my_bucket_object.size
print ("\n")
print (len(FileList))
print("\n")
print(my_bucket_object.last_modified)   
print("\n")
totalsize_gb=size_byte/1024/1024/1024
print(size_byte)
print(totalsize_gb)