# ROS Setup Shell Scripts

This procedure is maintained for standard usage by the AIMS Lab and partners. This script will install and configure the ROS middleware and dependencies. Details of the shell script’s procedure are documented by script comments.
Includes setup shell scripts for multiple Operating Systems and ROS versions.

| Script Name | OS Version | ROS Versions Installed | Support Level |
| ----------- | ---------- | ---------------------- | ------------- |
| [setup-bionic](/setup-bionic.sh) | Ubuntu 18.04 | ROS 1 Melodic        | EOL |
| [setup-focal](/setup-focal.sh) | Ubuntu 20.04 | ROS 1 Noetic<br>ROS 2 Foxy | Fully Supported |
| [setup-jammy](/setup-jammy.sh)| Ubuntu 22.04 | ROS 2 Humble         | Under Development |



### Usage Instructions

1. Download this repo using the green "CODE 🔽" button and clicking "Download ZIP". Save this folder in the `$HOME` directory (linux).
2. Open a new Terminal. Navigate to appropriate file path. <br>
  <code>cd $HOME</code>
3. Run bash script!<br>
    <code>bash $HOME/setup-<os-codename>.sh</code>
    <br> DO NOT RUN THIS WITH SUDO! Will cause an error when setting up the ROS path.
    <br> You may be prompted for a sudo password (even if not run with sudo). Go ahead and enter password then continue.


### Check Install
Command                | Expected Output |
---------------------- | ------------------- |
<code>printenv &#124; grep ROS</code>  | A list of variables |
ROS1: `roswtf` <br>ROS2: `ros2 wtf`               | “No errors or warnings” |
ROS1: `roscore`              | Regular launch output. <br> No ROS2 equivalent. |
