import pymongo

connection = pymongo.MongoClient('mongodb://test:abc123#@ds029797.mongolab.com:29797/school')
db = connection.school
lastDoc = None

print "starting"
docs = db.students.find({"scores.type": "homework"})
#docs = db.students.find({"_id": 105})
for doc in docs:
    scores = doc["scores"]
    minScore = 9999
    x = -1
    count = 0
    for i in range(len(scores)):
        score = scores[i]
        if score["type"] == "homework":
            if score["score"] < minScore:
                minScore = score["score"]
                x = i
                print score["score"]
            count += 1
    if x != -1:
        if count > 1:
            print doc["_id"]
            print scores[x]
            db.students.update({"_id": doc["_id"]}, {"$pull": {"scores": scores[x]}})
            # db.students.remove({'_id': lastDoc['_id']})

print "ended"