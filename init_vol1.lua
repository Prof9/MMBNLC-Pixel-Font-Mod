local exe1_dat = chaudloader.exedat.open("exe1.dat")
local exe2j_dat = chaudloader.exedat.open("exe2j.dat")
local exe3_dat = chaudloader.exedat.open("exe3.dat")
local exe3b_dat = chaudloader.exedat.open("exe3b.dat")

local exe1_font = chaudloader.modfiles.read_file("exe1\\font_eng_00.pak")
exe1_dat:write_file("exe1/data/ui/font_eng_00.pak", exe1_font)

local exe2_font = chaudloader.modfiles.read_file("exe2\\font_eng_00.pak")
exe2j_dat:write_file("exe2j/data/ui/font_eng_00.pak", exe2_font)

local exe3_font = chaudloader.modfiles.read_file("exe3\\font_eng_00.pak")
local exe3_menu_spr = chaudloader.modfiles.read_file("exe3\\menu_spr_jap_00.pak")
exe3_dat:write_file("exe3/data/ui/font_eng_00.pak", exe3_font)
exe3b_dat:write_file("exe3b/data/ui/font_eng_00.pak", exe3_font)
exe3_dat:write_file("exe3/data/ui/menu_spr_jap_00.pak", exe3_menu_spr)
exe3b_dat:write_file("exe3b/data/ui/menu_spr_jap_00.pak", exe3_menu_spr)
