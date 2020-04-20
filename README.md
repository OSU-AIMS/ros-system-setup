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
    <code>sudo FOLDER-PATH/FILE-NAME.sh</code>
  
This bash script may take between 10-20 minutes to run.

*The last install step must be completed using a GUI:*
<br>“Qt Creator with ROS Plug-in Setup” Hit Next.Next. “Select All”. Next. “I accept the licenses”. Next
  
*Example file paths:* <br>
If placed in Home, use `~/file.sh`
If placed in Desktop, use `~/Desktop/file.sh`



### Check Install
Command                | Expected Output
---------------------- | -------------------
<code>printenv &#124; grep ROS</code>  | A list of variables
`roswtf`               | “No errors or warnings”
`roscore`              | Regular launch output
