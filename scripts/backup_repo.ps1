<#
.SYNOPSIS
Backs up specified repositories to a target directory with timestamped folders, preserves original file creation and modification dates, provides detailed logging, and manages the console window on completion.

.DESCRIPTION
Creates timestamped backups of multiple repositories while maintaining original file creation 
and modification dates. On success, closes the window after 2 seconds; on failure, displays 
error details and keeps window open.

.PARAMETER RepoPaths
Array of repository paths to back up (e.g., @("C:\Repo1", "D:\ObsidianVault"))

.PARAMETER BackupRoot
Root directory where backups will be stored (default: "C:\Backups")

.PARAMETER Include
File extensions/patterns to include (default: "*.md", "*.ps1", "*.bat", "*.yml", "*.json", "*.txt")

.PARAMETER ExcludeDirs
Directories to exclude from backup (default: ".git", ".jj")

.PARAMETER LogPath
Path to the CSV log file (default: "C:\Backups\backup_log.csv")

.EXAMPLE
.\backup_repo.ps1
Backups the current script directory.

.EXAMPLE
.\backup_repo.ps1 -RepoPaths "C:\MyRepo", "D:\Notes" -ExcludeDirs ".git", ".cache"
Backups multiple repositories with custom exclusions.
#>

param(
    [Parameter(Mandatory=$false)]
    [string[]]$RepoPaths = @($PSScriptRoot),
    
    [string]$BackupRoot = "D:\Backups",
    [string[]]$Include = @("*.md", "*.ps1", "*.bat", "*.yml", "*.json", "*.txt", "*.csv", "*.bas", "*.cls"),
    [string[]]$ExcludeDirs = @(".git", ".jj"),
    [string]$LogPath = "$BackupRoot\backup_log.csv"
)

# Initialize console title
$host.UI.RawUI.WindowTitle = "Backup Script"

# Create backup root and log directory if they don't exist
New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null
New-Item -ItemType Directory -Path (Split-Path $LogPath) -Force | Out-Null

# Initialize log file with headers if it doesn't exist
if (-not (Test-Path $LogPath)) {
    "Timestamp,RepoPath,BackupPath,Status,Error" | Out-File $LogPath -Encoding UTF8
}

$globalErrorOccurred = $false
$errorDetails = @()

foreach ($repo in $RepoPaths) {
    $repoName = Split-Path $repo -Leaf
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupDir = Join-Path $BackupRoot "$repoName\$timestamp"
    
    $logEntry = [PSCustomObject]@{
        Timestamp  = Get-Date -Format "o"
        RepoPath   = $repo
        BackupPath = $backupDir
        Status     = $null
        Error      = $null
    }

    try {
        # Validate source directory
        if (-not (Test-Path $repo -PathType Container)) {
            throw "Source directory does not exist: $repo"
        }

        # Create backup directory
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

        # Copy files using robocopy with retry logic
        $robocopyArgs = @(
            $repo,
            $backupDir,
            $Include,
            "/S",        # Copy subdirectories
            "/NP",       # No progress indicator
            "/NFL",      # No file list
            "/NDL",      # No directory list
            "/R:3",      # Retry 3 times
            "/W:5"       # Wait 5 seconds between retries
        )
        
        # Add exclusion parameters if needed
        if ($ExcludeDirs) {
            $robocopyArgs += "/XD"
            $robocopyArgs += $ExcludeDirs
        }
		
        $robocopyLog = robocopy @robocopyArgs 2>&1
        $exitCode = $LASTEXITCODE

        # Capture failed files/errors
        $failedItems = $robocopyLog | Where-Object { 
            $_ -match "ERROR" -or $_ -match "failed" -or $_ -match "not exist"
        }

        if ($exitCode -ge 8) {
            throw "Robocopy failed with exit code $exitCode.`n$($failedItems -join "`n")"
        }

        $logEntry.Status = "Success"
		
        # Restore original timestamps
        Write-Host "Restoring original timestamps for copied files..."

        $sourceFiles = Get-ChildItem -Path $repo -Recurse -File -Include $Include | Where-Object {
            $exclude = $false
            foreach ($ex in $ExcludeDirs) {
                if ($_.FullName -like "*\$ex\*") { $exclude = $true }
            }
            -not $exclude
        }

        foreach ($srcFile in $sourceFiles) {
            $relPath = $srcFile.FullName.Substring($repo.Length).TrimStart('\','/')
            $dstFile = Join-Path $backupDir $relPath

            if (Test-Path $dstFile) {
                try {
                    $dstItem = Get-Item $dstFile
                    # Preserve both timestamps
                    $dstItem.CreationTime = $srcFile.CreationTime
                    $dstItem.LastWriteTime = $srcFile.LastWriteTime
                } catch {
                    Write-Warning "Failed to set timestamps: $dstFile"
                }
            }
        }
		
    }
    catch {
        $globalErrorOccurred = $true
        $logEntry.Status = "Failed"
        $logEntry.Error = $_.Exception.Message
        $errorDetails += "=== ERROR IN REPO: $repo ==="
        $errorDetails += $_.Exception.Message
        $errorDetails += "============================="
    }
    finally {
        # Write to CSV log
        $logEntry | Select-Object Timestamp, RepoPath, BackupPath, Status, Error |
            Export-Csv $LogPath -Append -NoTypeInformation -Encoding UTF8
    }
}

# Window management logic
if ($globalErrorOccurred) {
    Write-Host "`n=== BACKUP FAILED ===" -ForegroundColor Red
    $errorDetails | ForEach-Object { Write-Host $_ -ForegroundColor Red }
    Write-Host "`nPress Enter to exit..."
    Read-Host
}
else {
    Write-Host "`nAll backups completed successfully. Closing in 2 seconds..." -ForegroundColor Green
    Start-Sleep -Seconds 2
    exit
}
