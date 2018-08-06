#!/bin/bash
echo "init `date`" >> /home/ec2-user/bin/userdata.log

function volume_mount() {
    dsize=$1;  dmount=$2;
    if [ $(cat /etc/fstab | grep -c "$dmount ext4") == 0 ]
    then
        DNAME=$(lsblk -o NAME,SIZE -x NAME | grep "$dsize" | awk '{print $1}')
        DUUID=$(blkid | grep $DNAME | awk '{print $2}' | tr -d '"')
        #yes | mkfs -t ext4 /dev/$DNAME
        #mkdir -p $dmount
        #echo "$DUUID $dmount ext4 defaults,nofail 0 2" >> /etc/fstab
    fi
}

