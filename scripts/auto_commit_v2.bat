@echo off
REM ================== CONFIG ==================
REM Commit message format: placeholders:
REM   prefix     -> optional prefix
REM   datetime   -> current timestamp
REM   changes    -> list of changed files or counts
SET "COMMIT_FORMAT=prefix | datetime | changes"

REM Optional prefix for commits
SET "COMMIT_PREFIX=|auto"

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
SET "DATETIME_FORMAT=yyMMdd.HHmm"
REM ============================================

REM Run the auto-commit script with proper quoting and named parameters
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0jj_auto_commit_v2.ps1" ^
    -FormatPattern "%COMMIT_FORMAT%" ^
    -Prefix "%COMMIT_PREFIX%" ^
    -MaxFilesDetailed %MAX_FILES% ^
    -AddedLabel "%ADDED_LABEL%" ^
    -DeletedLabel "%DELETED_LABEL%" ^
    -RenamedLabel "%RENAMED_LABEL%" ^
    -ChangedLabel "%CHANGED_LABEL%" ^
    -DateTimeFormat "%DATETIME_FORMAT%"
