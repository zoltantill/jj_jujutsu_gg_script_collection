# `init_git_jj.ps1` – Git and Jujutsu (JJ) Initialization Script

## Init Git and JJ for GitHub Projects

If you're working with GitHub repositories and want to use advanced diff viewers, it's often helpful to initialize both Git and Jujutsu (JJ) version control in your project folder. This script and guide are tailored for GitHub users who want seamless integration and flexibility with their development tools.

---

## Why Use Git and JJ Together?

- **GG's built-in diff viewer** can be limiting due to its small window size.
- By initializing Git first, then JJ, you can easily use any external diff tool (e.g., WinMerge, Meld) for a better comparison experience.
- This setup is especially useful if you manage your code on GitHub and want seamless integration with popular GUI tools.

---

## What Does This Script Do?

- **Automatically sets up** Git and JJ version control for your project.
- **Links** the two systems so they work together in colocated mode.
- **Avoids redundant initialization**: only creates what’s missing.
- **Adds the `.jj` folder to `.gitignore`** to prevent JJ’s internal files from being tracked by Git.

---

## Usage

1. **Copy the script** to the root of your project folder (where you want version control).
2. **Right-click** the `init_git_jj.ps1` file and select **"Run with PowerShell"**.
3. The script will perform the necessary steps and print out what actions were taken.

> **Note:**  
> You only need to run this script once per folder. After that, you can use both Git and JJ together.

---

## How the Script Works

The script handles four scenarios:

1. **Both systems exist (`.git` and `.jj` folders):**  
   - Nothing is done; everything is already set up.

2. **Only Git exists (`.git` exists, `.jj` does not):**  
   - Initializes JJ alongside Git (colocated mode).

3. **Only JJ exists (`.jj` exists, `.git` does not):**  
   - Initializes Git.
   - Configures JJ to use the Git repository as its backend.
   - Adds `.jj` to `.gitignore` and commits the change.

4. **Neither exists:**  
   - Initializes both Git and JJ in colocated mode.


---

## Recommended Diff Workflow

- **SourceTree** (free, supports dark mode) + **WinMerge** (free, supports dark mode) is a great combo for visualizing diffs.
- In SourceTree, select two versions (commits) above, one file below, then press `CTRL+D` to launch the diff viewer.

---

## Tips & Notes

- **Permissions:** You may need to adjust your PowerShell execution policy to run scripts.  
  Check with `Get-ExecutionPolicy` and set with `Set-ExecutionPolicy` if necessary.
- **Paths:** If your `.git` or `.jj` folders are not in the default locations, adjust the `$gitRelativePath` variable accordingly.
- **Platform:** This script is intended for Windows environments with PowerShell.

---

## Troubleshooting

- If you encounter errors, make sure both **Git** and **JJ (Jujutsu)** are installed and available in your system’s PATH.
- If `.gitignore` already contains `/.jj`, the script will append another entry; this is harmless, but you can edit it if you prefer.

---

**Author:**  
https://github.com/zoltantill


---

If you have questions or encounter issues, please open an issue in the repository.
