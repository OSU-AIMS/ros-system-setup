# ros-system-setup
Setup Bash Shell's for AIMS Lab ROS Computers

### Usage Instructions
Having successfully installed the Linux OS, we will now install the ROS middleware and dependencies.
This procedure will use the AIMS lab developed bash script to handle all the install steps. For details on this specific bash script’s functionalities, refer to documentation comments inside the script.

Transfer the bash shell script into the system's folder system. Suggest placing this in `$HOME`.

*Complete the following steps (in terminal)..*
<li>1. Open a new Terminal. Navigate to appropriate file path. <br>
  <code>cd FOLDER-PATH</code>
<li>2. Make bash script executable<br>
    <code>sudo chmod +x FILE-NAME.sh</code>
<li>3. Run bash script!<br>
    <code>FOLDER-PATH/FILE-NAME.sh</code>
    <br> DO NOT RUN THIS WITH SUDO! Will cause an error when setting up the ROS path.

This bash script may take between 10-20 minutes to run.

*The last install step must be completed using a GUI:*
<br>“Qt Creator with ROS Plug-in Setup” Hit Next.Next. “Select All”. Next. “I accept the licenses”. Next

*Example file paths:* <br>
If placed in Home, use `~/file.sh`
If placed in Desktop, use `~/Desktop/file.sh`


### Added BASH Commands
Command         | Action
--------------- | -------------------
`ros1`          | Source ROS Melodic for local terminal
`ros2`          | Source ROS Eloquent for local terminal
`rosdebug`      | Add feature where roslaunch will show which package/module/code caused error


### Debugging Hints
Use roslaunch option `--screen` to show all action lines
Use bash alias command `rosdebug` to show which module caused the error

### Check Install
Command                | Expected Output
---------------------- | -------------------
<code>printenv &#124; grep ROS</code>  | A list of variables
`roswtf`               | “No errors or warnings”
`roscore`              | Regular launch output
