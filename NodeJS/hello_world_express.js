var express = require('express'),
    app = express(),
    cons = require('consolidate'),
    MongoClient = require('mongodb').MongoClient,
    Server = require('mongodb').Server;

app.engine('html', cons.swig);
app.set('view engine', 'html');
app.set('views', __dirname + '/views');

var mongoclient = new MongoClient(new Server("ds029797.mongolab.com", 29797, {auto_reconnect : true}));
var db = mongoclient.db('school');

app.get('/', function(req, res){
    var query = {};
	var rID = req.query.id;
	if (!isNaN(rID)){
		query = {"_id":Number(rID)};
	}
	// Find one document in our collection
    db.collection('students').findOne(query, function(err, doc) {
        if(err) throw err;
        res.render('hello', doc);
    });
});

app.get('*', function(req, res){
    res.send('Page Not Found', 404);
});

db.open(function(err, client) {
    if(err) throw err;
	client.authenticate('test', 'abc123#', function(err, success) {
		if(err) throw err;
		app.listen(8080);
		console.log('Express server started on port 8080');
	});
});
