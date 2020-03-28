# Bash-Scripts
This Repository Contains my open source bash scripts that make a Linux based Software developer's life easy


## Script-1 : Disk Space Monitor
File : space_monitor.sh

### Description:
This Script when ran, will read the available disk space in your /home directory and checks if the space used is more than a given threshold, if it crosses the threshold then sends mails to all the clients specified in a file.


#### Setup Details:
1. Pull This file to your local repository.
2. Create a clients file, and assisgn its absolute path to the `$TEAM_CLIENTS` variable
3. The Variable `$MEM_THRESHOLD` will contain the max allowd space that can be used, beyond which we will send the mail.
4. After assigning the two values now create a cronjob by typing `crontab -e` and add the fowwoing entries there,
```bash
  SHELL=/bin/bash
  MAILTO=<mail id to which you want cron to mail to, the output of your script>
  * * * * * . $HOME/.profile; <absolute path to your script>
```
![alt text](https://github.com/ram914/Bash-Scripts/blob/master/Screenshot%20from%202020-03-28%2016-36-46.png "crontab file screenshot")

I set my script to run first five days of the week, 9th Hour exactly at 0 minutes.
**Note:** The each asterisk(\*) above has a meaning.
  * First  - Minute you want the cron job to run, ex: 0, 1, 45, 10-23, 58 etc
  * Second - Hour ex: 0, 1, 2-15, 18, 23 etc
  * Third  - Day ex: 1-31
  * Fourth - Month ex: 1-12
  * Fifth  - Week ex: 1, 2, 3-5, 7 etc.
