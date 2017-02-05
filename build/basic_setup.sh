#!/bin/sh

# This is UBUNTU SPECIFIC setup script. The script performs the basic minimal
# setup and prepares the machine to be provisioned by puppet. Anything not
# related to puppet installation SHOULD NOT BE PART OF THIS SCRIPT.

APT_PUPPETLABS_URL='https://apt.puppetlabs.com/'
PUPPETLABS_RELEASE='puppetlabs-release-pc1-xenial.deb'
VBOX_ISO='VBoxGuestAdditions.iso'

sudo apt-get update
sudo apt-get dist-upgrade

# Fix invalid locale setting in Ubuntu
echo LC_ALL=\"en_US.UTF-8\" | sudo tee --append /etc/environment

# Remove existing puppet, which is probably old
sudo apt-get purge --auto-remove puppet -y
sudo rm -rf /etc/puppet/

# Download Puppet Release package for Ubuntu 16.04
# This link should be changed when we move to the next version of Ubuntu.
wget $APT_PUPPETLABS_URL$PUPPETLABS_RELEASE
sudo dpkg -i $PUPPETLABS_RELEASE

# Update Apt's source list to pick up the latest & greatest Puppet packages.
sudo apt-get update -y

# Install Puppet.
sudo apt-get install puppet-agent -y

# Create symlinks of puppet, facter and hiera
sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
sudo ln -s /opt/puppetlabs/bin/facter /usr/bin/facter
sudo ln -s /opt/puppetlabs/bin/hiera /usr/bin/hiera

# Disable startup script added by puppet installation. These should be disabled 
# when running puppet in cluster mode.
sudo update-rc.d mcollective disable
sudo update-rc.d puppet disable
sudo update-rc.d pxp-agent disable

# Clean-up
rm $PUPPETLABS_RELEASE
# Machines created with virtualbox .ovf have this file created
if [ -f $VBOX_ISO ]; then
  rm $VBOX_ISO
fi
