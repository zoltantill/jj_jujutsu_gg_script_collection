# jj_jujutsu_gg_script_collection

I love using [Jujutsu (JJ) VCS](https://github.com/jj-vcs/jj) and its GUI, [GG](https://github.com/gulbanana/gg). 
To make my workflow more practical, I created a few batch and PowerShell scripts.

Jujutsu (JJ) is a modern, Git-compatible version control system designed to simplify and enhance software development workflows. Unlike traditional Git, JJ introduces features such as automatic working-copy commits, flexible commit message editing, and a streamlined model without a staging area, making automation and history rewriting much more straightforward. GG builds on JJ’s composable primitives to offer an interactive graphical interface for managing your repositories, making tasks like rebasing, conflict resolution, and commit editing more intuitive and visual.

This repository provides a collection of scripts to streamline working with JJ and GG on Windows. The scripts help automate common tasks, integrate with external diff and merge tools, and optimize repository management. If you are using a Mac, you may need to create alternative scripts.

Whether you want to automate repository setup, improve commit management, or leverage JJ and GG’s advanced features, this collection is designed to make your version control experience smoother and more productive.


## Scripts

This repository contains several batch and PowerShell scripts to make working with Jujutsu (JJ) and GG easier on Windows.


### `init_git_jj.ps1`

Initializes both Git and Jujutsu (JJ) version control in the current folder.  
**Usage:** Right-click the script and select "Run with PowerShell".  
For detailed instructions and tips, see [init_git_jj.md](scripts/init_git_jj.md).

Note:
Setting up both Git and JJ in this way makes your repository more compatible with other Git tools, external repositories, and advanced diff viewers. This allows you to continue using popular Git-based GUIs, IDE integrations, and diff tools (like [WinMerge](https://github.com/WinMerge/winmerge), Meld, or SourceTree) seamlessly, while also benefiting from JJ’s features and workflow.

This approach ensures that:
 - Git-based tools (IDEs, build systems, CI/CD pipelines) recognize your repository as a standard Git repo and function normally.
 - You can collaborate with others using Git without any disruption, as all Git commands and workflows remain available.
 - You gain access to JJ’s unique features and safety net, while maintaining full interoperability with the broader Git ecosystem.
 - This is a widely recommended best practice for users who want the flexibility of JJ alongside the broad compatibility of Git tools.

 
### `convert_to_utf8.ps1 and convert_to_utf8.bat`

This PowerShell script quickly converts files with various common text-based extensions (such as .cls, .bas, .md, .txt, .csv, .sql, .rpt, .qry) from ANSI or other legacy encodings to UTF-8 without BOM.
It is especially useful if you encounter the GG error:
'invalid utf-8 sequence of 1 bytes from index ...',
which typically appears when a file is not properly encoded in UTF-8.
A batch file is included for easier execution.
Be sure to make a backup before using this script.


### `auto_commit.bat`

This batch script enables automatic version control for your repository using Jujutsu (JJ) on Windows.  
It is designed to run at system startup and is ideal for automatically tracking daily changes in an Obsidian repo or any other folder.

The script checks for uncommitted changes and, if any are found, creates a commit with a timestamped message.  
If there are no changes, but the latest commit lacks a description, it adds one automatically.

This ensures that at least a daily snapshot is always saved, even if you forget to commit manually.  
You can further customize the script to separate different types of changes, but this provides a simple, reliable baseline for automated version history.

**Why Jujutsu (JJ)?**  
A key advantage of using JJ is its powerful ability to split and reorganize commits after they are created. With JJ, you can later break up large, automatic commits into smaller, meaningful chunks using commands like `jj split` or `jj squash`.  
This makes your commit history cleaner and easier to review, and gives you much more flexibility compared to traditional Git workflows.

**Note:**  
Make sure to review and adapt the script for your workflow. Regular automatic commits help safeguard your notes and edits with minimal effort.


### `backup_repo.ps1 and backup_repo.bat`

This PowerShell script automates the backup of specified directories to a target location, organizing each backup in timestamped folders. By default, it backs up the directory where the script is located, but you can specify any number of source directories as arguments. The script supports exclusion of specific subdirectories (such as .git or .jj) and logs all operations to a CSV file for easy tracking.
Importantly, the script preserves the original creation and modification dates of all backed-up files, ensuring that file metadata remains intact.

Key Features:
 - Default source: The directory containing the script.
 - Backup structure: Each source is backed up to a timestamped folder under its own name in the backup root.
 - Timestamp preservation: Both original creation (CreationTime) and modification (LastWriteTime) dates are retained in the backup.
 - Exclusion: Optionally exclude subdirectories by name.
 - Logging: Detailed CSV log of backup status and any errors.
 - User feedback: Console output and error handling with clear prompts.

Example usage:
.\backup_repo.ps1
.\backup_repo.ps1 -RepoPaths "C:\Projects", "D:\Notes" -ExcludeDirs "node_modules", ".cache"

This script is designed for quick, reliable, and customizable local backups, while maintaining the integrity of file timestamps for accurate archiving and restoration.


### `open_gg.bat` - GG Quick Launcher Batch File

The `open_gg.bat` script provides a convenient way to launch the GG graphical interface for Jujutsu (JJ) directly from your repository.

**How to use:**
1. Add the folder containing the `gg` executable to your Windows system PATH (if you haven’t already).
2. Place `open_gg.bat` in the root of your repository (where your `.git` and/or `.jj` directories are).
3. Double-click `open_gg.bat` to open GG in the context of your current repository.

This makes it easy to manage your version control visually, without needing to open a terminal or navigate directories manually.



Made by https://github.com/zoltantill

