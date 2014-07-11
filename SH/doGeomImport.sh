clear

id=0
runImport="true"
while [ "$runImport" = "true" ]
do

    echo ""
    echo "\033[32m  ---  startid=$id  ---  \033[0m";
    echo ""
    # Do a full Import of geom from SQL
    curl "http://127.0.0.1:8080/solr/geom/dataimport?command=full-import&entity=getGEOM_zip&clean=false&startid=$id"

    # Pause until import finishes
    count=0
    keyWord="busy"
    while [ "$keyWord" = "busy" ]
    do        
        echo ""
        echo "\033[31m  $keyWord : $count  \033[0m";
        sleep 30
        count=`expr $count + 1`
        keyWord=$(curl 'http://127.0.0.1:8080/solr/geom/dataimport' | grep -wo 'busy')
    done
    
    if [ $count -le 2 ]; then
        runImport="false"
    else
        sleep 5
        id=`expr $id + 1000`
    fi
done

echo "GEOM FULL UPDATE COMPLETED"
