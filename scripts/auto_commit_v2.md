# `auto_commit v2` – Automatic Commit Script for Jujutsu (JJ)

This script automates creating commits in **Jujutsu (JJ)** with descriptive commit messages based on the changed files in your working copy.  
It is designed for use with `auto_commit.bat` and `jj_auto_commit.ps1`.

---

## **Features**

- ✅ Automatically commits **only when there are changes**  
- ✅ Commit message contains:
  - Optional **prefix** (e.g., `[AUTO]`)
  - **Date/time** in a configurable format
  - **Changed file list** or **summary counts** if many files changed
- ✅ Handles file operations:
  - **Added (A)** files  
  - **Deleted (D)** files  
  - **Renamed (R)** files (`old -> new`)  
  - **Changed (C)** files
- ✅ All output **formatting is configurable from the BAT file**:
  - Commit message structure
  - Date/time format
  - Labels for A/D/R/C
  - Max files before switching to summary mode
- ✅ Uses `jj commit` directly (no `jj add` required)

---

## **Files**

1. **`auto_commit.bat`**  
   - Main configuration and runner for auto‑commit.  
   - Defines commit message format, date/time format, labels, and file limit.

2. **`jj_auto_commit.ps1`**  
   - PowerShell script that:
     - Checks changes with `jj status`
     - Builds the commit message
     - Performs the auto‑commit

---

## **Configuration (auto_commit.bat)**

```bat
@echo off
REM ================== CONFIG ==================
REM Commit message format: placeholders:
REM   prefix     -> optional prefix
REM   datetime   -> current timestamp
REM   changes    -> list of changed files or counts
SET "COMMIT_FORMAT=prefix | datetime | changes"

REM Optional prefix for commits
SET "COMMIT_PREFIX=[AUTO]"

REM Maximum number of files to list before switching to summary
SET "MAX_FILES=5"

REM Labels for added/deleted/renamed/changed files
SET "ADDED_LABEL=(A)"
SET "DELETED_LABEL=(D)"
SET "RENAMED_LABEL=(R)"
SET "CHANGED_LABEL=(C)"

REM Date/time format for commit message (PowerShell Get-Date format)
REM Examples:
REM   yyMMdd HHmm       -> 250804 1115
REM   yyyy-MM-dd HH:mm  -> 2025-08-04 11:15
REM   yyyyMMdd_HHmmss   -> 20250804_111530
SET "DATETIME_FORMAT=yyMMdd HHmm"
REM ============================================

REM Run the auto-commit script with proper quoting and named parameters
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0jj_auto_commit.ps1" ^
    -FormatPattern "%COMMIT_FORMAT%" ^
    -Prefix "%COMMIT_PREFIX%" ^
    -MaxFilesDetailed %MAX_FILES% ^
    -AddedLabel "%ADDED_LABEL%" ^
    -DeletedLabel "%DELETED_LABEL%" ^
    -RenamedLabel "%RENAMED_LABEL%" ^
    -ChangedLabel "%CHANGED_LABEL%" ^
    -DateTimeFormat "%DATETIME_FORMAT%"
```

## **How It Works**

- `auto_commit.bat` defines the commit message structure and options.  
- `jj_auto_commit.ps1`:
  1. Runs `jj status` to detect changes  
  2. Categorizes changes into **Added / Deleted / Renamed / Changed**  
  3. Builds a commit message using your chosen format  
  4. Commits automatically with `jj commit -m "..."`

---

## **Example Outputs**

### **1. Few files changed**

[AUTO] | 250804 1115 | (D) ac.bat, (R) hello.txt -> helloGG.txt, (C) jj_auto_commit.ps1

### **2. Many files changed (summary mode)**

[AUTO] | 250804 1115 | (D) ac.bat, (R) hello.txt -> helloGG.txt, (C) jj_auto_commit.ps1

### **3. Without prefix**

[AUTO] | 250804 1116 | (A): 3, (D): 1, (R): 2, (C): 5

### **3. Without prefix**

250804 1116 | (A) newfile.txt, (C) script.ps1


---

## **Notes**

- Only commits if **there are actual changes**.  
- Renames are always normalized to `old -> new` in commit messages, even if `jj status` shows `=>`.  
- `DATETIME_FORMAT` is fully configurable from the BAT file using **.NET date format strings**.  
- When the number of changed files **exceeds `MAX_FILES`**, the message switches to summary mode using counts.  
- Labels `(A)/(D)/(R)/(C)` are fully configurable.  
