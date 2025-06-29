# PowerShell Backup Script Documentation

## Overview

This script automates the creation of timestamped backups while preserving original file creation and modification dates. By default, it backs up the directory where the script is located, but supports multiple source directories. Each backup is organized in a unique, timestamped subfolder under its source directory name within the backup root. The script excludes specified subdirectories, logs all operations to CSV, and provides intelligent console management.

## Features

- **Timestamp Preservation:** Maintains original file creation (`CreationTime`) and modification (`LastWriteTime`) dates in backups
- **Default source:** The script automatically uses its own directory as the source if no other paths are specified.
- **Backup structure:**  
  - Each source directory is backed up to a folder named after its last directory component (e.g., `MyProject`).
  - Inside this folder, backups are stored in subfolders named with the current date and time (e.g., `20240618_203000`).
- **Exclusion:**  
  - You can exclude specific subdirectories (e.g., `.git`, `.jj`) from the backup.
  - Exclusions are specified via the `-ExcludeDirs` parameter.
- **Logging:**  
  - All backup operations are logged to a CSV file.
  - The log includes timestamps, source and destination paths, status, and any error messages.
- **User feedback:**  
  - The script provides clear console output.
  - On successful completion, the console closes automatically after a brief delay.
  - On failure, detailed error information is displayed, and the console remains open for user interaction.

## Usage

### Basic Usage

To back up the directory containing the script (default behavior):

.\backup_repo.ps1


### Advanced Usage

To back up specific directories and exclude certain subdirectories:

.\backup_repo.ps1 -RepoPaths "C:\Projects", "D:\Notes" -ExcludeDirs "node_modules", ".cache"


### Parameters

| Parameter      | Description                                                                 | Default Value            |
|----------------|-----------------------------------------------------------------------------|--------------------------|
| RepoPaths      | Array of source directories to back up                                      | Script directory         |
| BackupRoot     | Root directory for backups                                                  | `C:\Backups`             |
| Include        | File patterns to include in backup (e.g., `*.md`, `*.ps1`)                  | `*.md`, `*.ps1`, etc.    |
| ExcludeDirs    | Subdirectories to exclude from backup (e.g., `.git`, `.jj`)                 | `.git`, `.jj`            |
| LogPath        | Path to the CSV log file                                                    | `C:\Backups\backup_log.csv` |

## Example Output Structure

C:\Backups
│
├── MyProject
│ └── 20240618_203000
│ ├── file1.md
│ └── file2.ps1
└── Notes
└── 20240618_203000
├── note1.md
└── note2.txt


## Log File Example

Timestamp,RepoPath,BackupPath,Status,Error
2024-06-18T20:30:00.1234567+02:00,C:\Projects\MyProject,C:\Backups\MyProject\20240618_203000,Success,
2024-06-18T20:30:02.2345678+02:00,D:\Notes,C:\Backups\Notes\20240618_203000,Success,


## Requirements

- **Windows PowerShell 5.1+** (or PowerShell 7+)
- **Robocopy** (included with Windows)

## Technical Notes

1. **Timestamp Restoration:**  
   - Occurs after robocopy completes
   - Only affects included files
   - Skips files in excluded directories
2. **Performance:**  
   - Large repositories may take longer due to timestamp restoration
   - ~0.1ms/file overhead (varies by system)
3. **Repo name in backup:** The script uses the last directory name of each source path as the repository name in the backup structure.
4. **Error handling:** The script logs and displays detailed error information if anything goes wrong.
5. **Customization:** You can easily customize the script by modifying the parameters in the command line or directly in the script.

Made by https://github.com/zoltantill