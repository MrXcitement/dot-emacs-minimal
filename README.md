# Personal Emacs Configuration (Minimal)

## Summary
A personal minimal setup for emacs.
Influenced by: [Emacs for You (Emfy)](https://github.com/susam/emfy)

### Requirements
Emacs 26 or greater, best with Emacs 28+

## Installation
- Backup any existing Emacs configuration in `$HOME/.emacs.d` before you install this new one.
- Clone this repository to a folder you have access to. I would recommend `$HOME/.config/emacs-minimal`.
- You can then symlink the `./home/.emacs-d` folder to your default `$HOME/.emacs.d` folder.
- If you would like to have multiple emacs configurations, checkout [chemacs2](https://github.com/plexus/chemacs2) and configure chemacs2 to use the `$HOME/.config/emacs-minimal/home/.emacs-d` folder as one of the profiles available to use.

### Install Scripts
There are two shell scripts that will link the config folder to `$HOME/.emacs.d` for you. The one with no file extension is a `bash` script and can be used on Linux and macOS systems. The `install.ps1` script can be used on Windows and is a powershell script.
