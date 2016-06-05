#!/bin/bash -eux
# Remove ansible
sudo yum -y clean all
sudo rm -rf /tmp/packer-provisioner-ansible-local

# Zero out the rest of the free space using dd, then delete the written file.
/bin/dd if=/dev/zero of=/boot/EMPTY bs=1M
/bin/rm -f /boot/EMPTY
/bin/dd if=/dev/zero of=/EMPTY bs=1M
/bin/rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
