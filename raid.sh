#This script will do Raid on the present system

sudo apt-get install mdadm;

sudo umount -d /dev/xvdb;

lsblk;

#Check for the Number of Devices  and the device name

echo "Check for the Number of Devices  and the device name"
sudo mdadm --create --verbose /dev/md0 --level=0 --name=MY_RAID --raid-devices=2 /dev/xvdb /dev/xvdc;

sudo mkfs.ext4 -L MY_RAID /dev/md0;
sudo mkdir -p /mnt/raid;
sudo mount LABEL=MY_RAID /mnt/raid;
lsblk;
sudo chown -R ubuntu:ubuntu /mnt/raid;
#chown -R ubuntu:ubuntu /mnt/raid
#cd /mnt/raid
#sudo chown -R ubuntu:ubuntu /mnt/raid

