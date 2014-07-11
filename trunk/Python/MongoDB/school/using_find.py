
import pymongo
import sys

# establish a connection to the database
connection = pymongo.Connection("mongodb://test:abc123#@ds029797.mongolab.com:29797/school", safe=True)

# get a handle to the school database
db = connection.school
scores = db.scores


def find():
    print "find, reporting for duty"
    query = {'type':'exam', 'score':{'$gt':98}}
    fields = {'_id':0}

    try:
        cursor = scores.find(query, fields).limit(10)
    except:
        print "Unexpected error:", sys.exc_info()[0]

    sanity = 0
    for doc in cursor:
        print doc
        sanity += 1
        if (sanity > 10):
            break


def find_one():
    print "find one, reporting for duty"
    query = {'student_id':10}

    try:
        doc = scores.find_one(query)
    except:
        print "Unexpected error:", sys.exc_info()[0]

    print doc


find()

