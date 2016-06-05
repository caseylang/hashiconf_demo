#!/bin/bash -eux
# Install EPEL repository.
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh epel-release-latest-6.noarch.rpm

# Install Ansible.
yum -y install ansible
