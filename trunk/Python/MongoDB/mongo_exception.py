
import sys
import pymongo

connection = pymongo.MongoClient("mongodb://test:abc123#@ds053448.mongolab.com:53448/test1")

db = connection.test1
users = db.users

doc = {'firstname':'Andrew', 'lastname':'Erlichson'}
db.users.insert(doc)

print doc
print "inserting again"

try:
    users.insert(doc)
except:
    print "second insert failed:", sys.exc_info()[0]

print doc

