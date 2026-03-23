# A short file for quick dat conversion
from knit_script.interpret import knit_script_to_knitout, knit_script_to_knitout_to_dat
from knit_script.knit_graphs.knit_graph_viz import visualize_sheet
import os;


source_dir = "_my_projects/lace/simple_lace/" # this is the folder the .ks file is located in. Make sure this path ends with a /
title = "simple_lace" # this is the name of the project and .ks file
version = ""
if not os.path.isdir(source_dir + version):
    os.mkdir(source_dir + version)


# This outputs a dat file, converts to k first then dat
knit_graph, _machine_state = knit_script_to_knitout_to_dat(source_dir + title + ".ks", 
                                                           source_dir + version + "/" + title + version + ".k",
                                                           source_dir + version + "/" + title + version + ".dat", 
                                                           pattern_is_filename=True)


# visualize_sheet(knit_graph, source_dir + title + ".png")
# This generates a visualization .png
