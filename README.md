# ros-system-setup

Designed for **Ubuntu Focal 20.04**

This procedure is maintained for standard usage by the AIMS Lab and partners. After a new desktop install of Ubuntu, this script will install and configure the ROS middleware and dependencies. Details of the shell script’s procedure are documented by script comments.


### Usage Instructions
Transfer the bash shell script into the system's folder system. Suggest placing this in `$HOME`.

1. Open a new Terminal. Navigate to appropriate file path. <br>
  <code>cd $HOME</code>
2. Make bash script executable<br>
    <code>sudo chmod +x $HOME/core-setup</code>
3. Run bash script!<br>
    <code>$HOME/core-setup</code>
    <br> DO NOT RUN THIS WITH SUDO! Will cause an error when setting up the ROS path.


### Check Install
Command                | Expected Output
---------------------- | -------------------
<code>printenv &#124; grep ROS</code>  | A list of variables
`roswtf`               | “No errors or warnings”
`roscore`              | Regular launch output


### Added BASH Commands
Command         | Action
--------------- | -------------------
`ros1-noetic`   | Source ROS Melodic for local terminal
`ros2-foxy`     | Source ROS Eloquent for local terminal


### Debugging Hints
Use roslaunch option `--screen` to show all action lines.
<br>Use bash alias command `rosdebug` to show which module caused the error.


