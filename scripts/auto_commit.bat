@echo off
setlocal enabledelayedexpansion

REM Get current datetime
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set fullstamp=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%
set logfile=auto_commit.log

REM 1. Check for repository changes
jj status | findstr /C:"no changes" >nul
if %errorlevel% neq 0 (
    set "HAS_CHANGES=1"
) else (
    set "HAS_CHANGES=0"
)

REM 2. Check current commit description
set "desc="
for /f "delims=" %%A in ('jj log -r @ --no-graph ^| more +1') do (
    set "desc=!desc!%%A"
)
set "descStripped=!desc: =!"
set "descStripped=!descStripped:	=!"
if /i "!descStripped!"=="(nodescriptionset)" set "descStripped="
if "!descStripped!"=="" (
    set "HAS_DESCRIPTION=0"
) else (
    set "HAS_DESCRIPTION=1"
)

REM 3. Execute actions based on conditions

if "!HAS_DESCRIPTION!"=="0" (
        REM Add description to current commit
        jj describe -m "Automatic commit: !fullstamp!"
        if !errorlevel! equ 0 (
            echo [!fullstamp!] Description added >> !logfile!
            echo ✓ Description added
        ) else (
            echo [!fullstamp!] Description update failed >> !logfile!
            echo ✗ Description update failed
        )
    )

if "!HAS_CHANGES!"=="1" (
        REM Create new commit without modifying existing description
        jj new
        if !errorlevel! equ 0 (
            echo [!fullstamp!] New commit created >> !logfile!
            echo ✓ New commit created
        ) else (
            echo [!fullstamp!] New commit failed >> !logfile!
            echo ✗ New commit failed
        )
    )

REM echo.
REM pause
endlocal

REM - Made by https://github.com/zoltantill
