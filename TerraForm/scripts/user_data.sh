echo "userdata `date`" >> $logfile
# ${data}"

echo "Wait for EBS volumes to attach = `date`" >> $logfile
tries=0
while [ ! -b /dev/nvme2n1 ] || [ ! -b /dev/nvme3n1 ] || [ ! -b /dev/nvme4n1 ]; do
  if [[ $tries -ge 10 ]]
  then
    echo "ERROR: attaching volumes! = `date`" >> $logfile
    lsblk >> $logfile
    exit 1;
  fi
  let "tries++"
  echo $tries
  sleep 60
done
echo "Completed in $tries tries = `date`" >> $logfile

lsblk -o NAME,UUID,SIZE >> $logfile
echo ""  >> $logfile

volume_mount "110G" "/abc"
volume_mount "111G" "/def"
volume_mount "111G" "/ghi"

