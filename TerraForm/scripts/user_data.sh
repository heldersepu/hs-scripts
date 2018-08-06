echo "init `date`" >> /home/ec2-user/bin/userdata.log
# ${data}"

echo "Wait for EBS volumes to attach = `date`" >> /home/ec2-user/bin/userdata.log
tries=0
while [ ! -b /dev/nvme2n1 ] || [ ! -b /dev/nvme3n1 ] || [ ! -b /dev/nvme4n1 ]; do
  if [[ $tries -ge 10 ]]
  then
    echo "ERROR: attaching volumes! = `date`" >> /home/ec2-user/bin/userdata.log
    lsblk >> /home/ec2-user/bin/userdata.log
    exit 1;
  fi
  let "tries++"
  echo $tries
  sleep 60
done
echo "Completed in $tries tries = `date`" >> /home/ec2-user/bin/userdata.log

