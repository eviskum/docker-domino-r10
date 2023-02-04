#!/bin/bash

if [ ! -d /local/notesdata ]; then
  echo "Prepare Notes Data"
  cd /
  tar -xvf /domino/notesdata.tar.gz
fi

if [ ! -f /local/notesdata/server.id ]; then
  echo "Set up server"
  su notes -c "cd /local/notesdata; /opt/ibm/domino/bin/server -listen"
else
  echo "Start Domino"
  su notes -c "cd /local/notesdata; /opt/ibm/domino/bin/server"
fi
