# random-scripts
Some random scripts that I've written for various reasons
- - -
## db_backup.sh
I wrote this script to help me keep daily backups for a postgres database for a project I did in 2018.  
I ran it via cron `0 0 * * *`. It would run everyday at 12:00am.  
Honestly, not the best naming scheme for my backups, but it worked for what I needed.  
- - -
## nginx_check.sh
This checks whether NGINX has been shut down, if it has it starts it back up (probably a better way but whatever)
