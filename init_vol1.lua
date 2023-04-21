local exe1_font = bnlc_mod_loader.read_mod_contents("exe1\\font_eng_00.pak")
bnlc_mod_loader.write_exe_dat_contents("exe1.dat", "exe1/data/ui/font_eng_00.pak", exe1_font)

local exe2_font = bnlc_mod_loader.read_mod_contents("exe2\\font_eng_00.pak")
bnlc_mod_loader.write_exe_dat_contents("exe2j.dat", "exe2j/data/ui/font_eng_00.pak", exe2_font)

local exe3_font = bnlc_mod_loader.read_mod_contents("exe3\\font_eng_00.pak")
local exe3_menu_spr = bnlc_mod_loader.read_mod_contents("exe3\\menu_spr_jap_00.pak")
bnlc_mod_loader.write_exe_dat_contents("exe3.dat", "exe3/data/ui/font_eng_00.pak", exe3_font)
bnlc_mod_loader.write_exe_dat_contents("exe3b.dat", "exe3b/data/ui/font_eng_00.pak", exe3_font)
bnlc_mod_loader.write_exe_dat_contents("exe3.dat", "exe3/data/ui/menu_spr_jap_00.pak", exe3_menu_spr)
bnlc_mod_loader.write_exe_dat_contents("exe3b.dat", "exe3b/data/ui/menu_spr_jap_00.pak", exe3_menu_spr)
