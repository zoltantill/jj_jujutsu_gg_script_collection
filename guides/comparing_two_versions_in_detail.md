# Step-by-Step Guide: Comparing Two Versions in Detail (with WinMerge)

This guide shows how to thoroughly compare the differences between two versions of your project or repository using the Working Copy feature and WinMerge. This method is ideal for reviewing changes across many files and folders, not just individual files.

---

## Prerequisites

- [WinMerge](https://winmerge.org/) installed on your system.
- Two distinct versions (commits, working copy states, or snapshots) of your repository accessible via JJ/GG.
- Sufficient disk space for temporary backup folders.
- The provided backup scripts: `backup_repo.ps1` or `backup_repo.bat`.

---

## Step 1: Prepare Backups of the Two Versions

1. **Switch Working Copy to the First Version**
    - In JJ/GG, set your working copy to the first commit or state you want to compare.
    - Wait for JJ/GG to update your working directory to this version.

2. **Backup the First Version using the Script**
    - Run the provided backup script to create a snapshot of your repository.

      **Batch:**
      backup_repo.bat

    - The script will create a timestamped backup folder (e.g., `D:\Backups\YourRepo\20250628_153000`).

3. **Switch Working Copy to the Second Version**
    - In JJ/GG, set your working copy to the second commit or state.
    - Wait for JJ/GG to update your working directory.

4. **Backup the Second Version using the Script**
    - Run the backup script again to create a snapshot of this state.
    - You will now have two separate backup folders, one for each version.

---

## Step 2: Compare the Two Versions with WinMerge

1. **Open WinMerge**
    - Launch WinMerge from your Start menu or desktop shortcut.

2. **Select Folders to Compare**
    - In WinMerge, go to `File` > `Open...` (or press `Ctrl+O`).
    - Set the left folder to your first backup (e.g., `D:\Backups\YourRepo\20250628_153000`).
    - Set the right folder to your second backup (e.g., `D:\Backups\YourRepo\20250628_154500`).

3. **Start the Comparison**
    - Click `Compare`.
    - WinMerge will scan both folders and display all differences, including:
        - Added, deleted, or modified files
        - Line-by-line differences within files

4. **Review Differences**
    - Use WinMerge’s interface to navigate changes.
    - Double-click files to see detailed, side-by-side diffs.
    - Filter or search for specific changes if needed.

---

## Step 3: (Optional) Analyze and Merge Changes

- If you want to merge changes from one version to another, use WinMerge’s merge tools to copy content between folders.
- Save merged files as needed.

---

## Why This Method Matters

- **Comprehensive:** You see every change, not just single-file diffs.
- **Visual:** WinMerge highlights differences clearly, even across many files.
- **Safe:** Your original repository is untouched; all work is done on backups.
- **Flexible:** You can compare any two commits, branches, or working copy states.

---

## Tips

- The backup scripts automatically exclude `.jj`, `.git`, and other VCS folders to avoid confusion.
- For very large projects, consider comparing only relevant subfolders.
- You can use other diff tools (e.g., Meld, Beyond Compare) with the same backup approach.

---

*This workflow is especially useful for code reviews, audits, or understanding complex changes in multi-file projects.*


Written by https://github.com/zoltantill