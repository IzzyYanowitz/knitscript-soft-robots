from knit_script.interpret import knit_script_to_knitout, knit_script_to_knitout_to_dat


save_in_usb = True # whether to save the knitout and dat files in the usb drive. If False, they will be saved in the directory specified by folder and filename.
save_k = False # saves the k file as filename.k if true. otherwise, as program_for_dat.k which may be overwritten by other runs. the .k file is useful for debugging. 

filename = "stk_square_c3" # of the .ks file




# leave these two variables below untouched
dat_save_path = "dat_files/" + filename + ".dat"
knitout_name = "program_for_dat.k"

if save_in_usb:
    dat_save_path = "D:/Student Work/Yuki Yu/dat files from knitscript/" + filename + ".dat" # change this to be your folder in the USB drive

if save_k:
    knitout_name = filename + ".k"


try:
    
    knit_graph, _machine_state = knit_script_to_knitout_to_dat(
        pattern = filename + ".ks", 
        knitout_name = knitout_name, 
        dat_name = dat_save_path, 
        pattern_is_filename = True,
    )
except Exception as e:
    print(f"Error: {e}")
