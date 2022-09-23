#! /bin/bash

# ##############################################################################
# Uninstall Non-Essential Pre-Packaged Programs
sudo apt-get -y purge \
  gnome-games \
  aisleriot \
  gnome-mahjongg \
  gnome-mines \
  gnome-sudoku
sudo apt-get -y purge \
  simple-scan \
  gnome-todo

#sudo apt purge rhythmbox rhythmbox-data rhythmbox-plugin-alternative-toolbar rhythmbox-plugins
#sudo apt purge remmina remmina-common remmina-plugin-rdp remmina-plugin-secret remmina-plugin-vnc

sudo apt-get -y purge \
  thunderbird \
  thunderbird-locale-en \
  thunderbird-gnome-support \
  thunderbird-locale-en-us

sudo apt -y autoremove