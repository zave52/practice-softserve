#!/bin/bash

ssh vagrant@192.168.56.20 -t mkdir backup

scp -r . vagrant@192.168.56.20:/home/vagrant/backup
