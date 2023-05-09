#! /bin/bash

# Software License Agreement (MIT License)
# Copyright (c) 2022, The Ohio State University
# The Artificially Intelligent Manufacturing Systems Lab (AIMS)
#
# Author:   A.C. Buynak
# InfO:		This installer will setup ROS on an Ubuntu OS machine and 
#			is provided to end-users at no cost under the the MIT license.


## One-Point Control
MY_OSTYPE="linux-gnu"
MY_OS="Ubuntu"
MY_VER="22.04"
MY_ROS_DISTRO="humble"


## Support Methods
install_system_tools() {
	# Install System Tools & Libraries 
	sudo apt-get install -y software-properties-common
	sudo apt-get install -y curl
  	sudo apt-get install -y gnupg2
  	sudo apt-get install -y lsb-release
	sudo apt-get install -y git
	sudo apt-get install -y tree
	sudo apt-get install -y build-essential
	sudo apt-get install -y libfontconfig1
	sudo apt-get install -y mesa-common-dev
	sudo apt-get install -y libglu1-mesa-dev

	# Useful Dev Apps
	sudo apt-get install -y meld
	sudo apt-get install -y terminator
}


check_os() {

	# Check OS Family
	if [[ "$OSTYPE" == "$MY_OSTYPE" ]];
	    then printf "  Detected OS Family:     $OSTYPE \\n"
	else
	    printf "  Detected OS is NOT linux. Stopping install prep.\\n"
	    exit
	fi


	# Check for Linux Distribution
	if [ -f /etc/os-release ]; then
	    # freedesktop.org and systemd
	    . /etc/os-release
	    OS=$NAME
	    VER=$VERSION_ID
	elif type lsb_release >/dev/null 2>&1; then
	    # linuxbase.org
	    OS=$(lsb_release -si)
	    VER=$(lsb_release -sr)
	elif [ -f /etc/lsb-release ]; then
	    # For some versions of Debian/Ubuntu without lsb_release command
	    . /etc/lsb-release
	    OS=$DISTRIB_ID
	    VER=$DISTRIB_RELEASE
	elif [ -f /etc/debian_version ]; then
	    # Older Debian/Ubuntu/etc.
	    OS=Debian
	    VER=$(cat /etc/debian_version)
	elif [ -f /etc/SuSe-release ]; then
	    # Older SuSE/etc.
	    ...
	elif [ -f /etc/redhat-release ]; then
	    # Older Red Hat, CentOS, etc.
	    ...
	else
	    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
	    OS=$(uname -s)
	    VER=$(uname -r)
	fi

	printf "  Detected Linux Distro:  ${COLOR_G}$OS ${COLOR_NC}\\n"
	printf "  Detected Linux Version: ${COLOR_G}$VER ${COLOR_NC}\\n"


	# Script only valid for Ubuntu
	if [[ "$OS" != "$MY_OS" && "$VER" != "$MY_VER" ]]; then
	    printf "  Detected OS is NOT $MY_OS $MY_VER. Stopping install prep.\\n  This script is designed specifically for ${COLOR_G}$MY_OS $MY_VER ${COLOR_NC}"
	fi
}


setup_ros_source() {
	printf "  Setting upstream ROS 2 source:\\n"

	# Pull ROS Keyring
	sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

	# Add repository to apt sources list
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

	# Update Sources
	sudo apt-get update
	sudo apt update
}



install_ros2() {

	# Full Desktop Install. Ref https://ros.org/reps/rep-2001.html
	sudo apt-get install -y ros-$MY_ROS_DISTRO-desktop-full

	# Developer Help
	sudo apt-get install -y python3-colcon-common-extensions
	sudo apt-get install -y python3-argcomplete
	
	sudo apt-get install -y ros-$MY_ROS_DISTRO-xacro
	sudo apt-get install -y ros-$MY_ROS_DISTRO-moveit
	sudo apt-get install -y ros-$MY_ROS_DISTRO-octomap-ros
	sudo apt-get install -y ros-$MY_ROS_DISTRO-testing


	sudo apt-get install -y ros-$MY_ROS_DISTRO-image-publisher
	sudo apt-get install -y ros-$MY_ROS_DISTRO-realsense2-camera
	sudo apt-get install -y ros-$MY_ROS_DISTRO-realsense2-description

	sudo apt-get install -y ros-$MY_ROS_DISTRO-ros-industrial-cmake-boilerplate
	sudo apt-get install -y ros-$MY_ROS_DISTRO-ros1-bridge
	  
	sudo apt-get install -y ros-$MY_ROS_DISTRO-ros2-control
	sudo apt-get install -y ros-$MY_ROS_DISTRO-ros2-controllers
	sudo apt-get install -y ros-$MY_ROS_DISTRO-joint-state-publisher
	sudo apt-get install -y ros-$MY_ROS_DISTRO-joint-state-publisher-gui
	sudo apt-get install -y ros-$MY_ROS_DISTRO-position-controllers
	
	# sudo apt-get install -y ros-$MY_ROS_DISTRO-ifopt						# Unreleased for Humble
	sudo apt-get install -y ros-$MY_ROS_DISTRO-ruckig

	## microROS


}
	

main() {

	# Switch to Root Directory
	cd /

	# Show the AIMS Lab logo so they know its the right file.
	show_ascii_aims
	check_os
	sleep 1

	# Ensure full script is NOT being run as root
	if [ "$EUID" -eq 0 ]
		then echo "Script must NOT be run as root. Please relaunch installer as an sudo privledged user without sudo command!"
		exit
	fi


	# Information
	printf "Programs will be installed as user ${COLOR_Y}'ROOT'${COLOR_NC} \\nConfigurations will be applied as user ${COLOR_Y}%s${COLOR_NC} \\n \\n" "$SUDO_USER"

	
	## Update
	sudo apt-get update
	sudo apt-get upgrade -y
	
	## Setup locale as UTF-8
	locale 
	sudo apt install -y locales
	sudo locale-gen en_US en_US.UTF-8
	sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
	export LANG=en_US.UTF-8
	locale 
	
	## Run Installer	
	install_system_tools
	setup_ros_source
	install_ros2

	## Tool: Tesseract Ignition
	sudo snap install tesseract-ignition

	## Tool: Code Coverage
	sudo apt-get install -y lcov
	
	## ROS Simulation Tools (Gazebo/Ignition)
	sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null

	sudo apt-get update
	sudo apt-get install -y ignition-fortress

	sudo apt-get install -y ros-$MY_ROS_DISTRO-ros-gz
	# sudo apt-get install -y ros-$MY_ROS_DISTRO-ros-ign   #For Humble, _ign is a shim metapackage that points to the _gz meta package

	## ROS Dev Tools (https://github.com/ros-infrastructure/infra-variants)
	sudo apt-get install -y ros-dev-tools
	sudo apt-get install -y ros-build-essential
	
	# Dependencies needed for building/managing ROS packages
	sudo apt-get install -y python3-rosdep	#(duplicated from ros-dev-tools)
	sudo apt-get install -y python3-osrf-pycommon
	sudo apt-get install -y python3-wstool 
	sudo apt-get install -y python3-vcstool	#(duplicated from ros-dev-tools)
	sudo apt-get install -y build-essential #(duplicated from ros-build-essential)

	# Setup ROSdep
	sudo rosdep init
	rosdep update

	# Configure Current User
	read -p "Configure current user's .bashrc for ROS's Colcon argument completion? " -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo -e "# Colcon Argument Tab Completition \nsource /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> $HOME/.bashrc
		source $HOME/.bashrc
	fi
	
	# Post Install Cleanup
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get autoremove -y

	# Report Done
	printf "\n\n ${TICK}${COL_LIGHT_GREEN}  DONE! ROS has been setup on this computer!${COL_NC}\n\n"

}


# A simple function that just echoes the AIMS logo in ASCII format. This lets users know that it is an AIMS Lab product
show_ascii_aims() {
    echo -e "
****************************************************************************
*${COLOR_R}                   _    ___ __  __ ____    _          _                   ${COLOR_NC}*
*${COLOR_R}                  / \  |_ _|  \/  / ___|  | |    __ _| |__                ${COLOR_NC}*
*${COLOR_R}                 / _ \  | || |\/| \___ \  | |   / _' | '_ \               ${COLOR_NC}*
*${COLOR_R}                / ___ \ | || |  | |___) | | |__| (_| | |_) |              ${COLOR_NC}*
*${COLOR_R}               /_/   \_\___|_|  |_|____/  |_____\__,_|_.__/               ${COLOR_NC}*
*${COLOR_R}                                                                          ${COLOR_NC}*
****************************************************************************
***${COLOR_G}                      ROS Installer for Ubuntu 22                     ${COLOR_NC}***
****************************************************************************
"
}


# Variables
COLOR_NC='\e[0m' # No Color
COLOR_R='\e[1;31m'
COLOR_G='\e[1;32m'
COLOR_Y='\e[1;33m'
TICK="[${COLOR_G}✓${COLOR_NC}]"
CROSS="[${COLOR_R}✗${COLOR_NC}]"


# Run Script
main "$@"

#EOF
