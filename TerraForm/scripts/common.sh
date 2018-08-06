function volume_id() {

}

function volume_mount() {
    if [ $(cat /etc/fstab | grep -c '$2 $1') == 0 ]
    then
        DNAME=$(lsblk -o NAME,SIZE -x NAME | grep '1G' | awk '{print $1}')
        echo "volume $DNAME = `date`" >> /home/ec2-user/bin/userdata.log
        mkfs -t $1 /dev/$DNAME
        mkdir -p $2
        echo "/dev/$DNAME $2 $1 defaults,nofail 0 2" >> /etc/fstab
    fi
}
