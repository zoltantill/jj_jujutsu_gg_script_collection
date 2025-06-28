## Git and GG Installation Guide (Windows)

### 1. Install Git

1. **Download Git for Windows:**
   - Go to the official website: [https://git-scm.com/download](https://git-scm.com/download)
   - Click the "Download" button to get the latest version.

2. **Run the Installer:**
   - Locate the downloaded installer (e.g., `Git-2.x.x-64-bit.exe`) and double-click it.
   - Click "Next" through the setup screens. The default options are fine for most users.
   - When prompted, allow Git to be added to your system PATH (recommended: "Use Git from the Windows Command Prompt").
   - Complete the installation.

3. **Verify Installation:**
   - Open Command Prompt or PowerShell.
   - Type:
     ```
     git --version
     ```
   - You should see the installed Git version.


### 2. GG Installation Guide (Windows)

1. **Download GG:**
   - Go to the [GG releases page](https://github.com/gulbanana/gg/releases).
   - Download the latest Windows version (`gg.exe` or installer `.msi`).

2. **Install or Extract:**
   - If you downloaded the installer (`.msi`), run it and follow the instructions.
   - If you downloaded `gg.exe`, place it in a folder of your choice (e.g., `C:\tools\gg`).

3. **(Optional) Add GG to PATH:**
   - For easier access from any directory, add the folder containing `gg.exe` to your Windows system PATH.
   - Press `Win + R`, type `sysdm.cpl`, press Enter.
   - Go to the **Advanced** tab → **Environment Variables**.
   - Under **System variables**, select `Path` → **Edit** → **New**, then add the path (e.g., `C:\tools\gg`).
   - Click **OK** to save.

4. **Launch GG:**
   - Double-click `gg.exe`, or run `gg` from any command prompt if PATH is set.

> **Note:**  
> You do **not** need to install JJ separately for basic usage with GG.  
> For advanced command-line operations, you may still want to install JJ: [Jujutsu releases](https://github.com/martinvonz/jj/releases).

---

**You are now ready to use both Git and GG from any directory in your system!**


Written by https://github.com/zoltantill