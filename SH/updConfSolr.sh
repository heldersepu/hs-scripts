clear
echo ""
echo '\033[32m UPDATING SOLR \033[0m';

echo ""
echo 'This script will update solr'
echo ' Make sure you are ready!'
echo ""

printf "Do you want to continue (Y/n): "
read INPT
if [ "$INPT" = "y" ]; then
    echo ""
    /etc/init.d/tomcat6 stop
    chmod 777 -R /solr
    /etc/init.d/tomcat6 start
    sleep 10

    echo ""
    arrSolrCores1="office"
    arrSolrCores2="remaxoffice"
    arrSolrCores3="remaxlistings"
    arrSolrCores4="remaxagent"
    arrSolrCores5="listings"
    arrSolrCores6="vowlistings"
    arrSolrCores7="status"

    for i in `seq 1 7`; do
        eval SolrCore=\${arrSolrCores${i}}
        if [ -f /solr/cores/$SolrCore/conf/solrconfig.xml ]; then
            echo " ... core $SolrCore"
            cp /solr/cores/$SolrCore/conf/solrconfig.xml /solr/cores/$SolrCore/conf/solrconfig_xml.bak
            # Update deprecated tags
            sed -i 's/BinaryUpdateRequestHandler/UpdateRequestHandler/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/XmlUpdateRequestHandler/UpdateRequestHandler/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/<mergeFactor>10</<mergeFactor>6</g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/LUCENE_40/LUCENE_41/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/replication</</g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/<str name="pollInterval">00:00:60/<str name="pollInterval">00:10:00/g' /solr/cores/$SolrCore/conf/solrconfig.xml

            # Fix: no field name specified in query and no default specified via 'df' param
            sed -i 's/<str name="df">text<\/str>//g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/<int name="rows">10/<str name="df">text<\/str><int name="rows">10/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/<str name="mlt.qf">/<str name="df">text<\/str><str name="mlt.qf">/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/<bool name="tv">true/<str name="df">text<\/str><bool name="tv">true/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/<str name="spellcheck.onlyMorePopular">false/<str name="df">text<\/str><str name="spellcheck.onlyMorePopular">false/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/<str name="echoParams">explicit<\/str>/<str name="echoParams">explicit<\/str><str name="df">text<\/str>/g' /solr/cores/$SolrCore/conf/solrconfig.xml

            # Change IP to new master
            sed -i 's/10.10.20.72/10.93.106.98/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/10.93.106.97/10.93.106.98/g' /solr/cores/$SolrCore/conf/solrconfig.xml
            sed -i 's/10.93.106.99/10.93.106.98/g' /solr/cores/$SolrCore/conf/solrconfig.xml

            # New names of the libraries
            sed -i 's/apache-solr-/solr-/g' /solr/cores/$SolrCore/conf/solrconfig.xml

            # Delete the data
            curl http://127.0.0.1:8080/solr/$SolrCore/update -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>' > /dev/null 2>&1
            curl http://127.0.0.1:8080/solr/$SolrCore/update -H "Content-Type: text/xml" --data-binary '<commit />' > /dev/null 2>&1
        fi
        if [ -f /solr/cores/$SolrCore/conf/schema.xml ]; then
            sed -i 's/<!-- catchall field  --><field name="text" type="string" indexed="false" stored="false"\/>//g' /solr/cores/$SolrCore/conf/schema.xml
            sed -i 's/<\/fields>/<!-- catchall field  --><field name="text" type="string" indexed="false" stored="false"\/><\/fields>/g' /solr/cores/$SolrCore/conf/schema.xml
        fi
        sleep 10
    done

    echo ""

    echo " upgrading solr "
    rm -R ~/solr_old/
    mkdir ~/solr_old
    rm -R ~/solr_new/
    mkdir ~/solr_new
    sleep 2
    cp /var/lib/tomcat6/webapps/solr.war ~/solr_old/
    curl -u tomcat:s3cret! "http://localhost:8080/manager/undeploy?path=/solr"
    wget -P ~/solr_new/ http://hs-scripts.googlecode.com/files/solr-4.2-SNAPSHOT.war
    wget -P ~/solr_new/ http://hs-scripts.googlecode.com/files/solr-4.2-SNAPSHOT.tar
    /etc/init.d/tomcat6 stop
    sleep 2
    rm -R /solr/dist
    tar xf ~/solr_new/solr-4.2-SNAPSHOT.tar -C /solr/
    sleep 2
    chmod 777 -R /solr
    cp -P ~/solr_new/solr-4.2-SNAPSHOT.war /var/lib/tomcat6/webapps/solr.war
    /etc/init.d/tomcat6 restart
    sleep 10

    echo ""
    sysctl vm.swappiness=10
    swapWord=$(cat /etc/sysctl.conf | grep -wo 'swappiness')
    wordCount=$(echo "$swapWord" | wc -l)
    if [ $wordCount = 0 ]; then
        echo '#' >> /etc/sysctl.conf
        echo 'vm.swappiness=10' >> /etc/sysctl.conf
    fi

    /etc/init.d/tomcat6 stop
    chmod 777 -R /solr
    /etc/init.d/tomcat6 start
    sleep 10

    echo ""
    echo " Disable polling on all cores"
    for i in `seq 1 7`; do
        eval SolrCore=\${arrSolrCores${i}}
        if [ -f /solr/cores/$SolrCore/conf/solrconfig.xml ]; then
            curl http://127.0.0.1:8080/solr/$SolrCore/replication?command=disablepoll  > /dev/null 2>&1
        fi
    done

    echo ""
    echo '\033[32m SOLR UPDATED \033[0m';
    echo ""

else
    clear
fi

tput sgr0
