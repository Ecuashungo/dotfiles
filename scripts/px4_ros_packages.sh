#!/bin/bash

##################################
#### PX4 and ROS2 Development ####
##################################

# PX4 installation script

wget https://raw.githubusercontent.com/PX4/PX4-Autopilot/main/Tools/setup/ubuntu.sh
chmod +x ubuntu.sh
rm -f ubuntu.sh

# QGroundControl
sudo apt install libfuse2

sudo usermod -a -G dialout $USER
sudo apt-get remove modemmanager

# execute get_daily_qgc
~/dotfiles/scripts/get_daily_qgc.sh

## ROS2 Humble installation
###########################

# Locale Settings
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Sources Setup
sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt install software-properties-common
sudo add-apt-repository universe

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS2
sudo apt update
sudo apt upgrade

sudo apt install ros-humble-desktop-full
sudo apt install ros-dev-tools

