#!/bin/sh

HOSTS_FILE_PATH=/etc/hosts

update_etc_hosts () {
  HOST_STRING=$1

  # Update the /etc/hosts if not already updated
  if grep -q "$HOST_STRING" $HOSTS_FILE_PATH; then
    echo "don't update $HOSTS_FILE_PATH"
  else
    echo "update $HOSTS_FILE_PATH"

    echo "\n\n--- --- VAGRANT CONFIGURATION --- ---" >> $HOSTS_FILE_PATH
    echo $HOST_STRING >> $HOSTS_FILE_PATH
  fi
} 

update_etc_hosts "192.168.33.10 webserver.local.vm"