@echo off
setlocal enabledelayedexpansion

rem Mod info
set "MOD_DIR=PixelFont"

rem Install locations
set "7Z=C:\Program Files\7-Zip\7z.exe"
set "VOL1_DIR=C:\Program Files (x86)\Steam\steamapps\common\MegaMan_BattleNetwork_LegacyCollection_Vol1"
set "VOL2_DIR=C:\Program Files (x86)\Steam\steamapps\common\MegaMan_BattleNetwork_LegacyCollection_Vol2"

rem Temporary folder
set "TEMP_DIR=temp"
set "BUILD_DIR=build"
set "BUILD_DIR_VOL1=!BUILD_DIR!\!MOD_DIR!_Vol1"
set "BUILD_DIR_VOL2=!BUILD_DIR!\!MOD_DIR!_Vol2"
set "INSTALL_DIR_VOL1=!VOL1_DIR!\exe\mods\!MOD_DIR!_Vol1"
set "INSTALL_DIR_VOL2=!VOL2_DIR!\exe\mods\!MOD_DIR!_Vol2"

if /I [%1]==[clean] (
	echo Removing temp folder...
	if exist "!TEMP_DIR!" (
		rmdir /S /Q "!TEMP_DIR!" ^
			1> nul || goto :error
	)
	echo Removing build folder...
	if exist "!BUILD_DIR!" (
		rmdir /S /Q "!BUILD_DIR!" ^
			1> nul || goto :error
	)
	echo.

	goto :done
)

if /I [%1]==[install] (
	for /L %%v in (1, 1, 2) do (
		if exist "!VOL%%v_DIR!" (
			if exist "!BUILD_DIR_VOL%%v!" (
				echo Installing for Volume %%v...

				echo Copying mod folder...
				if exist "!INSTALL_DIR_VOL%%v!" (
					del /F /S /Q "!INSTALL_DIR_VOL%%v!\*" 1> nul || goto :error
				) else (
					mkdir "!INSTALL_DIR_VOL%%v!" 1> nul || goto :error
				)
				robocopy /E "!BUILD_DIR_VOL%%v!" "!INSTALL_DIR_VOL%%v!" 1> nul
				if errorlevel 8 goto :error
			) else (
				echo Volume %%v not built; skipping...
			)
		) else (
			echo Volume %%v not installed; skipping...
		)
		echo.
	)

	goto :done
)

if /I [%1]==[uninstall] (
	for /L %%v in (1, 1, 2) do (
		if exist "!VOL%%v_DIR!" (
			echo Uninstalling for Volume %%v...
			if exist "!INSTALL_DIR_VOL%%v!" (
				rmdir /S /Q "!INSTALL_DIR_VOL%%v!" ^
					1> nul || goto :error
			)
		) else (
			echo Volume %%v not installed; skipping...
		)
		echo.
	)

	goto :done
)

rem Clean up temp folder
call :clean_folder "!TEMP_DIR!"

rem Build mod
for /L %%v in (1, 1, 2) do (
	if exist "!VOL%%v_DIR!" (
		echo Building for Volume %%v...

		rem Clean build folder
		if %%v equ 1 (
			call :clean_folder "!BUILD_DIR_VOL%%v!\exe1"
			call :clean_folder "!BUILD_DIR_VOL%%v!\exe2"
			call :clean_folder "!BUILD_DIR_VOL%%v!\exe3"
		)
		if %%v equ 2 (
			call :clean_folder "!BUILD_DIR_VOL%%v!\exe4"
			call :clean_folder "!BUILD_DIR_VOL%%v!\exe5"
			call :clean_folder "!BUILD_DIR_VOL%%v!\exe6"
		)

		rem Extract files
		if %%v equ 1 (
			echo Extracting files from exe1.dat...
			"!7Z!" e "!VOL%%v_DIR!\exe\data\exe1.dat" -o"!TEMP_DIR!\exe1" ^
				"exe1\data\ui\font_eng_00.pak" ^
					1> nul || goto :error
			
			echo Extracting files from exe2j.dat...
			"!7Z!" e "!VOL%%v_DIR!\exe\data\exe2j.dat" -o"!TEMP_DIR!\exe2" ^
				"exe2j\data\ui\font_eng_00.pak" ^
					1> nul || goto :error
			
			echo Extracting files from exe3.dat...
			"!7Z!" e "!VOL%%v_DIR!\exe\data\exe3.dat" -o"!TEMP_DIR!\exe3" ^
				"exe3\data\ui\font_eng_00.pak" ^
				"exe3\data\ui\menu_spr_jap_00.pak" ^
					1> nul || goto :error
		)
		if %%v equ 2 (
			echo Extracting files from exe4.dat...
			"!7Z!" e "!VOL%%v_DIR!\exe\data\exe4.dat" -o"!TEMP_DIR!\exe4" ^
				"exe4\data\ui\font8x16_eng_00.pak" ^
				"exe4\data\ui\subfont_eng_00.pak" ^
					1> nul || goto :error
	
			echo Extracting files from exe5.dat...
			"!7Z!" e "!VOL%%v_DIR!\exe\data\exe5.dat" -o"!TEMP_DIR!\exe5" ^
				"exe5\data\ui\font8x16_eng_00.pak" ^
				"exe5\data\ui\subfont_eng_00.pak" ^
					1> nul || goto :error
	
			echo Extracting files from exe6.dat...
			"!7Z!" e "!VOL%%v_DIR!\exe\data\exe6.dat" -o"!TEMP_DIR!\exe6" ^
				"exe6\data\ui\font8x16_eng_00.pak" ^
				"exe6\data\ui\subfont_eng_00.pak" ^
					1> nul || goto :error
		)

		rem Build fonts
		if %%v equ 2 (
			echo Building mojifont for EXE4...
			python3 "scripts\build_font.py" ^
				"exe4\eng_mojiFont" ^
				"!BUILD_DIR_VOL%%v!\exe4\eng_mojiFont.fnt" ^
					1> nul || goto :error
			
			echo Building mojifont for EXE5...
			python3 "scripts\build_font.py" ^
				"exe5\eng_mojiFont" ^
				"!BUILD_DIR_VOL%%v!\exe5\eng_mojiFont.fnt" ^
					1> nul || goto :error
			
			echo Building mojifont for EXE6...
			python3 "scripts\build_font.py" ^
				"exe6\eng_mojiFont" ^
				"!BUILD_DIR_VOL%%v!\exe6\eng_mojiFont.fnt" ^
					1> nul || goto :error
		)

		rem Insert files
		if %%v equ 1 (
			echo Inserting .paks for EXE1...
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe1\font_eng_00.pak" ^
				"!BUILD_DIR_VOL%%v!\exe1\font_eng_00.pak" ^
				"exe1\font_eng_00.png" ^
					1> nul || goto :error

			echo Inserting .paks for EXE2...
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe2\font_eng_00.pak" ^
				"!BUILD_DIR_VOL%%v!\exe2\font_eng_00.pak" ^
				"exe2\font_eng_00.png" ^
					1> nul || goto :error

			echo Inserting .paks for EXE3...
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe3\font_eng_00.pak" ^
				"!BUILD_DIR_VOL%%v!\exe3\font_eng_00.pak" ^
				"exe3\font_eng_00.png" ^
					1> nul || goto :error
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe3\menu_spr_jap_00.pak" ^
				"!BUILD_DIR_VOL%%v!\exe3\menu_spr_jap_00.pak" ^
				"exe3\menu_spr_jap_00.png" ^
					1> nul || goto :error
		)
		if %%v equ 2 (
			echo Inserting .paks for EXE4...
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe4\font8x16_eng_00.pak" ^
				"!BUILD_DIR_VOL2!\exe4\font8x16_eng_00.pak" ^
				"exe4\font8x16_eng_00.png" ^
					1> nul || goto :error
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe4\subfont_eng_00.pak" ^
				"!BUILD_DIR_VOL2!\exe4\subfont_eng_00.pak" ^
				"exe4\subfont_eng_00.png" ^
					1> nul || goto :error
			
			echo Inserting .paks for EXE5...
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe5\font8x16_eng_00.pak" ^
				"!BUILD_DIR_VOL2!\exe5\font8x16_eng_00.pak" ^
				"exe5\font8x16_eng_00.png" ^
					1> nul || goto :error
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe5\subfont_eng_00.pak" ^
				"!BUILD_DIR_VOL2!\exe5\subfont_eng_00.pak" ^
				"exe5\subfont_eng_00.png" ^
					1> nul || goto :error
			
			echo Inserting .paks for EXE6...
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe6\font8x16_eng_00.pak" ^
				"!BUILD_DIR_VOL2!\exe6\font8x16_eng_00.pak" ^
				"exe6\font8x16_eng_00.png" ^
					1> nul || goto :error
			python3 "scripts\insert_pak.py" ^
				"!TEMP_DIR!\exe6\subfont_eng_00.pak" ^
				"!BUILD_DIR_VOL2!\exe6\subfont_eng_00.pak" ^
				"exe6\subfont_eng_00.png" ^
					1> nul || goto :error
		)

		echo Copying info files...
		copy /Y "info.toml" "!BUILD_DIR_VOL%%v!\info.toml" ^
			1> nul || goto :error
		copy /Y "init_vol%%v.lua" "!BUILD_DIR_VOL%%v!\init.lua" ^
			1> nul || goto :error
	) else (
		echo Volume %%v not installed; skipping...
	)
	echo.
)

rem Copy miscellaneous files
copy /Y "readme.md" "!BUILD_DIR!\readme.txt" ^
	1> nul || goto :error

:done
echo Done.
echo.
exit /b 0

:error
echo Error occurred, failed to build.
echo.
exit /b 1

:clean_folder
if exist "%1" (
	del /F /S /Q "%1\*" 1> nul || goto :error
) else (
	mkdir "%1" 1> nul || goto :error
)
