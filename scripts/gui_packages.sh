#!/bin/bash

######################
#### GUI Packages ####
######################

# Workstation
sudo apt-get install -y speedcrunch
sudo snap install slack --classic
sudo apt install -y vlc
sudo apt install -y flameshot


# chromium
sudo apt-get install -y libxssl libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
rm -f google-chrome-stable_current_amd64.deb # clean up 



# Development
sudo snap install --classic code



# Entertainment
sudo snap install spotify
