echo "userdata `date`" >> $logfile
# ${data}"

volumes=('/dev/nvme2n1' '/dev/nvme3n1' '/dev/nvme4n1')
attach_wait $${volumes[@]}

lsblk -o NAME,UUID,SIZE >> $logfile
echo ""  >> $logfile

volume_mount "110G" "/abc"
volume_mount "111G" "/def"
volume_mount "111G" "/ghi"

