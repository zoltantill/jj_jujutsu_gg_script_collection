# `convert_to_utf8.ps1` – ANSI to UTF-8 Batch Converter Script

## Overview

This PowerShell script batch-converts text-based files in your project from legacy encodings (such as ANSI) to UTF-8 without BOM.  
It is designed to resolve the "invalid utf-8 sequence of 1 bytes from index ..." error displayed by GG (the GUI for Jujutsu/JJ) when it encounters non-UTF-8 files.  
Before running the script, you will be prompted to confirm that you have created a backup of your files, ensuring safe operation.

---

## Why Use This Script?

- **Problem:**  
  GG cannot process files that are not encoded in UTF-8 and will show cryptic errors (e.g., "invalid utf-8 sequence of 1 bytes from index 42") when it encounters ANSI or other non-UTF-8 encodings.
- **Solution:**  
  This script automates the conversion of all specified file types in your project (and subfolders) to UTF-8 encoding (without BOM), ensuring maximum compatibility with GG, JJ, and other modern tools.
- **Safety:**  
  The script asks for confirmation that you have backed up your files before making any changes.

---

## Usage

1. Place the script in the root folder of your project.
2. Right-click the script and select **"Run with PowerShell"**.
3. When prompted, confirm that you have made a backup of your files.
4. The script will recursively convert all matching files to UTF-8 without BOM and print each converted file path to the console.

> **Note:**  
> The script overwrites files in place. Always ensure you have a backup before proceeding.

---

## How the Script Works

- Prompts the user to confirm they have backed up their files.
- Recursively searches for files with the specified extensions (e.g., `.cls`, `.bas`, `.md`, `.txt`, `.csv`, `.sql`, `.rpt`, `.qry`).
- Reads each file as a string.
- Overwrites the file with UTF-8 encoding (no BOM).
- Prints the path of each converted file for verification.

---

## Recommended File Extensions

In addition to the listed extensions, you may want to include other text-based file types commonly used in your projects, such as:

- `*.json`
- `*.xml`
- `*.js`, `*.ts`
- `*.css`
- `*.ini`, `*.conf`
- `*.log`
- `*.py`, `*.sh`, `*.bat`


---

## Notes & Tips

- **Backup:** Always back up your files before running the script, as changes are irreversible.
- **Encoding detection:** The script assumes all matching files are plain text. Use with caution if your project contains mixed or binary files.
- **Platform:** Designed for Windows/PowerShell environments.

---

## Troubleshooting

- If GG still reports UTF-8 errors after conversion, check for files with unsupported or mixed encodings, or add additional file extensions as needed.

---

**Author:**  
https://github.com/zoltantill

---

If you have questions or encounter issues, please open an issue in the repository.
