import pymongo

connection = pymongo.MongoClient('mongodb://localhost:27017')
db = connection.students
lastDoc = None
for doc in db.grades.find({"type": "homework"}).sort(
        [('student_id', pymongo.ASCENDING), ('score', pymongo.DESCENDING)]):
    if not lastDoc is None:
        if lastDoc['student_id'] != doc['student_id']:
            db.grades.remove({'_id': lastDoc['_id']})
    lastDoc = doc
