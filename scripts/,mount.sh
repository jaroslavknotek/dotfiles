#!/bin/bash

disk_name=$(sudo fdisk -l | tail -n-1 | cut -d ' ' -f 1)
sudo mount $disk_name /media
