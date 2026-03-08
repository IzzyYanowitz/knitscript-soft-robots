# A short file for quick dat conversion
from knit_script.interpret import knit_script_to_knitout, knit_script_to_knitout_to_dat
from knit_script.knit_graphs.knit_graph_viz import visualize_sheet

source_dir = "_my_projects/lace/lace_stitches_test/" # this is the folder the .ks file is located in. Make sure this path ends with a /
title = "lace_st_test" # this is the name of the project and .ks file
#source_dir = "tutorial-code/3_eyelets/3_1_lefteyelets/" 



# This outputs a dat file, converts to k first then dat
knit_graph, _machine_state = knit_script_to_knitout_to_dat(source_dir + title + ".ks", 
                                                           source_dir + title + ".k",
                                                           source_dir + title + ".dat", 
                                                           pattern_is_filename=True)


# visualize_sheet(knit_graph, source_dir + title + ".png")
# This generates a visualization .png
