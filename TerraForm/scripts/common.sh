#!/bin/bash
logfile='/home/ec2-user/bin/userdata.log'
echo "init `date`" >> $logfile

function bin_exists() {
    arr=("$@")
    for i in $${arr[@]}; do
        if [[ ! -b $i ]]; then return; fi
    done
    echo OK
}

function attach_wait() {
    echo "Wait for EBS volumes to attach = `date`" >> $logfile
    listblock=$(lsblk)
    tries=0
    while [ ! $(bin_exists $@) ]; do
        if [[ $tries -ge 30 ]]; then
            echo "ERROR ATTACHING VOLUMES! = `date`" >> $logfile
            lsblk >> $logfile
            exit 1;
        elif [[ $listblock != $(lsblk) ]]; then
            listblock=$(lsblk)
            tries=0
        fi
        let "tries++"
        echo $tries
        sleep 60
    done
    echo "Completed in $tries tries = `date`" >> $logfile
}

function size_mount() {
    dsize=$1;  dmount=$2;
    if [ $(cat /etc/fstab | grep -c "$dmount ext4") == 0 ]
    then
        DNAME=$(lsblk -o NAME,SIZE -x NAME | grep "$dsize" | awk '{print $1}')
        echo "volume $DNAME = `date`" >> $logfile
        yes | mkfs -t ext4 /dev/$DNAME
        mkdir -p $dmount
        DUUID=$(lsblk -o UUID,SIZE -x NAME | grep "$dsize" | awk '{print $1}')
        echo "UUID=$DUUID $dmount ext4 defaults,nofail 0 2" >> /etc/fstab
    fi
}

function name_mount() {
    vname=$1;  dmount=$2;  dtype=$3;
    if [ $(cat /etc/fstab | grep -c "$dmount $dtype") == 0 ]
    then
        echo "volume $vname = `date`" >> $logfile
        yes | mkfs -t $dtype $vname
        mkdir -p $dmount
        echo "$vname $dmount $dtype defaults,nofail 0 2" >> /etc/fstab
    fi
}

function efs_mount() {
    if [ $(cat /etc/fstab | grep -c "$2 nfs") == 0 ]
    then
        mkdir -p $2
        echo "$1 $2 nfs nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 2" >> /etc/fstab
    fi
}

echo "Installing dependencies `date`" >> $logfile
zypper install -y mdadm libncurses6-6.1-6.5.x86_64 libcurl4-7.61.0-1.1.x86_64
zypper install -y glibc-2.27-6.1.x86_64 glibc-locale-2.27-6.1.x86_64 nscd-2.27-6.1.x86_64
zypper install -y device-mapper-1.02.146-7.1.x86_64 grub2-2.02-31.1.x86_64 libparted0-3.2-22.1.x86_64 grub2-i386-pc-2.02-31.1.x86_64
zypper install -y libreadline7 liblzma5-5.2.4-1.1.x86_64
zypper install -y bc curl
zypper install -y nvme-cli
zypper install -y --replacefiles gdbm-lang-1.14.1-1.5.noarch
zypper install -y xfsprogs xfsdump
echo "Dependencies installed `date`" >> $logfile

echo 1 > sudo tee /sys/module/xfs/parameters/allow_unsupported

