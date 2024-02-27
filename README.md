# Folder Backup Script

This script performs backups of folders on a Linux system by compressing them into *.tar.gz archives using `tar`. After successfully running the script, it echoes the path to the output file.

## Usage

```bash
./backup-script.sh -f /path/to/folder -o /path/to/backup/directory [-r true/false] [-d <days_to_keep>]
```

| Option | Description																		| Required | Default |
|--------|------------------------------------------------------------------------------------------------------------------------------------------------------|----------|---------|
| `-f`   | Specifies the folder to be backed up.														| YES      | --      |
| `-o`   | Specifies the output directory for the backup. The backup will be saved as `<output_directory>/inputfolder_backup/inputfolder_date_and_time.tar.gz`. | YES      | --      |
| `-d`   | Specifies the number of days to keep old backups in the output directory. Files older than this will be deleted. (Default: 0 to keep all files) 	| NO       | 0       |
| `-r`   | If set to "true", clears the output directory before creating a new backup.                                         					| NO       | false   |

## Download

```bash
git clone https://github.com/redhonu/backup_script_linux.git
```

## Cronjob

This script is most useful when used in a cronjob. To create a cronjob, use the command `crontab -e`.

An example cronjob:
```bash
30 5 * * * bash /path/to/backup_script_linux/backup-script.sh -f /home/user/important/data -o /home/user -d 7
```
This cronjob runs every day at 5:30 AM and keeps backups for 7 days.

## Credits

This script was inspired by [RaidOwl](https://www.youtube.com/@RaidOwl)'s script to backup Docker volumes. [Original Script](https://drive.google.com/file/d/143kR9FcSzUQkBLBf6sDfPbRzCDW3i1As/view?usp=sharing)
