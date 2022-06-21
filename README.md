# ROS Setup Shell Scripts

Includes setup shell scripts for multiple Operating Systems and ROS versions.

| Script Name | OS Version | ROS Versions Installed | Support Level |
| ----------- | ---------- | ---------------------- | ------------- |
| [setup-jammy](/setup-jammy) | Ubuntu 18.04 | ROS 1 Melodic        | EOL |
| [setup-focal](/setup-focal) | Ubuntu 20.04 | ROS 1 Noetic<br>ROS 2 Foxy | Fully Supported |
| [setup-bionic](/setup-bionic)| Ubuntu 22.04 | ROS 2 Humble         | Under Development |

This procedure is maintained for standard usage by the AIMS Lab and partners. This script will install and configure the ROS middleware and dependencies. Details of the shell script’s procedure are documented by script comments.


### Usage Instructions

1. Download this repo using the green "CODE 🔽" button and clicking "Download ZIP". Save this folder in the `$HOME` directory (linux).
2. Open a new Terminal. Navigate to appropriate file path. <br>
  <code>cd $HOME</code>
2. Make the bash script executable<br>
    <code>sudo chmod +x $HOME/core-setup</code>
3. Run bash script!<br>
    <code>sh $HOME/setup-<os-codename></code>
    <br> DO NOT RUN THIS WITH SUDO! Will cause an error when setting up the ROS path.
    <br> You may be prompted for a sudo password (even if not run with sudo). Go ahead and enter password then continue.


### Check Install
Command                | Expected Output |
---------------------- | ------------------- |
<code>printenv &#124; grep ROS</code>  | A list of variables |
ROS1: `roswtf` <br>ROS2: `ros2 wtf`               | “No errors or warnings” |
ROS1: `roscore`              | Regular launch output. <br> No ROS2 equivalent. |
