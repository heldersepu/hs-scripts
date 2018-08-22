echo "userdata `date`" >> $logfile
# ${data}"

volumes=('/dev/xvdj' '/dev/xvdk' '/dev/xvdl') # '/dev/nvme3n1' '/dev/nvme4n1')
attach_wait $${volumes[@]}

lsblk -o NAME,UUID,SIZE >> $logfile
echo ""  >> $logfile


name_mount "/dev/xvdj" "/abcd" "xfs"
# size_mount "110G" "/abc"
# size_mount "111G" "/def"
# size_mount "111G" "/ghi"

if [ $(cat /etc/fstab | grep -c '/mana/data xfs') == 0 ]; then
  if [ -b /dev/xvdl ] && [ -b /dev/xvdk ]; then
    dd if=/dev/zero of=/dev/xvdl bs=512  count=1
    dd if=/dev/zero of=/dev/xvdk bs=512  count=1
    yes | mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/xvdl /dev/xvdk
    # save raid configuration to file
    mkdir -p /etc/mdadm
    mdadm --detail --scan | tee -a /etc/mdadm/mdadm.conf
    dracut -H -f /boot/initramfs-$(uname -r).img $(uname -r)

    mkfs -t ext4 /dev/md0
    mkdir -p /mana/data
    echo "/dev/md0 /mana/data ext4 defaults,nofail 0 2" >> /etc/fstab
  fi
fi

# efs_mount "${efs_url}:/data" "/data"

mount -a

# remove docker
sudo service docker stop
sudo ifconfig docker0 down
sudo sed -i '/docker/d' /etc/fstab
sudo umount /var/lib/docker
sudo zypper rm -y docker

