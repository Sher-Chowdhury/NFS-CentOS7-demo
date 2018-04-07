#!/usr/bin/env bash
# exit 0
set -ex

echo '##########################################################################'
echo '############### About to run nfs_client_setup.sh script ##################'
echo '##########################################################################'


mkdir -p /mnt/backups
mkdir -p /mnt/ref_data

# showmount -e 10.0.6.10

echo '10.0.6.10:/nfs/export_ro   /mnt/ref_data   nfs   soft,timeo=100,_netdev,ro   0   0' >> /etc/fstab
echo '10.0.6.10:/nfs/export_rw   /mnt/backups    nfs   soft,timeo=100,_netdev,rw   0   0' >> /etc/fstab

mount -a

# some commands to check if nfs exports have been successfully mounted
mount 
df -h

exit 0