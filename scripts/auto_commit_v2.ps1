param(
    [string]$FormatPattern,    # e.g. "prefix | datetime | changes"
    [string]$Prefix,
    [int]$MaxFilesDetailed = 5,
    [string]$AddedLabel,
    [string]$DeletedLabel,
    [string]$RenamedLabel,
    [string]$ChangedLabel,
    [string]$DateTimeFormat = "yyyy-MM-dd HH:mm:ss"  # Default if not provided
)

###############################################################################
# FUNCTIONS
###############################################################################

function Get-ChangedFiles {
    # Fetch the changed files from JJ
    $rawStatus = jj status
    $result = @()

    foreach ($line in $rawStatus) {
        $trimmed = $line.Trim()

        switch -Regex ($trimmed) {
            # New files (untracked)
            '^\?\?' { 
                $result += [PSCustomObject]@{ Type = "A"; File = ($trimmed -split '\s+')[1] } 
            }
            # Added
            '^A'    { 
                $result += [PSCustomObject]@{ Type = "A"; File = ($trimmed -split '\s+')[1] } 
            }
            # Deleted
            '^D'    { 
                $result += [PSCustomObject]@{ Type = "D"; File = ($trimmed -split '\s+')[1] } 
            }
            # Renamed
            '^R'    {
                # Normalize arrows: '=>' or any =>/-> variations
				$normalizedLine = $trimmed -replace '=>', '->'

                # Case 1: Standard "old -> new"
                if ($normalizedLine -match '^(?:R\s+)(.+?)\s*->\s*(.+)$') {
                    $oldFile = $matches[1].Trim('{} ')
                    $newFile = $matches[2].Trim('{} ')
                    $result += [PSCustomObject]@{ Type = "R"; File = "$oldFile -> $newFile" }
                }
                else {
                    # Case 2: JJ outputs something like R {hello.txt}
                    $parts = $normalizedLine -split '\s+',2
                    if ($parts.Count -gt 1) {
                        $renamedFile = $parts[1].Trim('{} ')
                        $result += [PSCustomObject]@{ Type = "R"; File = $renamedFile }
                    }
                }
            }
            # Modified
            '^M'    { 
                $result += [PSCustomObject]@{ Type = "C"; File = ($trimmed -split '\s+')[1] } 
            }
        }
    }

    return $result
}

function Build-FileDescription {
    param(
        [array]$ChangedFiles,
        [int]$MaxDetailed,
        [string]$AddedLabel,
        [string]$DeletedLabel,
        [string]$RenamedLabel,
        [string]$ChangedLabel
    )

    if ($ChangedFiles.Count -eq 0) { return "" }

    $labels = @{
        A = $AddedLabel
        D = $DeletedLabel
        R = $RenamedLabel
        C = $ChangedLabel
    }

    if ($ChangedFiles.Count -le $MaxDetailed) {
        # Detailed mode: list all files, grouped by type
        $grouped = $ChangedFiles | Group-Object Type
        $segments = @()

        foreach ($group in 'A','D','R','C') {
            $groupEntry = $grouped | Where-Object { $_.Name -eq $group }
            if ($null -ne $groupEntry) {
                # Safely join the files as strings to avoid { ... } formatting
                $files = $groupEntry.Group.File | ForEach-Object { $_.ToString() }
                $segments += "$($labels[$group]) " + ($files -join ", ")
            }
        }

        return ($segments -join ", ")
    } else {
        # Summary mode: only counts
        $counts = @{
            A = ($ChangedFiles | Where-Object { $_.Type -eq 'A' }).Count
            D = ($ChangedFiles | Where-Object { $_.Type -eq 'D' }).Count
            R = ($ChangedFiles | Where-Object { $_.Type -eq 'R' }).Count
            C = ($ChangedFiles | Where-Object { $_.Type -eq 'C' }).Count
        }
        return "$($labels['A']): $($counts.A), $($labels['D']): $($counts.D), $($labels['R']): $($counts.R), $($labels['C']): $($counts.C)"
    }
}

function Build-CommitMessage {
    param(
        [string]$FormatPattern,
        [string]$Prefix,
        [array]$ChangedFiles,
        [int]$MaxDetailed,
        [string]$AddedLabel,
        [string]$DeletedLabel,
        [string]$RenamedLabel,
        [string]$ChangedLabel,
        [string]$DateTimeFormat
    )

    # Use format from BAT file
    $timestamp = (Get-Date).ToString($DateTimeFormat)

    # Build the file description string
    $fileInfo  = Build-FileDescription -ChangedFiles $ChangedFiles -MaxDetailed $MaxDetailed `
                 -AddedLabel $AddedLabel -DeletedLabel $DeletedLabel `
                 -RenamedLabel $RenamedLabel -ChangedLabel $ChangedLabel

    # Literal replacement (no regex escaping)
    $message = $FormatPattern
    $message = $message.Replace("prefix", $Prefix)
    $message = $message.Replace("datetime", $timestamp)
    $message = $message.Replace("changes", $fileInfo)

    # Clean up any extra pipes if prefix or file info is empty
    $message = $message -replace '\s*\|\s*', ' | '
    $message = $message -replace '(^\s*\|\s*|\s*\|\s*$)', ''
    $message = $message.Trim()

    return $message
}

function Perform-Commit {
    param(
        [string]$Message
    )
    # Jujutsu automatically tracks all changes; no 'jj add' needed
    jj commit -m "$Message"
}

###############################################################################
# MAIN
###############################################################################

Write-Host "[INFO] Checking for changes..."
$files = Get-ChangedFiles

if ($files.Count -eq 0) {
    Write-Host "[INFO] No changes detected. Skipping commit."
    exit 0
}

$msg = Build-CommitMessage -FormatPattern $FormatPattern -Prefix $Prefix `
                           -ChangedFiles $files -MaxDetailed $MaxFilesDetailed `
                           -AddedLabel $AddedLabel -DeletedLabel $DeletedLabel `
                           -RenamedLabel $RenamedLabel -ChangedLabel $ChangedLabel `
                           -DateTimeFormat $DateTimeFormat

Write-Host "[INFO] Commit message:" $msg

Perform-Commit -Message $msg
Write-Host "[INFO] Auto-commit completed."
