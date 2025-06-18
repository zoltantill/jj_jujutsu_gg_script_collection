# `auto_commit.bat` – Automated JJ Commit Script

## Overview

`auto_commit.bat` is a Windows batch script designed to automate version control in a Jujutsu (JJ) repository.  
It is especially useful for users who want to ensure regular, automatic commits of their work (e.g., an Obsidian vault) without manual intervention.  
The script is typically set to run at Windows startup, providing daily or session-based version snapshots with timestamped commit messages.

---

## Why Use This Script?

- **Automated versioning:**  
  Ensures that all changes are regularly committed, even if you forget to do so manually.
- **Reliable backups:**  
  Maintains a history of your notes or files, making it easy to restore previous versions.
- **Minimal setup:**  
  No need for additional tools or manual tracking—just schedule the script to run automatically.
- **JJ compatibility:**  
  Works natively with Jujutsu (JJ), but the logic is similar to popular auto-commit solutions for Git repositories.

---

## How It Works

1. **Checks for changes:**  
   The script runs `jj status` to detect if there are uncommitted changes in the repository.
2. **Automatic commit or description update:**  
   - If the latest commit lacks a description, it sets the description with the current date and time.
   - If changes are found, it creates a new commit without a description.
3. **Logging:**  
   All actions (commits, updates, errors) are logged to `auto_commit.log` for later review.
4. **Runs at startup:**  
   You can configure this script to run automatically when Windows starts, ensuring consistent versioning.

---

## Usage

1. Place `auto_commit.bat` in your JJ repository folder (e.g., your Obsidian vault).
2. (Optional) Set up the script to run at Windows startup using Task Scheduler or by placing a shortcut in the Startup folder.
3. The script will check for changes and commit them automatically with a timestamped message.

---

## Why Jujutsu (JJ)?

One of the main reasons for using Jujutsu (JJ) is its powerful ability to split and reorganize commits even after they have been created. With JJ, it is easy to later break up large, automatic commits into smaller, meaningful chunks using commands like `jj split` or `jj squash`.  
This workflow is much more flexible compared to traditional Git, as JJ treats changes and commits as distinct concepts, allowing you to retroactively edit, split, or reorder your commit history with ease.

For example, after a period of automatic commits, you can review your work and interactively split a commit into logical pieces, making your history cleaner and easier to understand or review later.

---

## Example: Setting Up Automatic Commits for an Obsidian Vault

- Place `auto_commit.bat` in your Obsidian vault folder.
- Use Windows Task Scheduler to run the script at login or at a set interval.
- The script will automatically commit any changes, ensuring your notes are always versioned.

---

## Tips & Recommendations

- **Customization:**  
  You can further refine the script to exclude certain files or directories, or to use more descriptive commit messages.
- **Combine with backup:**  
  For maximum safety, use this script alongside a cloud backup solution (e.g., Google Drive, Dropbox).
- **Review the log:**  
  Check `auto_commit.log` periodically to ensure commits are being made as expected.

---

## References and Further Reading

- [Chris Krycho: jj init — Sympolymathesy](https://v5.chriskrycho.com/essays/jj-init/)  
  (Deep-dive into Jujutsu’s concepts, workflow, and advantages over Git)
- [Hacker News: Jujutsu discussion](https://news.ycombinator.com/item?id=36952796)  
  (Community experiences and practical tips for working with JJ)
- [Reasonably Polymorphic: Jujutsu Strategies](https://reasonablypolymorphic.com/blog/jj-strategy/)  
  (Commit splitting and advanced JJ workflows)
- [GitHub Action for auto-committing changes](https://github.com/stefanzweifel/git-auto-commit-action)  
- [Auto-commit solutions for Git](https://github.com/marketplace/actions/git-auto-commit)  
- [How to write good commit messages](https://gist.github.com/lisawolderiksen/a7b99d94c92c6671181611be1641c733)  
- [Stack Overflow: Making Git auto commit](https://stackoverflow.com/questions/420143/making-git-auto-commit)

---

**Author:**  
https://github.com/zoltantill

---

If you have questions or encounter issues, please open an issue in the repository.
