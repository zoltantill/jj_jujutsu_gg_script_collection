$title = "Backup Confirmation"
$question = "Have you made a backup of your files?"
$choices = "&Yes", "&No"
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -ne 0) {
    Write-Host "Please create a backup before running this script. Exiting."
    exit
}

# List of file extensions to convert to UTF-8 without BOM
$extensions = '.cls', '.bas', '.md', '.txt', '.csv', '.sql', '.rpt', '.qry', '.json', '.xml', '.js', '.ts', '.css', '.ini', '.conf', '.log', '.py', '.sh', '*.bat'

# Create a UTF-8 encoding object without BOM
$Utf8NoBom = New-Object System.Text.UTF8Encoding $False

# Recursively find all files matching the given extensions
Get-ChildItem -Path . -Recurse -Include $extensions | ForEach-Object {
	
    # Read the entire file content as a single string
    $content = Get-Content -LiteralPath $_.FullName -Raw
	
    # Overwrite the file with UTF-8 encoding (no BOM)
    [System.IO.File]::WriteAllText($_.FullName, $content, $Utf8NoBom)
	
    # Print the converted file path to the console
    Write-Host "Converted: $($_.FullName)"
}

# Made by https://github.com/zoltantill