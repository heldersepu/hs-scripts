
import sys
import bottle
import pymongo

# this is the handler for the default path of the web server

@bottle.route('/')
def index():
    item = ""
    try:
        # connect to mongoDB
        connection = pymongo.MongoClient('mongodb://test:abc123#@ds053448.mongolab.com:53448/test1')

        # attach to test database
        db = connection.test1

        # find a single document
        item = db.users.find_one()
    except:
        print sys.exc_info()[0]

    return '<b>Hello </b>' + str(item['firstname'])


bottle.run(host='localhost', port=8080)
