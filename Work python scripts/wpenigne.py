import requests
import os

url = "https://api.wpengineapi.com/v1/installs?limit=10"

response = requests.get(url,
    auth=requests.auth.HTTPBasicAuth(
    os.environ['WPENGINE_USER_ID'],
    os.environ['WPENGINE_PASSWORD']))

print(response.text)
