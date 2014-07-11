curl http://127.0.0.1:8080/solr/remaxlistings/update -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'

curl http://127.0.0.1:8080/solr/remaxlistings/update -H "Content-Type: text/xml" --data-binary '<commit />'

echo "SOLR DATA DELETED"

