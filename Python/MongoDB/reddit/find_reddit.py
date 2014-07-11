import pymongo
import sys

# establish a connection to the database
connection = pymongo.Connection("mongodb://test:abc123#@dbh23.mongolab.com:27237/reddit", safe=True)
db = connection.reddit

def find():
    print "find, reporting for duty"
    query = {'title':{'$regex':'a'}}
    query = {'media.oembed.type':'video'}
    fields = {'title':1, 'media.oembed.url':1, '_id':0}

    try:
        cursor = db.stories.find(query, fields).limit(10)
    except:
        print "Unexpected error:", sys.exc_info()[0]

    for doc in cursor:
        print doc

find()

