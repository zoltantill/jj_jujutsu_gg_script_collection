# jj_jujutsu_gg_script_collection

I love using [Jujutsu (JJ) VCS](https://github.com/jj-vcs/jj) and its GUI, [GG](https://github.com/gulbanana/gg). 
To make my workflow more practical, I created a few batch and PowerShell scripts.

These scripts are designed for Windows. If you are using a Mac, you may need to create alternative scripts.

## Scripts

This repository contains several batch and PowerShell scripts to make working with Jujutsu (JJ) and GG easier on Windows.

### `init_git_jj.ps1`

Initializes both Git and Jujutsu (JJ) version control in the current folder.  
**Usage:** Right-click the script and select "Run with PowerShell".  
For detailed instructions and tips, see [init_git_jj.md](scripts/init_git_jj.md).

Note:
Setting up both Git and JJ in this way makes your repository more compatible with other Git tools, external repositories, and advanced diff viewers. This allows you to continue using popular Git-based GUIs, IDE integrations, and diff tools (like WinMerge, Meld, or SourceTree) seamlessly, while also benefiting from JJ’s features and workflow.

This approach ensures that:
 - Git-based tools (IDEs, build systems, CI/CD pipelines) recognize your repository as a standard Git repo and function normally.
 - You can collaborate with others using Git without any disruption, as all Git commands and workflows remain available.
 - You gain access to JJ’s unique features and safety net, while maintaining full interoperability with the broader Git ecosystem.
 - This is a widely recommended best practice for users who want the flexibility of JJ alongside the broad compatibility of Git tools.
 
### convert_to_utf8.ps1 and convert_to_utf8.bat

This PowerShell script quickly converts files with various common text-based extensions (such as .cls, .bas, .md, .txt, .csv, .sql, .rpt, .qry) from ANSI or other legacy encodings to UTF-8 without BOM.
It is especially useful if you encounter the GG error:
'invalid utf-8 sequence of 1 bytes from index ...',
which typically appears when a file is not properly encoded in UTF-8.
A batch file is included for easier execution.
Be sure to make a backup before using this script.

