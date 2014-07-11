curl http://127.0.0.1:8080/solr/status/update -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'
curl http://127.0.0.1:8080/solr/status/update -H "Content-Type: text/xml" --data-binary '<commit />'

curl http://127.0.0.1:8080/solr/status/update?commit=true -H "Content-Type: text/xml" --data-binary '<add><doc><field name="status">All OK: True</field></doc></add>'

echo "SOLR IS ONLINE"

