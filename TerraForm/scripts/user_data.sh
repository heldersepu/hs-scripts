echo "userdata `date`" >> $logfile
# ${data}"

volumes=('/dev/xvdj') # '/dev/nvme3n1' '/dev/nvme4n1')
attach_wait $${volumes[@]}

lsblk -o NAME,UUID,SIZE >> $logfile
echo ""  >> $logfile

name_mount "/dev/xvdj" "/abcd" "xfs"
# size_mount "110G" "/abc"
# size_mount "111G" "/def"
# size_mount "111G" "/ghi"

mount -a

# remove docker
sudo service docker stop
sudo ifconfig docker0 down
sudo sed -i '/docker/d' /etc/fstab
sudo umount /var/lib/docker
sudo zypper rm -y docker

