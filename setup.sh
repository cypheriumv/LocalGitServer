#!/bin/bash

# Ensure the /run/sshd directory exists
mkdir -p /run/sshd

# Add git user and set up SSH
useradd -m -d /home/Antonia-Angela-Hatem-Attieh Antonia-Angela-Hatem-Attieh
mkdir -p /home/Antonia-Angela-Hatem-Attieh/.ssh

# Copy the SSH public key if it exists
if [ -f /git-svr/keys/id_rsa.pub ]; then
  cp /git-svr/keys/id_rsa.pub /home/Antonia-Angela-Hatem-Attieh/.ssh/authorized_keys
  chown -R Antonia-Angela-Hatem-Attieh:Antonia-Angela-Hatem-Attieh /home/Antonia-Angela-Hatem-Attieh/.ssh
  chmod 700 /home/Antonia-Angela-Hatem-Attieh/.ssh
  chmod 600 /home/Antonia-Angela-Hatem-Attieh/.ssh/authorized_keys
else
  echo "Public key not found. Make sure /git-svr/keys/id_rsa.pub exists."
fi

# Update SSH configuration
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Start SSH service
/usr/sbin/sshd -D
