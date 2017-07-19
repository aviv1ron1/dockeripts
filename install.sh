#!/bin/bash

cp /scripts/*.sh /usr/bin
cat .bashrc > /etc/profile.d/dockeripts.sh
chmod +x /etc/profile.d/dockeripts.sh