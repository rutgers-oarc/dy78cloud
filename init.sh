#! /bin/bash
# turn off selinux
sudo setenforce 0
sudo sed -i.bak 's/SELINUX=enforcing/SELINUX=disabled/'  /etc/sysconfig/selinux
# turn off firewall
sudo /usr/bin/systemctl disable firewalld
sudo /usr/bin/systemctl stop firewalld

# for the persitent disk
# as per https://cloud.google.com/compute/docs/disks/add-persistent-disk#formatting
# although I use /mnt/data instead of /mnt/disks/data
#####################################################
# ONLY ONCE EVER
# IF REPEATED, IT WILL DESTROY DATA
#####################################################

sudo lsblk
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
#####################################################
# ONLY ONCE DONE
# Back to normal
#####################################################

sudo mkdir -p /mnt/data
sudo mount -o discard,defaults /dev/sdb /mnt/data
sudo chmod a+w /mnt/data
sudo cp /etc/fstab /etc/fstab.backup
##  !!!!! manual step !!!!!
# lsblk
# blkid /dev/sdb
# ^ those commands give you the uuid
# add this line to /etc/fstab
# 6fe2ecf5-ef0d-4637-a379-ec57839f6a57
# UUID=[UUID_VALUE] /mnt/data ext4 discard,defaults,nofail 0 2
# umount /mnt/data
# mount /mnt/data
#### EDIT fstat ####
sudo blkid /dev/sdb

# install puppet and ophc
sudo yum -y install epel-release
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum -y install puppetserver
echo 'master=master.c.ru-tensor-time-series.internal' | sudo tee -a  /etc/puppetlabs/puppet/puppet.conf

sudo yum -y install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm
sudo yum -y install ohpc-base
sudo yum -y install ohpc-slurm-server

# server = mamaster.c.ru-tensor-time-series.internal
#sudo /usr/bin/systemctl enable ntpd.service
#sudo /usr/bin/systemctl start ntpd.service


# tweak /etc/slurm/slurm.conf

sudo yum -y install clustershell-ohpc
#cd /etc/clustershell/groups.d
# mv local.cfg local.cfg.orig
# echo "adm: ${sms_name}" > local.cfg
# echo "compute: ${compute_prefix}[1-${num_computes}]" >> local.cfg [sms]# echo "all: @adm,@compute" >> local.cfg

#sudo yum -y install ohpc-autotools
#sudo yum -y install EasyBuild-ohpc
#sudo yum -y install hwloc-ohpc
#sudo yum -y install spack-ohpc
#sudo yum -y install valgrind-ohpc
#sudo yum -y install gnu7-compilers-ohpc
#sudo yum -y install llvm5-compilers-ohpc
#sudo yum -y install ohpc-gnu7-perf-tools
#sudo yum -y install ohpc-gnu7-serial-libs
#sudo yum -y install ohpc-gnu7-io-libs
#sudo yum -y install ohpc-gnu7-python-libs
#sudo yum -y install ohpc-gnu7-runtimes


#puppet master
sudo /usr/bin/systemctl enable puppetserver.service
sudo /usr/bin/systemctl start puppetserver.service
sudo /opt/puppetlabs/bin/puppet agent -t --server=master.c.ru-tensor-time-series.internal
sudo puppet module install puppetlabs-ntp --version 7.0.0 
sudo puppet module install derdanne-nfs --version 2.0.6

sudo cp /etc/munge/munge.key /mnt/data/shared/

#####################################################
# copy the slurm.conf in mounted directory:
# vi /mnt/data/shared/slurm.conf
#####################################################
sudo systemctl start  munge
sudo systemctl start slurmctld
