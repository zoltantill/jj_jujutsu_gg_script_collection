@echo off
REM =====================================================================
REM Backup the current folder using the PowerShell script in the same directory
REM By default, just calls the script with no parameters
REM (the script will then use its own folder as the source)
REM =====================================================================

REM To customize, uncomment and modify the lines below as needed.

REM --- Example 1: Use current folder as source with default settings ---
REM powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0backup_repo.ps1"

REM --- Example 2: Use specific folders as sources ---
REM powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0backup_repo.ps1" -RepoPaths "C:\Projects","D:\Notes"

REM --- Example 3: Customize backup root, included files, and excluded directories ---
REM powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0backup_repo.ps1" ^
REM   -BackupRoot "C:\MyBackups" ^
REM   -Include "*.md","*.ps1","*.bat" ^
REM   -ExcludeDirs ".git",".jj"

REM --- Example 4: Use current folder as source, but with custom settings ---
REM set "CURDIR=%CD%"
REM set "BACKUPROOT=C:\Backups"
REM set "INCLUDE=*.md","*.ps1","*.bat","*.yml","*.json","*.txt"
REM set "EXCLUDEDIRS=.git",".jj"
REM powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0backup_repo.ps1" ^
REM   -RepoPaths "%CURDIR%" ^
REM   -BackupRoot "%BACKUPROOT%" ^
REM   -Include %INCLUDE% ^
REM   -ExcludeDirs %EXCLUDEDIRS%

REM =====================================================================
REM Default call: just run the PowerShell script with no parameters
REM =====================================================================
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0backup_repo.ps1"

pause

REM - Made by https://github.com/zoltantill