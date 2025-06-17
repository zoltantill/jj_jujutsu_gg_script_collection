# Check if the .git directory exists in the current folder
$gitExists = Test-Path -Path .git -PathType Container

# Check if the .jj directory exists in the current folder
$jjExists = Test-Path -Path .jj -PathType Container

if ($gitExists -and $jjExists) {
    # Both .git and .jj directories exist; nothing to do
    Write-Output "Both (.git and .jj) directories exist. No action needed."
}
elseif ($gitExists -and -not $jjExists) {
    # .git exists but .jj does not; initialize JJ in colocated mode
    Write-Output ".git exists, but .jj does not. Initializing JJ alongside Git (colocated)."
    jj git init --colocate .
}
elseif (-not $gitExists -and $jjExists) {
    # .jj exists but .git does not; initialize Git and configure JJ to use it
    Write-Output ".jj exists, but .git does not. Initializing Git and configuring JJ to use it."
    git init
    # Set up JJ to use the Git repository as its backend
   if (-not (Test-Path -Path .jj\repo\store -PathType Container)) {
        New-Item -Path .jj\repo\store -ItemType Directory -Force
    }
    $gitAbsolutePath = (Resolve-Path -Path ".git").Path.Replace("\", "/")
    Set-Content -Path .jj\repo\store\git_target -Value $gitAbsolutePath
    
    Add-Content -Path .gitignore -Value "/.jj"
    git add .gitignore
    git commit -m "Add .jj to .gitignore"
}
else {
    # Neither .git nor .jj exists; initialize both in colocated mode
    Write-Output "Neither .git nor .jj directory exists. Initializing Git and JJ in colocated mode."
    git init
    jj git init --colocate .
}

# Made by https://github.com/zoltantill
