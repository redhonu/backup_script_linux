# Folder Backup Script

This script is designed to perform backups of folders on a Linux system.
using tar it compresses the file to a *.tar.gz
After succefully running the script it will echo the path to the output file.

## Usage

bash
`./backup-script.sh -f /path/to/folder -o /path/to/backup/directory [-r true/false] [-d <days_to_keep>]`

| Option | Description                                                                                                          | Required | Default |
|--------|----------------------------------------------------------------------------------------------------------------------|----------|---------|
| -f     | specify the folder you want to backup                                                                                | YES      | --      |
| -o     | Output directory, The backup will be in <Output/directory>/inputfolder_backup/inputfolder_date_and_time              | YES      | --      |
| -d     | Files older than the specified number of days will be deleted in the output directory. (default 0 to keep all files) | NO       | 0       |
| -r     | if this is set to "true", all files in the output directory will be deleted and the the new backup will be created.  | NO       | false   |

## Cronjob
This script is most usefull if used in a cronjob. <br>
To create a cronjob" `crontab -e`<br>
<br>
An example cronjob could be: ```30 5 * * * bash /./path/to/backup.sh -f /home/user/important/data -o /home/user -d 7```
<br>
This would run every day at 5:30 AM, and keep the backups each for 7 days.

## Credits
This script was inpired by [RaidOwl's](https://www.youtube.com/@RaidOwl) script to backup docker volumes. [Original Script](https://drive.google.com/file/d/143kR9FcSzUQkBLBf6sDfPbRzCDW3i1As/view?usp=sharing)
