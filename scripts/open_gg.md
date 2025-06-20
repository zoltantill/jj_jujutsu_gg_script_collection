## GG Quick Launcher Batch File

The `open_gg.bat` file is a simple batch script to launch the GG graphical interface for Jujutsu (JJ) from your Obsidian vault.

> **Important:**  
> The GG executable's folder is **not** automatically added to the Windows system PATH.  
> You must add the GG folder to your PATH environment variable manually once before using this script.

**open_gg.bat** content:

```bash
@echo off
cd /d "%~dp0"
start "" "gg"
exit
```

### How it works

- `@echo off`  
  Turns off command echoing for a cleaner output.

- `cd /d "%~dp0"`  
  Changes the working directory to the folder where the batch file is located.  
  This ensures that `gg` is launched from the correct directory, regardless of where you run the batch file from.

- `start "" "gg"`  
  Starts the `gg` application (the GUI for Jujutsu).  
  Make sure that the `gg.exe` (or the appropriate executable) is in the same folder as this batch file, or is in your system `PATH`.

- `exit`  
  Closes the command prompt window after launching GG.

### Usage Instructions

1. **Add GG to PATH:**  
   Add the folder containing the `gg` executable to your Windows system PATH environment variable.  
   This step needs to be done only once.

2. **Place the Batch File:**  
   Copy `open_gg.bat` into the root of your repository (the folder you want to use GG with, containing your `.git` and/or `.jj` directories).

3. **Launch GG:**  
   Double-click `open_gg.bat` in your repository folder to launch the GG interface in the context of that repository.

> **Note:**  
> The batch file must be placed in the directory you want to work with.  

This setup allows you to quickly open GG for any folder, provided the PATH is set up as described.

> **Tip:**  
> You can create a shortcut to `open_gg.bat` on your desktop or taskbar for even faster access.

---

