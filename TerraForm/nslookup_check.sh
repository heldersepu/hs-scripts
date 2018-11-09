if [ "${nslookup_record}" != "" ]; then
    tries=0
    while true; do
    if [[ $tries -ge 30 ]]; then
        echo "ERROR !"
        exit 1;
    elif [[ $(nslookup ${nslookup_record} | egrep -c "(can't find|timed out)") == 0 ]]; then
        echo "GOOD TO GO"
        exit 0;
    fi
    let "tries++"
    echo "Invalid response, will try again in 10 seconds. ($tries/30)"
    sleep 10
    done
fi