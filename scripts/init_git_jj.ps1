# Safe initialization script for Git and Jujutsu (JJ) repositories
# This script NEVER overwrites, deletes, or modifies existing repos or config.
# It avoids all risky operations: if only a JJ repo exists, it does NOTHING and warns the user.
# If both .git and .jj exist, it does nothing.
# If only .git exists, it safely initializes JJ in colocated mode.
# If neither exists, it safely initializes both.

# Check if the .git directory exists in the current folder
$gitExists = Test-Path -Path .git -PathType Container

# Check if the .jj directory exists in the current folder
$jjExists = Test-Path -Path .jj -PathType Container

if ($gitExists -and $jjExists) {
    # Both .git and .jj directories exist; nothing to do
    Write-Output "Both (.git and .jj) directories exist. No action needed."
	exit 0
}
elseif ($gitExists -and -not $jjExists) {
    # .git exists but .jj does not; initialize JJ in colocated mode
    Write-Output "[OK] Git repo detected. Initializing Jujutsu in colocated mode..."
    try {
        jj git init --colocate . 2>&1 | Out-Null
        Write-Output "JJ initialized successfully. Repository ready."
        exit 0
    } catch {
        Write-Error "Failed to initialize JJ: $_"
        exit 1
    }
}
elseif (-not $gitExists -and $jjExists) {
    # Only JJ exists, this is a risky situation. Do nothing!
    Write-Warning "Only JJ repository found, no Git. This is a risky case, the script will NOT proceed!"
    Write-Warning "Manual intervention required. Automatic Git initialization is disabled for safety."
    exit 1
}
else {
    # Neither .git nor .jj exists; initialize both in colocated mode
    Write-Output "Neither .git nor .jj directory exists. Initializing Git and JJ in colocated mode."
	git init 2>&1 | Out-Null
    jj git init --colocate . 2>&1 | Out-Null
    Write-Output "[SUCCESS] New Git and JJ repositories created."
    exit 0
}

# Made by https://github.com/zoltantill
