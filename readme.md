MMBNLC Pixel Font mod
=====================

This is a mod for Mega Man Battle Network Legacy Collection which replaces the game's high-resolution Courier-based font with the original pixel fonts from the GBA games.


Features
--------

* Replaces the Courier-based font in all 6 games with a pixel font based on the original GBA games.

* Works around a glitch where font shadows are rendered too dark. The font shadows have been individually adjusted for all games to accommodate various situations in the games.

* Also replaces the bold font used for e.g. chip names in MMBN3, 4, 5, 6 with the original pixel font, in order to work around the above issue there too.

Note: This mod updates the fonts for text which is dynamically rendered. Some in-game localized assets may still use a high-resolution font. These may be replaced in a future version.

Note: The pixel fonts are not affected by the high-resolution filter option.


Installing
----------

Windows PC and Steam Deck

1. Launch Steam in Desktop Mode. Right-click the game in Steam, then click Properties → Local Files → Browse to open the game's install folder. Then open the "exe" folder, where you'll find MMBN_LC1.exe or MMBN_LC2.exe.

2. Download and install bnlc-mod-loader in this folder: https://github.com/bigfarts/bnlc-mod-loader/releases

3. Create a "mods" folder in the same folder, if it doesn't yet exist.

4. Copy the PixelFont_Vol1 (for MMBNLC Vol. 1) or PixelFont_Vol2 (for MMBNLC Vol. 2) folder to the "mods" folder.

5. Launch the game via Steam.

Nintendo Switch

To be added.


Building
--------

Building is supported on Windows 10 & 11. First install the following prerequisites:

* Python 3
* 7-Zip. Expected install location is C:\Program Files\7-Zip, otherwise update the 7Z variable in make.bat.
* Mega Man Battle Network Legacy Collection Volume 1 and/or 2. Expected install location is C:\Program Files (x86)\Steam\steamapps\common, otherwise update the VOL1_DIR and/or VOL2_DIR variable(s) in make.bat.
* Install required Python packages for MMBNLC-Scripts: pip install Pillow numpy

Then, run one of the following commands:

* make - Builds the mod files compatible with bnlc-mod-loader. You can only build this mod when MMBN Legacy Collection Volume 1 and/or 2 is installed, the make script will build the mod files for the volume(s) you have installed.
* make clean - Removes all temporary files and build outputs.
* make install - Installs the previously built mod files into the mods folder for bnlc-mod-loader.
* make uninstall - Removes the installed mod files from the mods folder for bnlc-mod-loader.
