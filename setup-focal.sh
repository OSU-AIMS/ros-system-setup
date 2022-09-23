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
MY_VER="20.04"
ROS1_DISTRO="foxy"
ROS2_DISTRO="noetic"
IGNITION_VER="fortress"


## Support Methods
install_system_tools() {
	# Install System Tools & Libraries 
	sudo apt-get install -y curl
  	sudo apt-get install -y gnupg2
  	sudo apt-get install -y lsb-release
	sudo apt-get install -y git
	sudo apt-get install -y meld
	sudo apt-get install -y build-essential
	sudo apt-get install -y libfontconfig1
	sudo apt-get install -y mesa-common-dev
	sudo apt-get install -y libglu1-mesa-dev
	sudo apt-get install -y tree
}


check_os() {

	# Check OS Family
	if [[ "$OSTYPE" == "$MY_OSTYPE" ]];
	    then printf "  Detected OS Family:     ${COLOR_G}$OSTYPE${COLOR_NC} \\n"
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

	printf "  Detected Linux Distro:  ${COLOR_G}$OS${COLOR_NC} \\n"
	printf "  Detected Linux Version: ${COLOR_G}$VER${COLOR_NC} \\n"


	# Script only valid for Ubuntu
	if [[ "$OS" != "$MY_OS" && "$VER" != "$MY_VER" ]]; then
	    printf "  Detected OS is NOT $MY_OS $MY_VER. Stopping install prep.\\n  This script is designed specifically for $MY_OS $MY_VER\\n"
	fi

	printf "\\n****************************************************************************\\n"
}


setup_ros_source() {
	# Setup ROS1 & ROS2  source

	# ROS 1
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

	# ROS 2
	sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

	# Update Sources
	sudo apt-get update
	sudo apt update
}


install_ros1() {

	sudo apt-get install -y ros-$ROS2_DISTRO-desktop
	sudo apt-get install -y ros-$ROS2_DISTRO-catkin

	sudo apt-get install -y ros-$ROS2_DISTRO-perception
	sudo apt-get install -y ros-$ROS2_DISTRO-moveit
	sudo apt-get install -y ros-$ROS2_DISTRO-moveit-visual-tools

	sudo apt-get install -y ros-$ROS2_DISTRO-warehouse-ros
	sudo apt-get install -y ros-$ROS2_DISTRO-warehouse-ros-mongo

	sudo apt-get install -y ros-$ROS2_DISTRO-image-publisher
	sudo apt-get install -y ros-$ROS2_DISTRO-realsense2-camera
	sudo apt-get install -y ros-$ROS2_DISTRO-realsense2-description

	sudo apt-get install -y ros-$ROS2_DISTRO-trac-ik-kinematics-plugin
	sudo apt-get install -y pcl-tools

	sudo apt-get install -y ros-$ROS2_DISTRO-industrial-core
	sudo apt-get install -y ros-$ROS2_DISTRO-ros-industrial-cmake-boilerplate

	sudo apt-get install -y ros-$ROS2_DISTRO-ros-controllers
	sudo apt-get install -y ros-$ROS2_DISTRO-position-controllers
	sudo apt-get install -y ros-$ROS2_DISTRO-joint-state-controller
	sudo apt-get install -y ros-$ROS2_DISTRO-joint-state-publisher
	sudo apt-get install -y ros-$ROS2_DISTRO-joint-state-publisher-gui
	sudo apt-get install -y ros-$ROS2_DISTRO-moveit-simple-controller-manager
}


install_ros2() {

	sudo apt-get install -y ros-$ROS1_DISTRO-desktop
	sudo apt-get install -y python3-colcon-common-extensions
	sudo apt-get install -y python3-argcomplete
	sudo apt-get install -y ros-$ROS1_DISTRO-ros-testing	
	sudo apt-get install -y ros-$ROS1_DISTRO-ros1-bridge
	
	sudo apt-get install -y ros-$ROS1_DISTRO-xacro
	sudo apt-get install -y ros-$ROS1_DISTRO-moveit
	sudo apt-get install -y ros-$ROS1_DISTRO-octomap-ros


	sudo apt-get install -y ros-$ROS1_DISTRO-image-publisher
	sudo apt-get install -y ros-$ROS1_DISTRO-realsense2-camera
	sudo apt-get install -y ros-$ROS1_DISTRO-realsense2-description
	
	sudo apt-get install -y ros-$ROS1_DISTRO-ros-industrial-cmake-boilerplate
	  
	sudo apt-get install -y ros-$ROS1_DISTRO-ros2-control
	sudo apt-get install -y ros-$ROS1_DISTRO-ros2-controllers
	sudo apt-get install -y ros-$ROS1_DISTRO-joint-state-publisher
	sudo apt-get install -y ros-$ROS1_DISTRO-joint-state-publisher-gui
	sudo apt-get install -y ros-$ROS1_DISTRO-joint-state-controller
	sudo apt-get install -y ros-$ROS1_DISTRO-position-controllers
	
	sudo apt-get install -y ros-$ROS1_DISTRO-ifopt
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
	printf "\\n  Programs will be installed as user ${COLOR_Y}root${COLOR_NC}"
	printf "\\n"
	while true; do
		read -p "  Configure current user's .bashrc for ROS's Colcon arg completion? (y/n)  " -r REPLY_CONFIGURE_USER
		case $REPLY_CONFIGURE_USER in
			[Yy]* ) printf "  Configurations will be applied to user ${COLOR_Y}%s${COLOR_NC}\\n" "$USERNAME"; break;;
			[Nn]* ) printf "  No user configurations will be applied.\\n" "$USERNAME"; break;;
			* ) echo "Please answer yes 'y' or no 'n'.";;
		esac
	done

	printf "\\n****************************************************************************\\n"
	printf "\\n  Enter sudo privledged user's password to begin install:\\n  "


	## OS Version
	# while ! [[ "$os_version" =~ ^(ubuntu18|ubuntu20|ubuntu22)$ ]] 
	# do
	#   printf "\\nWhich image do you want to use: ubuntu18 / ubuntu20 / ubuntu22 ?\\n"
	#   read -r os_version
	# done
	
	
	## Update
	sudo apt-get update
	sudo apt-get upgrade -y
	
	## Setup locale as UTF-8
	locale 
	sudo apt install -y locales
	sudo locale-gen en_US en_US.UTF-8
	sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
	export LANG=en_US.UTF-8
	
	## Run Installer	
	install_system_tools
	setup_ros_source
	install_ros1
	install_ros2
	
	## ROS Simulation Tools (Gazebo & Ignition)
	sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
	sudo apt-get update

	sudo apt-get install -y ignition-$IGNITION_VER
	sudo apt-get install -y ros-$ROS2_DISTRO-ros-ign
	sudo apt-get install -y ros-$ROS2_DISTRO-gazebo-ros
	sudo apt-get install -y ros-$ROS2_DISTRO-gazebo-ros-control

	sudo apt-get install -y ros-$ROS1_DISTRO-ros-ign
	
	## ROS Compiler Tools
	# Dependencies needed for building/managing ROS packages
	sudo apt-get install -y python3-rosdep
	sudo apt-get install -y python3-catkin-tools
	sudo apt-get install -y python3-osrf-pycommon
	sudo apt-get install -y python3-wstool
	sudo apt-get install -y python3-vcstool
	sudo apt-get install -y build-essential

	# Setup ROSdep
	sudo rosdep init
	rosdep update

	# Configure Current User
	if [[ $REPLY_CONFIGURE_USER =~ ^[Yy]$ ]]
	then
		printf "\\n  Applying ROS configuration to local user...\\n"
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
***${COLOR_G}                      ROS Installer for Ubuntu 20                     ${COLOR_NC}***
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
