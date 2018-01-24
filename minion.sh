#! /bin/bash
# turn off selinux
sudo setenforce 0
sudo sed -i.bak 's/SELINUX=enforcing/SELINUX=disabled/'  /etc/sysconfig/selinux
# turn off firewall
sudo /usr/bin/systemctl disable firewalld
sudo /usr/bin/systemctl stop firewalld
# install puppet
sudo yum -y install epel-release
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum -y install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm
sudo yum -y install puppet-agent
echo '10.142.0.2 master.c.ru-tensor-time-series.internal master puppet' | sudo tee -a /etc/hosts
#echo 'master='master.c.ru-tensor-time-series.internal'' | sudo tee -a  /etc/puppet/puppet.conf
echo 'master=master.c.ru-tensor-time-series.internal' | sudo tee -a  /etc/puppetlabs/puppet/puppet.conf
sudo /opt/puppetlabs/bin/puppet agent -t



