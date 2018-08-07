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
        if [[ $tries -ge 20 ]]; then
            echo "ERROR: attaching volumes! = `date`" >> $logfile
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

function volume_mount() {
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

# Install dependencies
zypper ar -C http://download.opensuse.org/tumbleweed/repo/oss/ Tumbleweed1
zypper --gpg-auto-import-keys refresh
zypper install -y libncurses6-6.1-6.5.x86_64 libcurl4-7.61.0-1.1.x86_64
zypper install -y glibc-2.27-6.1.x86_64 glibc-locale-2.27-6.1.x86_64 nscd-2.27-6.1.x86_64
zypper install -y liblzma5-5.2.4-1.1.x86_64 device-mapper-1.02.146-7.1.x86_64 grub2-2.02-29.1.x86_64 libparted0-3.2-21.2.x86_64 grub2-i386-pc-2.02-29.1.x86_64
zypper install -y libreadline7
zypper install -y bc curl nvme-cli mdadm

