# A short file for quick dat conversion
from knit_script.interpret import knit_script_to_knitout, knit_script_to_knitout_to_dat
from knit_script.knit_graphs.knit_graph_viz import visualize_sheet

from knit_script.knitting_machine.machine_specification.Header_ID import Header_ID
from knit_script.knitting_machine.machine_components.machine_position import Machine_Position

import os;

save_in_usb = False

home = "/Users/izzyyanowitz/knitscript-soft-robots/_my_projects/"


file_folder = "test_files/half_gauge_tubes/garder_cable/" # this is the folder the .ks file is located in. Make sure this path ends with a /
source_dir = home + file_folder
output_dir = home + file_folder
title = "garder_cable" # this is the name of the project and .ks file
version = ""
position = Machine_Position.Right

if save_in_usb:
    output_dir = "/Volumes/NO NAME/Student Work/Izzy Yanowitz/" + file_folder

if os.path.isdir(source_dir):
    if not os.path.isdir(output_dir + version):
        os.makedirs(output_dir + version)

    if not os.path.isdir(source_dir + version):
        os.mkdir(source_dir + version)


# This outputs a dat file, converts to k first then dat
knit_graph, _machine_state = knit_script_to_knitout_to_dat(source_dir + title + ".ks", 
                                                           source_dir + version + "/" + title + ".k",
                                                           output_dir + version + "/" + title + ".dat", 
                                                           pattern_is_filename=True,
                                                           header_values={Header_ID.Position : position})


# visualize_sheet(knit_graph, source_dir + title + ".png")
# This generates a visualization .png
