#!/bin/bash

cat <<EOF | tee /etc/fahclient/config.xml
<config>
  <!-- Client Control -->
  <fold-anon v='$FOLD_ANON'/>

  <!-- Folding Slot Configuration -->
  <gpu v='false'/>

  <!-- HTTP Server -->
  <allow v='127.0.0.1 $FOLD_ALLOW_IP'/>

  <!-- Slot Control -->
  <power v='$FOLD_POWER'/>

  <!-- User Information -->
  <user v='$FOLD_USER'/>

  <!-- Web Server -->
  <web-allow v='127.0.0.1 $FOLD_ALLOW_IP'/>

  <!-- Folding Slots -->
  <slot id='0' type='CPU'/>
</config>
EOF

# Kick start folding service
/etc/init.d/FAHClient start 2> /dev/null
while [ ! -f /var/lib/fahclient/log.txt ]
do
  sleep 2 # or less like 0.2
done
tail -f /var/lib/fahclient/log.txt