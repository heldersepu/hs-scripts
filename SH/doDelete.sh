clear
echo ""
echo '\033[31m This script will delete data from solr! \033[0m';
echo '    Make sure you are ready...'
echo ""

printf " Do you want to continue (Y/n): "
read INPT
if [ "$INPT" = "y" ]; then
    echo ""
    # curl http://127.0.0.1:8080/solr/remaxlistings/update -H "Content-Type: text/xml" --data-binary '<delete><query>listingsourceid:15</query></delete>'
    # curl http://127.0.0.1:8080/solr/remaxlistings/update -H "Content-Type: text/xml" --data-binary '<delete><query>listingsourceid:19</query></delete>'
    # curl http://127.0.0.1:8080/solr/remaxlistings/update -H "Content-Type: text/xml" --data-binary '<delete><query>listingsourceid:106</query></delete>'
    curl http://127.0.0.1:8080/solr/remaxlistings/update -H "Content-Type: text/xml" --data-binary '<delete><query>active:0</query></delete>'
    curl http://127.0.0.1:8080/solr/remaxlistings/update -H "Content-Type: text/xml" --data-binary '<commit />'
fi
echo ""
tput sgr0
