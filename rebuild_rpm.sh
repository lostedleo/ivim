#!/bin/bash

sudo rm -f  /var/lib/rpm/__db*
sudo rpm --rebuilddb
sudo yum clean all
