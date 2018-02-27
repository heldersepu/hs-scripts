clear
# Disable replication
curl "http://127.0.0.1:8080/solr/remaxagent/replication?command=disablereplication"
sleep 30

# Delete the data
curl http://127.0.0.1:8080/solr/remaxagent/update -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'
curl http://127.0.0.1:8080/solr/remaxagent/update -H "Content-Type: text/xml" --data-binary '<commit />'
curl http://127.0.0.1:8080/solr/remaxagent/update -H "Content-Type: text/xml" --data-binary '<optimize />'
echo - - - - - - - - - - - -

# Do a full Import of agents from SQL
curl "http://127.0.0.1:8080/solr/remaxagent/dataimport?command=full-import&entity=getListingAgents_Full"

# Pause until import finishes
keyWord="busy"
while [ "$keyWord" = "busy" ]
do
    echo $keyWord
    sleep 30
    keyWord=$(curl 'http://127.0.0.1:8080/solr/remaxagent/dataimport' | grep -wo 'busy')
done
sleep 30

# Enable replication
curl "http://127.0.0.1:8080/solr/remaxagent/replication?command=enablereplication"

echo "AGENT FULL UPDATE COMPLETED"
